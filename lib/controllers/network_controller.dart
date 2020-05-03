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
import 'package:taaqeem/models/app_data.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/models/server_data.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkController {
  // Google Apps Script web url
  static final NetworkController shared = NetworkController();
  final String url;

  // Default constructor
  NetworkController({
    this.url = 'https://script.google.com/macros/s/' +
        'AKfycbyVJAPvLhbZtKwJ6-p00NERFQbEK22B4xTdkTL4ReHYYdKMRIV8' +
        '/exec',
  });

  void dispose() {}

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
      return AppData(globals.statusError, message: error.toString());
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
      return Plans([], message: error.toString(), status: globals.statusError);
    }
  }

  static Future<String> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      return '';
    } else
      return 'Could not launch $url';
  }

  // Async function which posts the server data
  Future<http.Response> postServerData(
    ServerData serverData, {
    String url,
  }) async {
    try {
      final String body = convert.json.encode(serverData);
      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final http.Response response =
          await http.post(url, body: body, headers: headers);
      return response;
    } catch (error) {
      http.Response response = http.Response(error.toString(), 400);
      return response;
    }
  }

  Future<http.Response> postAndRedirect(ServerData serverData, {String url}) async {
    http.Response response =
        await NetworkController.shared.postServerData(serverData, url: url);
    int statusCode = response.statusCode;
    String uri = response.headers['location'];
    int count = 0;
    print('url = $url');
    while (300 <= statusCode && statusCode < 400 && ++count < 10) {
      print('count = $count, uri = $uri');
      response = await http.get(uri);
      statusCode = response.statusCode;
      uri = response.headers['location'];
    }
    return response;
  }
}
