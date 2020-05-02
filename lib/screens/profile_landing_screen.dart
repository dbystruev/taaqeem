//
//  lib/screens/profile_landing_screen.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/screens/authorization_screen.dart';
import 'package:taaqeem/screens/profile_screen.dart';
import 'package:taaqeem/widgets/bottom_navigation_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';

class ProfileLandingScreen extends StatefulWidget {
  static const routeIndex = 3;
  static String get routeName => NavigatorWidget.routeName(routeIndex);

  final ScreenData screenData;

  ProfileLandingScreen(ScreenData screenData)
      : this.screenData = ScreenData.over(screenData, routeIndex: routeIndex);

  @override
  _ProfileLandingScreenState createState() => _ProfileLandingScreenState();
}

class _ProfileLandingScreenState extends State<ProfileLandingScreen> {
  @override
  Widget build(BuildContext context) {
    final ScreenData screenData = widget.screenData;
    return screenData.user?.phone == null
        ? AuthorizationScreen(screenData)
        : ProfileScreen(screenData);
  }

  @override
  void initState() {
    super.initState();
    BottomNavigationWidget.selectedBottomBarItem =
        ProfileLandingScreen.routeIndex;
  }
}
