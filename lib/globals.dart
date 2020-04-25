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

// Colors for discount box
const Color discountBackgroundColor = Color(0xFF1DB263);
const Color discountTextColor = Colors.white;

// Default font
const String fontFamily = 'Museo Sans Cyrl';

// True if running in release mode
const bool isProduction = bool.fromEnvironment('dart.vm.product');

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
const Color textColor = Color(0xFF333333);
