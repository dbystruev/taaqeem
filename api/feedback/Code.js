//
//  api/plans/Code.js
//
//  Created by Denis Bystruev on 19/04/2020, updated on 03/05/2020.
//

// Derived from https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d
function doPost(request) {
    // Failing by default
    let feedbackSheet;
    let ordersSheet;
    let usersSheet;

    let message = '';
    let result = { 'status': 'FAILED', 'message': message };

    try {
        // Get the query parameters
        const token = request.parameter.token;

        // Check the parameters
        if (!token) throw 'token should not be empty';

        // Open Google Sheet bound with this script
        const mainSheet = SpreadsheetApp.getActiveSpreadsheet();

        // Check maybe not needed, but just for case
        if (!mainSheet) throw 'Can\'t open the quiz sheet';

        // Get the Answers & Questions sheets
        feedbackSheet = mainSheet.getSheetByName('Feedback');
        ordersSheet = mainSheet.getSheetByName('Orders');
        usersSheet = mainSheet.getSheetByName('Users');

        if (!feedbackSheet || !ordersSheet || !usersSheet)
            throw 'The spreadsheet should have Feedback, Orders, and Users sheets';

        // Find the token hash from spreadsheet
        const savedTokenHash = getTokenRange(feedbackSheet).getValue();

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

        // Check if feedback is present
        if (serverData.feedback) {
            message += 'serverData.feedback is found\n';

            // Update version in the sheet
            updateVersion(feedbackSheet);
        }

        // Check if order is present
        if (serverData.order) {
            message += 'serverData.order is found\n';

            // Update version in the sheet
            updateVersion(ordersSheet);
        }

        // Check if user is present
        if (serverData.user) {
            message += 'serverData.user is found\n';

            // Update version in the sheet
            updateVersion(userSheet);
        }

        // Set the success response
        result = {
            'message': message,
            'status': 'SUCCESS',
            'time': Math.floor(new Date().getTime() / 1000)
        }

    } catch (error) {
        result = {
            'message': 'Feedback API: ' + error,
            'status': 'ERROR',
            'time': Math.floor(new Date().getTime() / 1000)
        };
    }

    // Return result
    return ContentService
        .createTextOutput(JSON.stringify(result))
        .setMimeType(ContentService.MimeType.JSON);
}

function getTokenRange(sheet) {
    return sheet.getRange('C2');
}

function getVersionRange(sheet) {
    return sheet.getRange('C1');
}

function nonEmpty(value) {
    return value || value === 0 || value === false ? value : undefined;
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