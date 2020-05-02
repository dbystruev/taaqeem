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
  bool pushRouteIfValid(
    BuildContext context, {
    Widget Function(BuildContext context) builder,
    bool maintainState = true,
    String name,
    bool replace = false,
    double scale,
    String Function() validator,
  }) {
    debugPrint(
      'lib/mixins/route_validator_mixin.dart:25 pushRouteIfValid(name: \'$name\', replace: $replace)',
    );
    if (validator != null) {
      final String message = validator();
      if (message.isNotEmpty) {
        showMessageInContext(context, message);
        debugPrint('pushRouteIfValid() failed: \'$message\'');
        return false;
      }
    }
    final MaterialPageRoute route = MaterialPageRoute(
      builder: builder,
      maintainState: maintainState,
      settings: RouteSettings(name: name),
    );
    if (replace) {
      Navigator.pushReplacement(context, route);
    } else {
      Navigator.push(context, route);
    }
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
