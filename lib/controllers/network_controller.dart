//
//  lib/controllers/network_controllers.dart
//
//  Created by Denis Bystruev on 19/04/2020.
//
//  Derived from https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d
//

import 'dart:convert' as convert;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/app_data.dart';
import 'package:taaqeem/models/order.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/models/server_data.dart';
import 'package:taaqeem/models/user.dart';
import 'package:taaqeem/models/user_feedback.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkController {
  // Last submitted feedback and order
  UserFeedback lastUserFeedback = UserFeedback(null);
  Order lastOrder = Order();

  static final NetworkController shared = NetworkController();
  bool requestIsBeingProcessed = false;
  final String url;

  // Default constructor
  NetworkController({
    // Google Apps Script web url
    this.url = 'https://script.google.com/macros/s/' +
        'AKfycbyVJAPvLhbZtKwJ6-p00NERFQbEK22B4xTdkTL4ReHYYdKMRIV8' +
        '/exec',
  });

  void dispose() {}

  void awaitRequestCompletion() async {
    while (requestIsBeingProcessed)
      await Future.delayed(
        Duration(seconds: 1),
      );
  }

  // Async function which returns feedback and plans urls
  Future<AppData> getAppData({
    String appName = globals.appName,
    String appPassword = globals.appPassword,
  }) async {
    awaitRequestCompletion();
    requestIsBeingProcessed = true;
    try {
      final String request = '$url?appName=$appName&password=$appPassword';
      http.Response response = await http.get(request);
      final Map<String, dynamic> appDataMap = convert.jsonDecode(response.body);
      return AppData.fromJson(appDataMap);
    } catch (error) {
      return AppData(globals.statusError, message: error.toString());
    } finally {
      requestIsBeingProcessed = false;
    }
  }

  // Calculate SHA-512 digest
  static String getHash(String token) {
    final List<int> bytes = convert.utf8.encode(token);
    final Digest digest = sha512.convert(bytes);
    final String hash = digest.toString();
    return hash;
  }

  // Async function which returns the plans
  Future<Plans> getPlans({
    String responseToken,
    String token,
    String url,
  }) async {
    awaitRequestCompletion();
    requestIsBeingProcessed = true;
    try {
      final String request = '$url?token=$token&responseToken=$responseToken';
      http.Response response = await http.get(request);
      final Map<String, dynamic> plansMap = convert.jsonDecode(response.body);
      return Plans.fromJson(plansMap);
    } catch (error) {
      return Plans([], message: error.toString(), status: globals.statusError);
    } finally {
      requestIsBeingProcessed = false;
    }
  }

  // Get requests: authorization SMS and token
  Future<ScreenData> getRequest({
    Map<String, String> query,
    @required ScreenData screenData,
  }) async {
    if (requestIsBeingProcessed) return screenData;
    requestIsBeingProcessed = true;
    final http.Client client = http.Client();
    try {
      final String generatedCode =
          query == null ? null : query['generatedCode'];
      final String phone = query == null ? null : query['phone'];
      final String responseCode = query == null ? null : query['responseCode'];
      final String request = screenData.url +
          (generatedCode == null ? '' : '&generatedCode=$generatedCode') +
          (phone == null ? '' : '&phone=${Uri.encodeQueryComponent(phone)}') +
          (responseCode == null ? '' : '&responseCode=$responseCode');
      final http.Response response = await client.get(request);
      screenData = getScreenDataFromResponse(response, screenData: screenData);
    } catch (error) {
      screenData = ScreenData.over(
        screenData,
        lastError: error.toString(),
        lastErrorTime: DateTime.now(),
      );
    } finally {
      client.close();
      requestIsBeingProcessed = false;
    }
    return screenData;
  }

  // Calculate the response token based on the incoming token
  String getResponseToken(String token) {
    // Calculate the token hash
    final String tokenHash = getHash(token);

    // Split the token hash to array for easier replacement
    final List<String> hash = tokenHash.split('');

    // Calculate the hash length
    final int len = hash.length;

    // Calculate the response token
    hash[305 % len] = hash[1973 % len];
    hash[708 % len] = hash[1975 % len];
    hash[1310 % len] = hash[2000 % len];
    hash[303 % len] = hash[2012 % len];

    // Assemble the hash array back to String
    final String hashString = hash.join();

    // Return the hash of calculated response
    return getHash(hashString);
  }

  ScreenData getScreenDataFromResponse(
    http.Response response, {
    @required ScreenData screenData,
  }) {
    final Map<String, dynamic> appDataMap = convert.jsonDecode(response.body);
    final AppData appData = AppData.fromJson(appDataMap);
    if (appData.status != globals.statusSuccess) throw appData.message;
    return ScreenData.fromServerData(screenData, appData.serverData);
  }

  static Future<String> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      return '';
    } else
      return 'Could not launch $url';
  }

  Future<http.Response> postAndRedirect(
    ServerData serverData, {
    String url,
  }) async {
    http.Response response =
        await NetworkController.shared.postServerData(serverData, url: url);
    int statusCode = response.statusCode;
    String uri = response.headers['location'];
    int count = 0;
    while (300 <= statusCode && statusCode < 400 && ++count < 10) {
      response = await http.get(uri);
      statusCode = response.statusCode;
      uri = response.headers['location'];
    }
    return response;
  }

  Future<ScreenData> loadPrefs() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // get user's phone and token
    final String email = prefs.getString('email');
    final int id = prefs.getInt('id');
    final String name = prefs.getString('name');
    final String phone = prefs.getString('phone');
    final String token = prefs.getString('token');

    debugPrint(
      'lib/controllers/network_controllers.dart:200 loadPrefs() ' +
          'email = $email, id = $id, name = $name, phone = $phone, token = $token',
    );

    final ScreenData screenData = ScreenData(
      user: User(
        email: email,
        id: id,
        name: name,
        phone: phone,
        token: token,
      ),
    );

    debugPrint(
      'lib/controllers/network_controllers.dart:215 loadPrefs()' +
          'screenData.user = ${screenData.user}',
    );

    return screenData;
  }

  // Async function which posts the server data
  Future<http.Response> postServerData(
    ServerData serverData, {
    String url,
  }) async {
    try {
      final String body = convert.json.encode({'serverData': serverData});
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

  // Main post request
  Future<ScreenData> postRequest(ScreenData screenData) async {
    if (requestIsBeingProcessed) return screenData;
    requestIsBeingProcessed = true;
    try {
      if (lastOrder.isSimilar(screenData.order))
        screenData.order.id = lastOrder.id;
      if (lastUserFeedback.isSimilar(screenData.userFeedback))
        screenData.userFeedback.id = lastUserFeedback.id;
      final String userToken = screenData.user.token;
      final String url = screenData.url + '&userToken=$userToken';
      ServerData serverData = ServerData.fromScreenData(screenData);
      final http.Response response =
          await postAndRedirect(serverData, url: url);
      screenData = getScreenDataFromResponse(response, screenData: screenData);
    } catch (error) {
      screenData = ScreenData.over(
        screenData,
        lastError: error.toString(),
        lastErrorTime: DateTime.now(),
      );
    } finally {
      if (screenData.order?.id != null) {
        if (lastOrder.isSimilar(screenData.order)) {
          lastOrder.id = screenData.order.id;
          screenData.order.id = null;
        } else
          lastOrder.copy(screenData.order);
      }
      if (screenData.userFeedback?.id != null) {
        if (lastUserFeedback.isSimilar(screenData.userFeedback)) {
          lastUserFeedback.id = screenData.userFeedback.id;
          screenData.userFeedback.id = null;
        } else
          lastUserFeedback.copy(screenData.userFeedback);
      }
      requestIsBeingProcessed = false;
    }
    return screenData;
  }

  void removePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('phone');
    prefs.remove('token');
    debugPrint('lib/controllers/network_controllers.dart:289 removePrefs()');
  }

  void savePrefs(ScreenData screenData) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    final String email = screenData.user.email;
    final int id = screenData.user.id;
    final String name = screenData.user.name;
    final String phone = screenData.user.phone;
    final String token = screenData.user.token;

    // save user's phone and token
    prefs.setString('email', email);
    prefs.setInt('id', id);
    prefs.setString('name', name);
    prefs.setString('phone', phone);
    prefs.setString('token', token);

    debugPrint(
      'lib/controllers/network_controllers.dart:310 savePrefs() ' +
          'email = $email, id = $id, name = $name, phone = $phone, token = $token',
    );
  }
}
