//
//  lib/main.dart
//
//  Created by Denis Bystruev on 16/04/2020.
//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:taaqeem/controllers/network_controller.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/app_data.dart';
import 'package:taaqeem/models/plans+all.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/screens/main_screen.dart';

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

void main() {
  // Disable debugPrint in release mode
  if (globals.isProduction) debugPrint = (String message, {int wrapWidth}) {};

  // Start process of getting data from the server
  getPlans();

  // Set default locale
  Intl.defaultLocale = globals.locale;
  initializeDateFormatting(globals.locale).then(
    (_) {
      runApp(
        Main(
          ScreenData(
            plans: Plans(AllPlans.local),
          ),
        ),
      );
      SystemChrome.setEnabledSystemUIOverlays([]);
    },
  );
}

class Main extends StatelessWidget {
  final ScreenData screenData;

  Main(this.screenData);

  @override
  Widget build(BuildContext context) {
    final Widget Function(BuildContext) builder =
        (BuildContext context) => MainScreen(screenData);
    // final Route mainRoute = MaterialPageRoute(builder: builder);
    // RouteValidator.routes = [mainRoute];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MainScreen.routeName,
      routes: {MainScreen.routeName: builder},
      title: 'Taqeem',
      theme: ThemeData(
        accentColor: globals.accentColor,
        primaryColor: globals.primaryColor,
        scaffoldBackgroundColor: globals.scaffoldBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
