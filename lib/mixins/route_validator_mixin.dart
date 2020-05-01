//
//  lib/mixins/route_validator_mixin.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:flutter/material.dart';

mixin RouteValidator {
  void routeIfValid(
    BuildContext context, {
    Widget Function(BuildContext context) builder,
    bool maintainState = true,
    String Function() validator,
  }) {
    if (validator != null) {
      final String message = validator();
      if (message.isNotEmpty) {
        debugPrint(
            'lib/mixins/route_validator_mixin.dart:20 message = $message');
        return;
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: builder, maintainState: maintainState),
    );
  }
}
