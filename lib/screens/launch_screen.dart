//
//  lib/screens/launch_screen.dart
//
//  Created by Denis Bystruev on 14/04/2020, updated 18/04/2020.
//
//  Not used since 11/05/2020

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

class _LaunchScreenState extends State<LaunchScreen> with RouteValidator {
  final ImageProvider backgroundImage =
      AssetImage('assets/images/background.png');
  final Duration minDelay = Duration(milliseconds: 1750); // 1.75 seconds
  final DateTime startTime = DateTime.now();
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets safePadding = Scale.getSafePadding(context);
    final double scale = Scale.getScale(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: ImageWidget('logo', height: 58, scale: scale, width: 135),
              left: 20 * scale + safePadding.left,
              top: 60 * scale,
            ),
            Positioned(
              child: TheText.w600(
                colors: [null, Theme.of(context).accentColor],
                texts: [
                  'Protect your ',
                  'home\n& business',
                  ' from\nGlobal virus',
                ],
                fontSize: 38,
                height: 1.21,
                textScaleFactor: scale,
              ),
              left: 20 * scale + safePadding.left,
              top: 150 * scale,
            ),
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0, -0.1),
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void getPlans() async {
    AppData appData = await NetworkController.shared.getAppData();
    final String responseToken = appData.status == globals.statusSuccess
        ? NetworkController.shared.getResponseToken(appData.token)
        : null;
    final String feedbackUrl = appData.status == globals.statusSuccess
        ? '${appData.feedbackUrl}?token=${appData.token}&responseToken=$responseToken'
        : null;
    NetworkController.shared.screenData = ScreenData.merge(
      NetworkController.shared.screenData,
      ScreenData(url: feedbackUrl),
    );
    Plans plans = appData.status == globals.statusSuccess
        ? await NetworkController.shared.getPlans(
            token: appData.token,
            responseToken: responseToken,
            url: appData.plansUrl,
          )
        : Plans(
            [],
            message: appData.message,
            status: appData.status,
          );
    if (!plans.areValid) plans.plans = AllPlans.local;
    NetworkController.shared.screenData = ScreenData.merge(
      NetworkController.shared.screenData,
      ScreenData(plans: plans),
    );
  }

  @override
  void initState() {
    super.initState();
    getPlans();
    NetworkController.shared
        .getScreenDataFromPrefs()
        .then((ScreenData screenData) {
      if (screenData?.plans == null || !screenData.plans.areValid)
        screenData = ScreenData.merge(
          screenData,
          ScreenData(
            plans: Plans(AllPlans.local),
          ),
        );
      navigateWithDelay(context, screenData);
    });
  }

  void navigateWithDelay(BuildContext context, ScreenData screenData) async {
    if (tapped) return;
    tapped = true;
    final Duration elapsedTime = DateTime.now().difference(startTime);
    final Duration delay = minDelay - elapsedTime;
    if (0 < delay.inMilliseconds) await Future.delayed(delay);
    pushRouteIfValid(
      context,
      builder: (context) => MainScreen(screenData),
      replace: true,
      routeIndex: MainScreen.routeIndex,
    );
    tapped = false;
  }
}
