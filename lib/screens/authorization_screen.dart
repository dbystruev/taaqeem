//
//  lib/screens/authorization_screen.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/models/order.dart';
import 'package:taaqeem/screens/policy_screen.dart';
import 'package:taaqeem/screens/profile_screen.dart';
import 'package:taaqeem/widgets/form_widget.dart';
import 'package:taaqeem/widgets/keyboard_actions_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class AuthorizationScreen extends StatefulWidget {
  final Order order;
  final String phone;
  final String phonePrefix = '+971 ';
  final String verificationCode;

  AuthorizationScreen({
    this.order,
    this.phone,
    this.verificationCode,
  });

  @override
  _AuthorizationScreenState createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen>
    with RouteValidator, Scale {
  TextEditingController formController;
  bool get isCode => widget.verificationCode != null;
  String get item => isCode ? 'verification code' : 'phone number';
  FocusNode keyboardNode;

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
              text: 'Please enter\nyour $item',
              textScaleFactor: scale,
            ),
            SizedBox(height: 35 * scale),
            TheText.w600(
              color: globals.textColor,
              fontSize: 18,
              text: isCode
                  ? 'We’ve sent the verification code to\n${widget.phone}'
                  : 'We’ll send you a verification code',
              textScaleFactor: scale,
            ),
            SizedBox(height: 80 * scale),
            FormWidget(
              color: globals.textColor,
              controller: formController,
              decoration: BoxDecoration(border: null),
              fontSize: 28,
              fontWeight: FontWeight.w600,
              keyboardNode: keyboardNode,
              keyboardType: isCode ? TextInputType.number : TextInputType.phone,
              inputDecoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(color: globals.hintColor),
                hintText: isCode ? '9999' : '99-999-9999',
                prefixStyle: TextStyle(
                  color: globals.textColor,
                  fontFamily: globals.fontFamily,
                  fontSize: 28 * scale,
                  fontWeight: FontWeight.w600,
                ),
                prefixText: isCode ? null : widget.phonePrefix,
              ),
              onChanged: (String text) {
                debugPrint(
                  'lib/screens/authorization_screen.dart:89 onChanged text = $text',
                );
                if (isCode && 3 < text.length) routeToTheNextScreenIfValid();
              },
              onEditingComplete: routeToTheNextScreenIfValid,
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
                  'By entering $item you agree with our\n',
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
        onTapAction: routeToTheNextScreenIfValid,
      ),
    );
  }

  @override
  void dispose() {
    keyboardNode.dispose();
    formController.dispose();
    super.dispose();
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    formController = TextEditingController();
    keyboardNode = FocusNode();
  }

  void routeToTheNextScreenIfValid() {
    final String textToValidate = formController.text;
    hideKeyboard();
    if (isCode) {
      routeIfValid(
        context,
        builder: (context) => ProfileScreen(widget.phone),
        maintainState: false,
        validator: () => validateCode(textToValidate),
      );
    } else {
      routeIfValid(
        context,
        builder: (context) => AuthorizationScreen(
          order: widget.order,
          phone: widget.phonePrefix + textToValidate,
          verificationCode: '9999',
        ),
        maintainState: false,
        validator: () => validatePhone(textToValidate),
      );
    }
  }

  /// Returns empty String if code is correct
  /// Returns error message if code is not correct
  String validateCode(String code) {
    if (code != widget.verificationCode)
      return 'Incorrect code.  Correct code is ${widget.verificationCode}.';
    return '';
  }

  /// Returns empty String if phone is valid
  /// Returns error message if phone is not valid
  String validatePhone(String phone) {
    if (phone == null) return 'empty number';
    final String phoneDigits = phone.replaceAll(RegExp(r'[^\d]'), '');
    final int numberOfDigits = phoneDigits.length;
    if (numberOfDigits < 9) return 'not enough digits';
    if (10 < numberOfDigits) return 'too many digits';
    return '';
  }
}
