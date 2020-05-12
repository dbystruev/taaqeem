//
//  lib/widgets/scaffold_bar_widget.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/screens/authorization_screen.dart';
import 'package:taaqeem/screens/order_screen.dart';
import 'package:taaqeem/screens/profile_landing_screen.dart';
import 'package:taaqeem/widgets/bottom_navigation_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/plus_button_widget.dart';

class ScaffoldBarWidget extends StatefulWidget {
  final Widget body;
  final Color color;
  final ScreenData Function() getScreenData;
  final VoidCallback onCanvasTap;
  final VoidCallback onPlusTap;
  final bool removePreviousRoute;
  final bool safeAreaBottom;
  final bool safeAreaLeft;
  final bool safeAreaRight;
  final bool safeAreaTop;

  ScaffoldBarWidget({
    this.body,
    this.color,
    this.getScreenData,
    this.onCanvasTap,
    this.onPlusTap,
    this.removePreviousRoute = false,
    this.safeAreaBottom = true,
    this.safeAreaLeft = true,
    this.safeAreaRight = true,
    this.safeAreaTop = true,
  });

  @override
  _ScaffoldBarWidgetState createState() => _ScaffoldBarWidgetState();
}

class _ScaffoldBarWidgetState extends State<ScaffoldBarWidget>
    with RouteValidator {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/background_top.png'), context);
    return Scaffold(
      body: Container(
        child: SafeArea(
          bottom: widget.safeAreaBottom,
          child: GestureDetector(
              child: widget.body, onTap: widget.onCanvasTap ?? hideKeyboard),
          left: widget.safeAreaLeft,
          right: widget.safeAreaRight,
          top: widget.safeAreaTop,
        ),
        color: widget.color,
      ),
      bottomNavigationBar: BottomNavigationWidget(
        onTap: (int newRouteIndex) {
          setState(() =>
              BottomNavigationWidget.selectedBottomBarItem = newRouteIndex);
          final int oldRouteIndex = widget.getScreenData().routeIndex;
          if (newRouteIndex == oldRouteIndex ||
              oldRouteIndex == AuthorizationScreen.routeIndex &&
                  newRouteIndex == ProfileLandingScreen.routeIndex) return;
          pushRouteIfValid(
            context,
            animate: false,
            builder: (context) => NavigatorWidget(
              newRouteIndex,
              screenData: widget.getScreenData(),
            ),
            removePrevious: widget.removePreviousRoute,
            replace: newRouteIndex != ProfileLandingScreen.routeIndex,
            routeIndex: newRouteIndex,
          );
        },
        selectedIndex: BottomNavigationWidget.selectedBottomBarItem,
      ),
      floatingActionButton: PlusButtonWidget(
        onTap: widget.onPlusTap ??
            () => pushRouteIfValid(
                  context,
                  builder: (context) => NavigatorWidget(
                    OrderScreen.routeIndex,
                    screenData: widget.getScreenData(),
                  ),
                  removePrevious: widget.removePreviousRoute,
                  replace: widget.getScreenData().isPlanSelected,
                  routeIndex: OrderScreen.routeIndex,
                ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void hideKeyboard() => FocusScope.of(context).unfocus();
}
