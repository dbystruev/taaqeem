//
//  lib/globals.dart
//
//  Created by Denis Bystruev on 15/04/2020.
//

library cleaning.globals;

import 'package:flutter/material.dart';

// The foreground color for widgets (knobs, text, overscroll edge effect, etc).
const Color accentColor = Color(0xFF07B360);

// App credentials to get plans and feedback sheet ids
const String appName = 'taaqeem';
const String appPassword = 'aexoo5eiz3Mahahd';
const String appVersion = '20200425090500';

// Avatar colors
const Color avatarBackgroundColor = Color(0xFFE0E0E0);

// Background color for about and support screens
const Color backgroundTopColor = Color(0xFF05C15E);
// Colors for discount box
const Color discountBackgroundColor = Color(0xFF1DB263);
const Color discountTextColor = Colors.white;

// Divider color
const Color dividerColor = Color(0xFFC4C4C4);

// Default font
const String fontFamily = 'Museo Sans Cyrl';

// Hint color
const Color hintColor = Color(0xFFBDBDBD);

// UAE Holidays 2020
final Map<DateTime, List> holidays = {
  DateTime(2020, 1, 1): [''],
  DateTime(2020, 5, 24): [''],
  DateTime(2020, 5, 25): [''],
  DateTime(2020, 5, 26): [''],
  DateTime(2020, 7, 30): [''],
  DateTime(2020, 7, 31): [''],
  DateTime(2020, 8, 1): [''],
  DateTime(2020, 8, 2): [''],
  DateTime(2020, 8, 20): [''],
  DateTime(2020, 10, 29): [''],
  DateTime(2020, 12, 1): [''],
  DateTime(2020, 12, 2): [''],
  DateTime(2020, 12, 3): [''],
};

// True if running in release mode
const bool isProduction = bool.fromEnvironment('dart.vm.product');

// Default locale
const String locale = 'en-ae';

// Menu item color
const Color menuItemColor = Color(0xFF4F4F4F);

// Phone prefix
const String phonePrefix = '+971 ';

// The background color for major parts of the app (toolbars, tab bars, etc)
const Color primaryColor = Colors.white;

// The default background color for all screens
const Color scaffoldBackgroundColor = Colors.white;

// The box shadow color rgba(99, 99, 99, 0.15)
const Color shadowColor = Color.fromRGBO(99, 99, 99, 0.15);

// Success code for external requests
const statusError = 'ERROR';
const statusSuccess = 'SUCCESS';

// Default text colors
const Color subtitleColor = Color(0xFF828282);
const Color superscriptColor = Color(0xFFDCDCDC);
const Color textColor = Color(0xFF333333);
