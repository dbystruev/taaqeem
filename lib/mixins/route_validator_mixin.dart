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
import 'package:taaqeem/widgets/text_widgets.dart';

mixin RouteValidator {
  static List<Route> routes;

  void popRoute(BuildContext context) {
    if (routes != null && 0 < routes.length) routes.removeLast();
    debugPrint(
      'lib/mixins/route_validator_mixin.dart:20 popRoute(), ${routes?.length} left',
    );
    Navigator.pop(context);
  }

  bool pushRouteIfValid(
    BuildContext context, {
    Widget Function(BuildContext context) builder,
    bool maintainState = true,
    String name,
    bool removePrevious = false,
    bool replace = false,
    double scale,
    String Function() validator,
  }) {
    debugPrint(
      'lib/mixins/route_validator_mixin.dart:35 pushRouteIfValid(name: \'$name\', replace: $replace)',
    );
    if (validator != null) {
      final String message = validator();
      if (message.isNotEmpty) {
        showMessageInContext(context, message);
        debugPrint(
          'pushRouteIfValid() failed: \'$message\', routes in stack: ${routes?.length}',
        );
        return false;
      }
    }
    final MaterialPageRoute route = MaterialPageRoute(
      builder: builder,
      maintainState: maintainState,
      settings: RouteSettings(name: name),
    );
    if (routes == null) routes = List<Route>();
    if (removePrevious && 1 < routes.length) {
      Navigator.removeRoute(
        context,
        routes.removeAt(routes.length - 2),
      );
    }
    if (replace) {
      if (0 < routes.length) routes.removeLast();
      routes.add(route);
      Navigator.pushReplacement(context, route);
    } else {
      routes.add(route);
      Navigator.push(context, route);
    }
    debugPrint(
      'pushRouteIfValid() succeeded, routes in stack: ${routes?.length}',
    );
    return true;
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
