//
//  lib/screens/launch_screen.dart
//
//  Created by Denis Bystruev on 14/04/2020, updated 18/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/controllers/network_controller.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/plan.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> with Scale {
  bool tapped = false;
  final NetworkController networkController = NetworkController();

  @override
  Widget build(BuildContext context) {
    final double safeMargin = isHorizontal(context) ? 44 : 0;
    final double scale = getScale(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                height: 58 * scale,
                width: 135 * scale,
              ),
              left: 20 * scale + safeMargin,
              top: 30 * scale,
            ),
            Positioned(
              child: TheText.w600(
                colors: [null, globals.accentColor],
                texts: [
                  'Protect your\n',
                  'home &\nbusiness',
                  ' from\nGlobal virus',
                ],
                fontSize: 38 * scale,
              ),
              left: 20 * scale + safeMargin,
              top: 118 * scale,
            ),
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0, -0.1),
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void getAppData() {
    networkController.getAppData(callback: (
      String status, {
      String feedbackUrl,
      String message,
      String plansUrl,
      String token,
      String version,
    }) {
      debugPrint(
        'DEBUG in lib/screens/launch_screen.dart line 76: $status' +
            '\nfeedbackUrl = $feedbackUrl' +
            '\nplansUrl = $plansUrl' +
            '\nmessage = $message' +
            '\ntoken = $token' +
            '\nversion = $version',
      );
      getPlans(token: token, url: plansUrl);
    });
  }

  void getPlans({String token, String url}) {
    networkController.getPlans(
        token: token,
        url: url,
        callback: (
          String status, {
          String message,
          List<Plan> plans,
          String version,
        }) {
          debugPrint(
            'DEBUG in lib/screens/launch_screen.dart line 104: $status' +
                '\nmessage = $message' +
                '\nplans = $plans' +
                '\nversion = $version',
          );
          navigateWithDelay(
            context,
            message: '\nstatus = $status\nmessage = $message',
          );
        });
  }

  @override
  void initState() {
    getAppData();
    super.initState();
  }

  void navigateWithDelay(
    BuildContext context, {
    int seconds = 0,
    String message,
  }) async {
    final duration = Duration(seconds: seconds);
    await Future.delayed(duration);
    if (tapped) return;
    tapped = true;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Text(message),
      ),
    );
  }
}
