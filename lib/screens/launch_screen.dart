//
//  lib/screens/launch_screen.dart
//
//  Created by Denis Bystruev on 14/04/2020, updated 18/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/controllers/network_controller.dart';
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/app_data.dart';
import 'package:taaqeem/models/plans+all.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/screens/main_screen.dart';
import 'package:taaqeem/widgets/image_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen>
    with Scale, RouteValidator {
  // Minimum delay — 3 seconds
  final Duration minDelay = Duration(seconds: 3);
  final NetworkController networkController = NetworkController();
  Plans plans;
  final startTime = DateTime.now();
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getScale(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: ImageWidget('logo', height: 58, width: 135),
              left: 20 * scale + Scale.getSafeMargin(context),
              top: 30 * scale,
            ),
            Positioned(
              child: TheText.w600(
                colors: [null, Theme.of(context).accentColor],
                texts: [
                  'Protect your\n',
                  'home &\nbusiness',
                  ' from\nGlobal virus',
                ],
                fontSize: 38,
                height: 1.21,
                textScaleFactor: scale,
              ),
              left: 20 * scale + Scale.getSafeMargin(context),
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

  @override
  void dispose() {
    networkController.dispose();
    super.dispose();
  }

  void getPlans() async {
    AppData appData = await networkController.getAppData();
    plans = appData.status == globals.statusSuccess
        ? await networkController.getPlans(
            token: appData.token, url: appData.plansUrl)
        : Plans(
            [],
            message: appData.message,
            status: appData.status,
          );
    if (!plans.isValid) plans.plans = AllPlans.local;
    navigateWithDelay(context);
  }

  @override
  void initState() {
    getPlans();
    super.initState();
  }

  void navigateWithDelay(BuildContext context) async {
    if (tapped) return;
    tapped = true;
    final Duration elapsedTime = DateTime.now().difference(startTime);
    final Duration delay = minDelay - elapsedTime;
    if (0 < delay.inMilliseconds) await Future.delayed(delay);
    pushRouteIfValid(
      context,
      builder: (context) => MainScreen(
        ScreenData(plans: plans),
      ),
      name: MainScreen.routeName,
      replace: true,
    );
  }
}
