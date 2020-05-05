//
//  lib/widgets/scaffold_bar_widget.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/screens/order_screen.dart';
import 'package:taaqeem/widgets/bottom_navigation_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/plus_button_widget.dart';

class ScaffoldBarWidget extends StatefulWidget {
  final Widget body;
  final ScreenData Function() getScreenData;
  final VoidCallback onCanvasTap;
  final VoidCallback onPlusTap;
  final bool removePreviousRoute;

  ScaffoldBarWidget({
    this.body,
    this.getScreenData,
    this.onCanvasTap,
    this.onPlusTap,
    this.removePreviousRoute = false,
  });

  @override
  _ScaffoldBarWidgetState createState() => _ScaffoldBarWidgetState();
}

class _ScaffoldBarWidgetState extends State<ScaffoldBarWidget>
    with RouteValidator {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          child: widget.body, onTap: widget.onCanvasTap ?? hideKeyboard),
      bottomNavigationBar: BottomNavigationWidget(
        onTap: (int routeIndex) {
          setState(
              () => BottomNavigationWidget.selectedBottomBarItem = routeIndex);
          if (routeIndex == widget.getScreenData().routeIndex) return;
          pushRouteIfValid(
            context,
            builder: (context) => NavigatorWidget(
              routeIndex,
              screenData: widget.getScreenData(),
            ),
            name: NavigatorWidget.routeName(routeIndex),
            removePrevious: widget.removePreviousRoute,
            replace: true,
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
                  name: OrderScreen.routeName,
                  removePrevious: widget.removePreviousRoute,
                  replace: widget.getScreenData().isPlanSelected,
                ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void hideKeyboard() => FocusScope.of(context).unfocus();
}
