//
//  lib/widgets/keyboard_actions_widget.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//
//  https://pub.dev/packages/keyboard_actions
//

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class KeyboardActionsWidget extends StatefulWidget {
  final Widget child;
  final bool displayArrows;
  final FocusNode focusNode;
  final KeyboardActionsPlatform keyboardActionsPlatform;
  final VoidCallback onTapAction;

  KeyboardActionsWidget({
    @required this.child,
    this.displayArrows = false,
    this.focusNode,
    this.keyboardActionsPlatform = KeyboardActionsPlatform.IOS,
    this.onTapAction,
  });

  @override
  _KeyboardActionsWidgetState createState() => _KeyboardActionsWidgetState();
}

class _KeyboardActionsWidgetState extends State<KeyboardActionsWidget> {
  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      child: widget.child,
      config: keyboardActionsConfig,
    );
  }

  KeyboardActionsConfig get keyboardActionsConfig => KeyboardActionsConfig(
        actions: [
          KeyboardAction(
            displayArrows: widget.displayArrows,
            focusNode: widget.focusNode,
            onTapAction: widget.onTapAction,
          ),
        ],
        keyboardActionsPlatform: widget.keyboardActionsPlatform,
      );
}
