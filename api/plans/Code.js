//
//  api/plans/Code.js
//
//  Created by Denis Bystruev on 19/04/2020.
//

// Derived from https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d
function doGet(request) {
    function nonEmpty(value) {
        return value || value === 0 || value === false ? value : undefined;
    }

    // Failing by default
    let message = 'default';
    let result = { 'status': 'FAILED', 'message': message };

    try {
        // Get the query parameters
        const token = request.parameter.token;

        // Check the parameters
        if (!token) throw 'token should not be empty';

        // Open Google sheet bound with this script
        const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('Plans');

        // Check maybe not needed, but just for case
        if (!sheet) throw 'Can\'t open the plans sheet';

        // Find the token hash from spreadsheet
        const savedTokenHash = sheet.getRange('B1').getCell(1, 1).getValue();

        // Find the hash of the incoming token (byte to hex https://stackoverflow.com/a/51863912)
        const tokenHash = Utilities.computeDigest(Utilities.DigestAlgorithm.SHA_512, token)
            .map(function (chr) { return (256 + chr).toString(16).slice(-2) })
            .join('');

        // Check if the tokens match
        if (savedTokenHash != tokenHash) throw 'Token is not correct';

        // Get the version number
        const version = sheet.getRange('B2').getCell(1, 1).getValue();

        // Define range where we'll get the plans from
        const firstRow = sheet.getFrozenRows() + 1;
        const lastRow = sheet.getLastRow();
        const range = sheet.getRange('A' + firstRow + ':G' + lastRow);

        // Get the values for all plans
        const rangeValues = range.getValues();

        // Map each row of rangeValues to an obect
        const plans = rangeValues.map(function (rowValues) {
            return {
                'id': nonEmpty(rowValues[0]),
                'type': nonEmpty(rowValues[1]),
                'title': nonEmpty(rowValues[2]),
                'subtitle': nonEmpty(rowValues[3]),
                'icon': nonEmpty(rowValues[4]),
                'image': nonEmpty(rowValues[5]),
                'description': nonEmpty(rowValues[6])
            }
        });

        result = {
            'message': message,
            'plans': plans,
            'status': 'SUCCESS',
            'time': Math.floor(new Date().getTime() / 1000),
            'version': version,
        };

    } catch (error) {
        result = {
            'message': 'Plans: ' + error,
            'status': 'ERROR',
            'time': Math.floor(new Date().getTime() / 1000)
        };
    }

    // Return result
    return ContentService
        .createTextOutput(JSON.stringify(result))
        .setMimeType(ContentService.MimeType.JSON);
}

// Derived from https://webapps.stackexchange.com/a/117630
function onEdit(event) {

    // Pads the value with 0 if value < 10
    function padded(value) {
        return value < 10 ? '0' + value : value;
    }

    // Return if event is null/empty
    if (!event) return;

    // Get the sheet for date cell
    const sheet = event.source.getSheetByName('Plans');

    // Get the cell where version is located
    const range = sheet.getRange('B2');

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
    range.setValue(version);

    return true;
}