//
//  lib/screens/authorization_screen.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/plan.dart';
import 'package:taaqeem/screens/policy_screen.dart';
import 'package:taaqeem/widgets/form_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class AuthorizationScreen extends StatelessWidget with Scale {
  final TextEditingController controller = TextEditingController();
  final DateTime day;
  final KeyboardActionsConfig keyboardConfig = KeyboardActionsConfig(
    actions: [
      KeyboardAction(
        displayArrows: false,
        focusNode: keyboardNode,
      )
    ],
  );
  final double meters;
  static final FocusNode keyboardNode = FocusNode();
  final Plan plan;
  final String service;

  AuthorizationScreen({this.day, this.meters, this.plan, this.service});

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getScale(context);
    final TextStyle underline =
        const TextStyle(decoration: TextDecoration.underline);
    return Scaffold(
      body: KeyboardActions(
        config: keyboardConfig,
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
              controller: controller,
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
                    'lib/screens/authorization_screen.dart:82 text = $text');
              },
              scale: scale,
            ),
            // InternationalPhoneNumberInput(
            //   countries: ['AE'],
            //   focusNode: keyboardNode,
            //   inputDecoration: InputDecoration(
            //     border: InputBorder.none,
            //     hintStyle: TextStyle(
            //       color: globals.hintColor,
            //     ),
            //     hintText: '99-999-9999',
            //   ),
            //   keyboardAction: TextInputAction.done,
            //   locale: globals.locale,
            //   onInputChanged: (PhoneNumber number) {
            //     debugPrint(
            //         'lib/screens/authorization_screen.dart:100 number = $number');
            //   },
            //   textFieldController: controller,
            //   textStyle: TextStyle(
            //     color: globals.textColor,
            //     fontFamily: globals.fontFamily,
            //     fontSize: 28 * scale,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
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
      ),
    );
  }
}
