//
//  lib/controllers/network_controllers.dart
//
//  Created by Denis Bystruev on 19/04/2020.
//
//  Derived from https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d
//

import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/app_data.dart';
import 'package:taaqeem/models/plan.dart';
import 'package:taaqeem/models/plans.dart';

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

  // Async function which returns feedback and plans urls
  Future<AppData> getAppData({
    String appName = globals.appName,
    String appPassword = globals.appPassword,
  }) async {
    try {
      final String request = '$url?appName=$appName&password=$appPassword';
      http.Response response = await http.get(request);
      final Map<String, dynamic> appDataMap = convert.jsonDecode(response.body);
      return AppData.fromJson(appDataMap);
    } catch (error) {
      return AppData('ERROR', message: error.toString());
    }
  }

  // Async function which returns the plans
  Future<Plans> getPlans({
    String token,
    String url,
  }) async {
    try {
      final String request = '$url?token=$token';
      http.Response response = await http.get(request);
      final Map<String, dynamic> plansMap = convert.jsonDecode(response.body);
      return Plans.fromJson(plansMap);
    } catch (error) {
      return Plans([], message: error.toString(), status: 'ERROR');
    }
  }
}
