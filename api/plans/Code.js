//
//  api/plans/Code.js
//
//  Created by Denis Bystruev on 19/04/2020.
//

// Derived from https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d
function doGet(request) {
    // Plans google sheet https://docs.google.com/spreadsheets/d/14U-ou_VEdnUiUrhRnok3sDyvuE2xrDQ9rVbWWBHeeqc/edit
    const googleSheetId = '14U-ou_VEdnUiUrhRnok3sDyvuE2xrDQ9rVbWWBHeeqc';

    // Failing by default
    let message = 'Unknown';
    let result = { 'status': 'FAILED', 'message': message };

    try {
        // Get the query parameters
        const token = request.parameter.token;

        // Check the parameters
        if (token == null || token == '') {
            throw 'token should not be empty';
        }

        // Open Google Sheet using ID
        const sheet = SpreadsheetApp.openById(googleSheetId);

        // Check maybe not needed, but just for case
        if (sheet == null) {
            throw `Can't open the plans sheet with id ${googleSheetId}`
        }

        // Find the token hash from spreadsheet
        const savedTokenHash = sheet.getRange('B1').getCell(1, 1).getValue();

        // Find the hash of the incoming token (byte to hex https://stackoverflow.com/a/51863912)
        const tokenHash = Utilities.computeDigest(Utilities.DigestAlgorithm.SHA_512, token)
            .map(function (chr) { return (256 + chr).toString(16).slice(-2) })
            .join('');

        // Check if the tokens match
        if (savedTokenHash != tokenHash) {
            throw `Token is not correct`;
        }

        // Get the version number
        const version = sheet.getRange('B2').getCell(1, 1).getValue();

        // Define range where we'll get the plans from
        const firstRow = sheet.getFrozenRows() + 1;
        const lastRow = sheet.getLastRow();
        const range = sheet.getRange('A' + firstRow + ':G' + lastRow);

        // DEBUG
        message = 'range.getNumRows() = ' + range.getNumRows() +
            ', range.getNumColumns() = ' + range.getNumColumns();

        // Get the values for all plans
        const rangeValues = range.getValues();

        // Map each row of rangeValues to an obect
        const plans = rangeValues.map(function (rowValues) {
            return {
                'id': rowValues[0],
                'type': rowValues[1],
                'title': rowValues[2],
                'subtitle': rowValues[3],
                'icon': rowValues[4],
                'image': rowValues[5],
                'description': rowValues[6]
            }
        });

        result = {
            'message': message,
            'plans': plans,
            'status': 'SUCCESS',
            'version': version,
        };

    } catch (error) {
        result = { 'status': 'ERROR', 'message': message + '\n' + error };
    }

    // Return result
    return ContentService
        .createTextOutput(JSON.stringify(result))
        .setMimeType(ContentService.MimeType.JSON);
}