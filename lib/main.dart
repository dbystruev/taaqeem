//
//  lib/main.dart
//
//  Created by Denis Bystruev on 16/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/controllers/network_controller.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/screens/launch_screen.dart';

void main() {
  final NetworkController networkController = NetworkController();
  networkController.getAppData(callback: (
    String status, {
    String feedbackUrl,
    String message,
    String plansUrl,
    String version,
  }) {
    debugPrint(
      'DEBUG in lib/main.dart line 22: $status' +
          ', feedbackUrl = $feedbackUrl' +
          ', plansUrl = $plansUrl' +
          ', version = $version' +
          '\n$message',
    );
  });
  runApp(
    Main(),
  );
}

class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LaunchScreen(),
      title: 'Taqeem',
      theme: ThemeData(
        accentColor: globals.accentColor,
        primaryColor: globals.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
