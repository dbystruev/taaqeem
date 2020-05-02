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
  final VoidCallback onPlusTap;
  final bool removePreviousRoute;
  final ScreenData screenData;

  ScaffoldBarWidget({
    this.body,
    this.onPlusTap,
    this.removePreviousRoute = false,
    this.screenData,
  });

  @override
  _ScaffoldBarWidgetState createState() => _ScaffoldBarWidgetState();
}

class _ScaffoldBarWidgetState extends State<ScaffoldBarWidget>
    with RouteValidator {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: BottomNavigationWidget(
        onTap: (int routeIndex) {
          setState(
              () => BottomNavigationWidget.selectedBottomBarItem = routeIndex);
          if (routeIndex == widget.screenData.routeIndex) return;
          pushRouteIfValid(
            context,
            builder: (context) => NavigatorWidget(
              routeIndex,
              screenData: widget.screenData,
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
                    screenData: widget.screenData,
                  ),
                  name: OrderScreen.routeName,
                  removePrevious: widget.removePreviousRoute,
                  replace: widget.screenData.isPlanSelected,
                ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
