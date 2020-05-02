//
//  lib/widgets/navigator_widget.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/screens/about_screen.dart';
import 'package:taaqeem/screens/authorization_screen.dart';
import 'package:taaqeem/screens/main_screen.dart';
import 'package:taaqeem/screens/order_screen.dart';
import 'package:taaqeem/screens/profile_landing_screen.dart';
import 'package:taaqeem/screens/profile_screen.dart';
import 'package:taaqeem/screens/support_screen.dart';

class NavigatorWidget extends StatelessWidget {
  static const List<String> routeNames = [
    'MainScreen',
    'AboutScreen',
    'SupportScreen',
    'ProfileLandingScreen',
    'OrderScreen',
    'AuthorizationScreen',
    'ProfileScreen',
  ];

  static routeName(int index) => routeNames[index];

  final int routeIndex;
  final ScreenData screenData;

  NavigatorWidget(this.routeIndex, {this.screenData});

  @override
  Widget build(BuildContext context) {
    switch (routeIndex) {
      case MainScreen.routeIndex:
        return MainScreen(screenData);
      case AboutScreen.routeIndex:
        return AboutScreen(screenData);
      case SupportScreen.routeIndex:
        return SupportScreen(screenData);
      case ProfileLandingScreen.routeIndex:
        return ProfileLandingScreen(screenData);
      case OrderScreen.routeIndex:
        return OrderScreen(screenData);
      case AuthorizationScreen.routeIndex:
        return AuthorizationScreen(screenData);
      case ProfileScreen.routeIndex:
        return ProfileScreen(screenData);
      default:
        assert(
          false,
          'lib/widgets/navigator_widget.dart:44 Unknown route index $routeIndex',
        );
        return null;
    }
  }
}
