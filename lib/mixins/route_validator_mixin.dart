//
//  lib/mixins/route_validator_mixin.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/screens/about_screen.dart';
import 'package:taaqeem/screens/main_screen.dart';
import 'package:taaqeem/screens/profile_landing_screen.dart';
import 'package:taaqeem/screens/support_screen.dart';
import 'package:taaqeem/widgets/bottom_navigation_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

mixin RouteValidator {
  static List<Route> routes;

  void popRoute(BuildContext context) {
    if (routes != null && 0 < routes.length) routes.removeLast();
    debugPrint('${routes.length} routes\n$routes');
    Navigator.pop(context);
  }

  bool pushRouteIfValid(
    BuildContext context, {
    bool animate = true,
    Widget Function(BuildContext context) builder,
    bool maintainState = true,
    bool removePrevious = false,
    bool replace = false,
    int routeIndex,
    double scale,
    String Function() validator,
  }) {
    if (validator != null) {
      final String message = validator();
      if (message.isNotEmpty) {
        showMessageInContext(context, message);
        return false;
      }
    }
    final String name = NavigatorWidget.routeName(routeIndex);
    final Route route = animate
        ? MaterialPageRoute(
            builder: builder,
            maintainState: maintainState,
            settings: RouteSettings(name: name),
          )
        : PageRouteBuilder(
            maintainState: maintainState,
            pageBuilder: (BuildContext context, _, __) => builder(context),
            settings: RouteSettings(name: name),
          );
    if (routes == null) routes = List<Route>();
    if (removePrevious && 1 < routes.length) {
      Navigator.removeRoute(
        context,
        routes.removeAt(routes.length - 2),
      );
    }
    updateBottomBar(routeIndex);
    if (replace) {
      if (0 < routes.length) routes.removeLast();
      routes.add(route);
      Navigator.pushReplacement(context, route);
    } else {
      routes.add(route);
      Navigator.push(context, route);
    }
    debugPrint('${routes.length} routes\n$routes');
    return true;
  }

  void removeFirstRoute(BuildContext context) {
    if (routes != null && 1 < routes.length) {
      Navigator.removeRoute(
        context,
        routes.removeAt(0),
      );
      debugPrint('${routes.length} routes\n$routes');
    }
  }

  void updateBottomBar(int routeIndex) {
    switch (routeIndex) {
      case MainScreen.routeIndex:
      case AboutScreen.routeIndex:
      case SupportScreen.routeIndex:
      case ProfileLandingScreen.routeIndex:
        BottomNavigationWidget.selectedBottomBarItem = routeIndex;
        break;
      // case OrderScreen.routeIndex:
      //   BottomNavigationWidget.selectedBottomBarItem = MainScreen.routeIndex;
      //   break;
      // case AuthorizationScreen.routeIndex:
      // case ProfileScreen.routeIndex:
      // case ProfileEditScreen.routeIndex:
      // case FeedbackScreen.routeIndex:
      //   BottomNavigationWidget.selectedBottomBarItem =
      //       ProfileLandingScreen.routeIndex;
    }
  }

  void showMessageInContext(
    BuildContext context,
    String message, {
    double scale,
  }) {
    final double localScale = scale ?? Scale.getScale(context);
    Flushbar(
      backgroundColor: Theme.of(context).primaryColor,
      borderRadius: 7 * localScale,
      boxShadows: [
        BoxShadow(
          blurRadius: 15 * localScale,
          color: globals.shadowColor,
        ),
      ],
      duration: Duration(seconds: 3),
      isDismissible: true,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.symmetric(
        horizontal: 20 * localScale,
        vertical: 24 * localScale,
      ),
      messageText: TheText.normal(
        color: globals.menuItemColor,
        fontSize: 14,
        text: capitalize(message) + '.',
        textScaleFactor: localScale,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 18 * localScale,
        vertical: 14 * localScale,
      ),
    )..show(context);
  }
}
