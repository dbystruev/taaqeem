//
//  lib/screens/authorization_screen.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/plan.dart';
import 'package:taaqeem/screens/policy_screen.dart';
import 'package:taaqeem/widgets/form_widget.dart';
import 'package:taaqeem/widgets/keyboard_actions_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class AuthorizationScreen extends StatefulWidget {
  final DateTime day;
  final double meters;
  final Plan plan;
  final String service;

  AuthorizationScreen({this.day, this.meters, this.plan, this.service});

  @override
  _AuthorizationScreenState createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> with Scale {
  FocusNode keyboardNode;
  TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getScale(context);
    final TextStyle underline =
        const TextStyle(decoration: TextDecoration.underline);
    return Scaffold(
      body: KeyboardActionsWidget(
        child: ListView(
          children: [
            SizedBox(height: 53 * scale),
            TheText.w600(
              color: Theme.of(context).accentColor,
              fontSize: 28,
              text: 'Please enter\nyour phone number',
              textScaleFactor: scale,
            ),
            SizedBox(height: 35 * scale),
            TheText.w600(
              color: globals.textColor,
              fontSize: 18,
              text: 'We’ll send you a verification code',
              textScaleFactor: scale,
            ),
            SizedBox(height: 80 * scale),
            FormWidget(
              color: globals.textColor,
              controller: phoneController,
              decoration: BoxDecoration(border: null),
              fontSize: 28,
              fontWeight: FontWeight.w600,
              keyboardNode: keyboardNode,
              keyboardType: TextInputType.phone,
              inputDecoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(color: globals.hintColor),
                hintText: '99-999-9999',
                prefixStyle: TextStyle(
                  color: globals.textColor,
                  fontFamily: globals.fontFamily,
                  fontSize: 28 * scale,
                  fontWeight: FontWeight.w600,
                ),
                prefixText: '+971 ',
              ),
              onChanged: (String text) {
                debugPrint(
                    'lib/screens/authorization_screen.dart:78 onChanged text = $text');
              },
              onEditingComplete: () {
                hideKeyboard();
                debugPrint(
                  'lib/screens/authorization_screen.dart:83 onEditingComplete ${phoneController.text}',
                );
              },
              scale: scale,
            ),
            SizedBox(height: 79 * scale),
            InkWell(
              child: TheText.normal(
                color: globals.subtitleColor,
                fontSize: 15,
                height: 1.6,
                styles: [null, underline, null, underline],
                textAlign: TextAlign.center,
                texts: [
                  'By entering phone number you agree with our\n',
                  'Terms of service',
                  ' and ',
                  'Privacy policy',
                ],
                textScaleFactor: scale,
              ),
              onTap: () {}, // enables onTapDown
              onTapDown: (TapDownDetails details) {
                final bool showToS =
                    details.globalPosition.dx < Scale.getMidX(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PolicyScreen(showToS: showToS),
                  ),
                );
              },
            ),
          ],
          padding: EdgeInsets.symmetric(
            horizontal: 20 * scale + Scale.getSafeMargin(context),
            vertical: Scale.getSafeMargin(context),
          ),
        ),
        focusNode: keyboardNode,
        onTapAction: () {
          hideKeyboard();
          debugPrint(
            'lib/screens/authorization_screen.dart:126 onTapAction ${phoneController.text}',
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    keyboardNode.dispose();
    super.dispose();
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    keyboardNode = FocusNode();
    phoneController = TextEditingController();
  }
}
