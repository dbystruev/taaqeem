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
        const sheet = SpreadsheetApp.getActiveSpreadsheet();

        // Check maybe not needed, but just for case
        if (!sheet) throw 'Can\'t open the plans sheet';

        // Find the token hash from spreadsheet
        const savedTokenHash = sheet.getRange('B1').getCell(1, 1).getValue();

        // Find the hash of the incoming token (byte to hex https://stackoverflow.com/a/51863912)
        const tokenHash = Utilities.computeDigest(Utilities.DigestAlgorithm.SHA_512, token)
            .map(function (chr) { return (256 + chr).toString(16).slice(-2) })
            .join('');

        // Check if the tokens match
        if (savedTokenHash != tokenHash) throw `Token is not correct`;

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
            'version': version,
        };

    } catch (error) {
        result = { 'status': 'ERROR', 'message': 'Plans: ' + error };
    }

    // Return result
    return ContentService
        .createTextOutput(JSON.stringify(result))
        .setMimeType(ContentService.MimeType.JSON);
}