//
//  api/plans/Code.js
//
//  Created by Denis Bystruev on 19/04/2020, updated on 03/05/2020.
//

// Derived from https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d

// This script address is https://script.google.com/macros/s/AKfycbxOsCVWSMfnCtBukCquUOG83g8R8C33faOkDkhVZfr8ZBSZbv8/exec

// Removes all non-digits and returns a string of pure digits
function digits(digitsWithNoise) {
    const regexp = /[^\d]/g;
    return digitsWithNoise.toString().replace(regexp, '');
}

function doGet(request) {
    // Make user sheet available outside of try/catch block
    let userSheet;

    // Failing by default
    let message = '';
    let response = { 'status': 'FAILED', 'message': message };

    try {
        // Get the token from query parameters
        const token = request.parameter.token;

        // Check for the token presense
        if (!token) throw 'token should not be empty';

        // Open Google Sheet bound with this script
        const mainSheet = SpreadsheetApp.getActiveSpreadsheet();

        // Check maybe not needed, but just for case
        if (!mainSheet) throw 'Can\'t open the main sheet';

        // Get the users sheet
        userSheet = mainSheet.getSheetByName('Users');

        if (!userSheet)
            throw 'The main spreadsheet should have at least users sheet';

        // Find the token hash from spreadsheet
        const savedTokenHash = getTokenRange(userSheet).getValue();

        // Find the hash of the incoming token (byte to hex https://stackoverflow.com/a/51863912)
        const tokenHash = Utilities.computeDigest(Utilities.DigestAlgorithm.SHA_512, token)
            .map(function (chr) { return (256 + chr).toString(16).slice(-2) })
            .join('');

        // Check if the tokens match
        if (savedTokenHash != tokenHash) throw `Token is not correct`;

        // Get the phone from query parameters
        const phone = request.parameter.phone;

        // Check for the phone presense
        if (isEmpty(phone)) throw 'The phone field should not be empty';

        // Check if phone has 9 or 10 digits
        const phoneDigits = digits(phone);
        const phoneDigitsLength = phoneDigits.length;
        if (phoneDigitsLength < 9 || 10 < phoneDigitsLength)
            throw 'The phone should have 9 or 10 digits';

        // Define the range where we'll get the users from
        const firstRow = userSheet.getFrozenRows() + 1;
        const lastRow = userSheet.getLastRow();
        const numberOfRows = lastRow < firstRow ? 1 : lastRow - firstRow + 1;
        const userRange = userSheet.getRange(firstRow, 1, numberOfRows, 6);

        // Get the users for the whole range
        const userRangeValues = userRange.getValues();

        // Get the users whose phone matches
        let matchingUser = userRangeValues.find(row => digits(row[4]) == phoneDigits);

        // Creatr user object for future response
        let user = {};

        // Check if any matching users found
        if (isNotEmpty(matchingUser) && 5 < matchingUser.length) {
            // Get matching user's id
            const userId = matchingUser[0];

            // Check that the user id is present
            if (isEmpty(userId)) throw 'User id for the given phone number is empty';

            // Fill user object with data
            user = {
                'id': nonEmpty(userId),
                'avatar': nonEmpty(matchingUser[1]),
                'email': nonEmpty(matchingUser[2]),
                'name': nonEmpty(matchingUser[3]),
                'phone': nonEmpty(matchingUser[4]),
                'registrationDate': nonEmpty(matchingUser[5])
            }
        } else {
            // No users matched, create new user
            // We'll need the number of frozen/filled rows
            const filledRows = userSheet.getLastRow();
            const frozenRows = userSheet.getFrozenRows();

            // Calculate the id of the last user in the table
            const lastUserId = filledRows - frozenRows;

            // No user id is found — increment the top user id from the table
            const userId = lastUserId + 1;

            // Create the user registration date as now
            const registrationDate = Date();

            // Compose a row for appending to the table
            const row = [userId, null, null, null, phone, registrationDate];

            // Add row to the table
            userSheet.appendRow(row);

            // Update version in the user sheet
            updateVersion(userSheet);

            // Fill the new user object with data we know so far
            user = {
                'id': userId,
                'phone': phone,
                'registrationDate': registrationDate
            }
        }

        // Overwrite the response with the user and success status
        response = Object.assign({},
            response,
            {
                'message': message,
                'serverData': { 'user': user },
                'status': 'SUCCESS',
                'time': Math.floor(new Date().getTime() / 1000)
            });

    } catch (error) {
        // Overwrite the response with the error status
        response = Object.assign({},
            response,
            {
                'message': 'Feedback API: ' + error,
                'status': 'ERROR',
                'time': Math.floor(new Date().getTime() / 1000)
            });

    }
    // Return result
    return ContentService
        .createTextOutput(JSON.stringify(response))
        .setMimeType(ContentService.MimeType.JSON);
}

