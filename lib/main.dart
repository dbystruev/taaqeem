//
//  lib/main.dart
//
//  Created by Denis Bystruev on 16/04/2020.
//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/screens/launch_screen.dart';

void main() {
  // Disable debugPring in release mode
  if (globals.isProduction) debugPrint = (String message, {int wrapWidth}) {};
  // Set default locale
  Intl.defaultLocale = globals.locale;
  initializeDateFormatting(globals.locale).then(
    (_) {
      runApp(
        Main(),
      );
      SystemChrome.setEnabledSystemUIOverlays([]);
    },
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
        scaffoldBackgroundColor: globals.scaffoldBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
