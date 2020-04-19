//
//  lib/controllers/network_controllers.dart
//
//  Created by Denis Bystruev on 19/04/2020.
//
//  Derived from https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d
//

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:taaqeem/globals.dart' as globals;

class NetworkController {
  // Status success message
  static const STATUS_SUCCESS = 'SUCCESS';

  // Google Apps Script web url
  final String url;

  // Default constructor
  NetworkController({
    this.url = 'https://script.google.com/macros/s/' +
        'AKfycbyVJAPvLhbZtKwJ6-p00NERFQbEK22B4xTdkTL4ReHYYdKMRIV8' +
        '/exec',
  });

  // Async function which returns plans and feedback sheet ids
  void getSheetIds(
      // Callback function to return response of current request
      {
    String appName = globals.appName,
    String appPassword = globals.appPassword,
    Function(
      String status, {
      String feedbackId,
      String feedbackUrl,
      String message,
      String plansId,
      String plansUrl,
    })
        callback,
  }) async {
    try {
      final String request = '$url?appName=$appName&password=$appPassword';
      print(
          'DEBUG in lib/controllers/network_controller.dart line 46: request = $request');
      await http.get(request).then((http.Response response) {
        final Map<String, dynamic> body = convert.jsonDecode(response.body);
        final String feedbackId = body['feedbackId'].toString();
        final String feedbackUrl = body['feedbackUrl'].toString();
        final String message = body['message'].toString();
        final String plansId = body['plansId'].toString();
        final String plansUrl = body['plansUrl'].toString();
        final String status = body['status'].toString();
        callback(
          status,
          feedbackId: feedbackId,
          feedbackUrl: feedbackUrl,
          message: message,
          plansId: plansId,
          plansUrl: plansUrl,
        );
      });
    } catch (error) {
      print('ERROR in lib/controllers/network_controller.dart line 65: $error');
      callback('FAIL', message: error);
    }
  }
}
