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
const String appVersion = '20200420094000';

// Default font
const String fontFamily = 'Museo Sans Cyrl';

// True if running in release mode
const bool isProduction = bool.fromEnvironment('dart.vm.product');

// The background color for major parts of the app (toolbars, tab bars, etc)
const Color primaryColor = Colors.white;

// Default text color
const Color textColor = Color(0xFF333333);