function doPost(request) {
    // Make sheets available outside of try/catch block
    let orderSheet;
    let userFeedbackSheet;
    let userSheet;

    // Failing by default
    let dataFound = false;
    let message = '';
    let response = { 'status': 'FAILED', 'message': message };

    try {
        // Get the token from query parameters
        const token = request.parameter.token;

        // Check for the token presense
        if (!token) throw 'token should not be empty';

        // Open Google Sheet bound with this script
        const mainSheet = SpreadsheetApp.getActiveSpreadsheet();

        // Check maybe not needed, but just for case
        if (!mainSheet) throw 'Can\'t open the main sheet';

        // Get the order, user, and user feedback sheets
        orderSheet = mainSheet.getSheetByName('Orders');
        userFeedbackSheet = mainSheet.getSheetByName('Feedback');
        userSheet = mainSheet.getSheetByName('Users');

        if (!orderSheet || !userFeedbackSheet || !userSheet)
            throw 'The spreadsheet should have Feedback, Orders, and Users sheets';

        // Find the token hash from spreadsheet
        const savedTokenHash = getTokenRange(userSheet).getValue();

        // Find the hash of the incoming token (byte to hex https://stackoverflow.com/a/51863912)
        const tokenHash = Utilities.computeDigest(Utilities.DigestAlgorithm.SHA_512, token)
            .map(function (chr) { return (256 + chr).toString(16).slice(-2) })
            .join('');

        // Check if the tokens match
        if (savedTokenHash != tokenHash) throw `Token is not correct`;

        // Get the questions data
        const jsonString = request.postData.getDataAsString();

        // Parse the POST body
        const body = JSON.parse(jsonString);
        const serverData = body.serverData;

        // Check if we have serverData container
        if (isEmpty(serverData)) throw 'No serverData is found';

        // Check if order is present
        const order = serverData.order;
        if (isNotEmpty(order)) {
            dataFound = true;

            // Compose the row of order data
            // ID is the number of filled rows minus the number of frozen rows + 1
            const filledRows = orderSheet.getLastRow();
            const frozenRows = orderSheet.getFrozenRows();
            const orderId = filledRows - frozenRows + 1;

            // Update the response with Order ID
            response = Object.assign({}, response,
                { 'server_data': { 'order': { 'id': orderId } } }
            );

            // User ID is the identifier of the corresponding user
            const user = serverData.user;

            // Check that the user is present
            if (isEmpty(user)) throw 'No user for order in serverData';
            const userId = user.id;

            // Cleaning date is the date for cleaning
            const cleaningDate = order.cleaningDate;

            // Creation date is the date of order creation
            const creationDate = order.creationDate;

            // Meters is the user's square meters
            const meters = order.meters;

            // Plan ID is the ID of the plan the user has selected
            const planId = order.planId;

            // Service is the service the user has selected
            const service = order.service;

            // Compose and add the row
            const row = [orderId, userId, cleaningDate, creationDate, meters, planId, service];
            orderSheet.appendRow(row);

            // Update version in the order sheet
            updateVersion(orderSheet);
        }

        // Check if userFeedback is present
        const userFeedback = serverData.userFeedback;
        if (isNotEmpty(userFeedback)) {
            dataFound = true;

            // Compose the row of user feedback data
            // ID is the number of filled rows minus the number of frozen rows + 1
            const filledRows = userFeedbackSheet.getLastRow();
            const frozenRows = userFeedbackSheet.getFrozenRows();
            const feedbackId = filledRows - frozenRows + 1;

            // Update the response with Feedback ID
            response = Object.assign({}, response,
                { 'server_data': { 'userFeedback': { 'id': feedbackId } } }
            );

            // User ID is the identifier of the corresponding user
            const user = serverData.user;

            // Check that the user is present
            if (isEmpty(user)) throw 'No user for feedback in serverData';
            const userId = user.id;

            // Date is the date when the feedback was left
            const date = userFeedback.date;

            // Text is the user's message
            const text = userFeedback.text;

            // Compose and add the row
            const row = [feedbackId, userId, date, text];
            userFeedbackSheet.appendRow(row);

            // Update the version (reveresed date with time) in the feedback sheet
            updateVersion(userFeedbackSheet);
        }

        // Check if the user is present and order/feedback are not
        const user = serverData.user;
        if (isNotEmpty(user) && isEmpty(order) && isEmpty(userFeedback)) {
            dataFound = true;

            // We'll need the number of frozen/filled rows for searching
            const filledRows = userSheet.getLastRow();
            const frozenRows = userSheet.getFrozenRows();

            // Calculate the id of the last user in the table
            const lastUserId = filledRows - frozenRows;

            // Get the user id from the load
            let userId = user.id;

            // Check if this user id is in the table
            if (isNotEmpty(userId)) {
                // If the given user id is outside of this range, that's an error
                if (userId < 1 || lastUserId < userId)
                    throw 'No userId ' + userId + 'in the table';

                // User's position in the table is their id + number of frozen rows
                const userRow = frozenRows + userId;

                // Get saved user data from the table
                const savedUserRange = userSheet.getRange(userRow, 1, 1, 6);
                let savedUserValues = savedUserRange.getValues();
                let savedUserRow = savedUserValues[0];

                // Sanity check if we got everything right
                if (userId != savedUserRow[0])
                    throw 'Found id '
                    + savedUserRow[0]
                    + ' in the position of user id '
                    + userId
                    + ' in user table';

                // Merge provided data with the table
                savedUserRow[1] = user.avatar == undefined ? savedUserRow[1] : user.avatar;
                savedUserRow[2] = user.email == undefined ? savedUserRow[2] : user.email;
                savedUserRow[3] = user.name == undefined ? savedUserRow[3] : user.name;
                savedUserRow[4] = user.phone == undefined ? savedUserRow[4] : user.phone;
                savedUserRow[5] = user.registrationDate == undefined ? savedUserRow[5] : user.registrationDate;

                // Save values back to the table
                savedUserValues = [savedUserRow];
                savedUserRange.setValues(savedUserValues);

            } else {
                // No user id is coming — increment the top user id from the table
                userId = lastUserId + 1;

                // Compose a row for appending to the table
                const avatar = user.avatar;
                const email = user.email;
                const name = user.name;
                const phone = user.phone;
                const registrationDate = user.registrationDate;
                const row = [userId, avatar, email, name, phone, registrationDate];

                // Add row to the table
                userSheet.appendRow(row);
            }

            // Update the response with the user ID
            response = Object.assign({}, response,
                { 'server_data': { 'user': { 'id': userId } } }
            );

            // Update version in the user sheet
            updateVersion(userSheet);
        }

        if (!dataFound) throw 'No order, user, or userFeedback data is found in serverData';

        // Overwrite the response with the success status
        response = Object.assign({},
            response,
            {
                'message': message,
                'status': 'SUCCESS',
                'time': Math.floor(new Date().getTime() / 1000)
            });

    } catch (error) {
        // Overwrite the response with the error status
        response = Object.assign({},
            response,
            {
                'message': 'Feedback API: ' + error,
                'status': 'ERROR',
                'time': Math.floor(new Date().getTime() / 1000)
            });
    }

    // Return result
    return ContentService
        .createTextOutput(JSON.stringify(response))
        .setMimeType(ContentService.MimeType.JSON);
}

function getTokenRange(sheet) {
    return sheet.getRange('D2');
}

function getVersionRange(sheet) {
    return sheet.getRange('D1');
}

function isEmpty(value) {
    return !isNotEmpty(value)
}

function nonEmpty(value) {
    return value || value === 0 || value === false ? value : undefined;
}

function isNotEmpty(value) {
    return value || value === 0 || value === false ? true : undefined;
}

// Derived from https://webapps.stackexchange.com/a/117630
function onEdit(event) {
    // Return if event is null/empty
    if (!event) return;

    // Get the sheet for date cell
    const sheet = event.source.getSheetByName('Feedback');

    // Update version
    return updateVersion(sheet);
}

// Pads the value with 0 if value < 10
function padded(value) {
    return value < 10 ? '0' + value : value;
}

function updateVersion(sheet) {
    // Calculate the version depending on date + time
    const date = new Date();
    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    const day = date.getDate();
    const hour = date.getHours();
    const minute = date.getMinutes();
    const second = date.getSeconds();
    const version = '' +
        year + padded(month) + padded(day) + padded(hour) + padded(minute) + padded(second);

    // Update the version cell
    getVersionRange(sheet).setValue(version);

    return true;
}