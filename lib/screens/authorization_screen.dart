//
//  lib/screens/authorization_screen.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/models/user.dart';
import 'package:taaqeem/screens/policy_screen.dart';
import 'package:taaqeem/screens/profile_landing_screen.dart';
import 'package:taaqeem/widgets/form_widget.dart';
import 'package:taaqeem/widgets/keyboard_actions_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class AuthorizationScreen extends StatefulWidget {
  static int attemptsRemaining;
  static const routeIndex = 5;
  static String get routeName => NavigatorWidget.routeName(routeIndex);

  final Random random = Random();
  final ScreenData screenData;

  AuthorizationScreen(ScreenData screenData)
      : this.screenData = ScreenData.over(screenData, routeIndex: routeIndex);

  @override
  _AuthorizationScreenState createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen>
    with RouteValidator {
  TextEditingController codeController;
  bool get isCode => phone != null && verificationCode != null;
  String get item => isCode ? 'verification code' : 'phone number';
  FocusNode keyboardNode;
  String phone;
  TextEditingController phoneController;
  String verificationCode;

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getHorizontalScale(context);
    final TextStyle underline =
        const TextStyle(decoration: TextDecoration.underline);
    return Scaffold(
      body: GestureDetector(
        child: KeyboardActionsWidget(
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
                    ? 'We’ve sent the verification code to\n$phone'
                    : 'We’ll send you a verification code',
                textScaleFactor: scale,
              ),
              SizedBox(height: 80 * scale),
              FormWidget(
                color: globals.textColor,
                controller: isCode ? codeController : phoneController,
                decoration: BoxDecoration(border: null),
                fontSize: 28,
                fontWeight: FontWeight.w600,
                keyboardNode: keyboardNode,
                keyboardType:
                    isCode ? TextInputType.number : TextInputType.phone,
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
                  prefixText: isCode ? null : globals.phonePrefix,
                ),
                onChanged: (String text) {
                  final String digitsText = digits(text);
                  if (isCode && 3 < digitsText.length || 9 < digitsText.length)
                    routeToProfileScreenIfValid();
                },
                onEditingComplete: routeToProfileScreenIfValid,
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
                  pushRouteIfValid(
                    context,
                    builder: (context) => PolicyScreen(showToS: showToS),
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
          onTapAction: routeToProfileScreenIfValid,
        ),
        onTap: hideKeyboard,
      ),
    );
  }

  String digits(String number) => number.replaceAll(RegExp(r'[^\d]'), '');

  @override
  void dispose() {
    phoneController.dispose();
    keyboardNode.dispose();
    codeController.dispose();
    super.dispose();
  }

  String getRandomCode({int length = 4}) {
    String result = '';
    for (int count = 0; count < length; count++)
      result += getRandomDigit.toString();
    return result;
  }

  int get getRandomDigit => widget.random.nextInt(10);

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    keyboardNode = FocusNode();
    phone = widget.screenData.user?.phone;
    phoneController = TextEditingController();
  }

  void routeToProfileScreenIfValid() {
    hideKeyboard();
    if (isCode) {
      final String codeFromUser = codeController.text;
      if (!pushRouteIfValid(
        context,
        builder: (context) => ProfileLandingScreen(
          ScreenData.over(
            widget.screenData,
            user: User.over(
              widget.screenData.user,
              phone: phone,
            ),
          ),
        ),
        maintainState: false,
        name: ProfileLandingScreen.routeName,
        replace: true,
        validator: () => validateCode(codeFromUser),
      )) {
        if (--AuthorizationScreen.attemptsRemaining < 1)
          setState(() {
            verificationCode = null;
          });
      }
    } else {
      final String phoneFromUser = phoneController.text;
      final String errorMessage = validatePhone(phoneFromUser);
      if (errorMessage.isEmpty) {
        AuthorizationScreen.attemptsRemaining = 2;
        final String randomCode = getRandomCode();
        setState(() {
          phone = globals.phonePrefix + phoneFromUser;
          verificationCode = randomCode;
        });
        showMessageInContext(context, 'your code is: $randomCode');
      } else
        showMessageInContext(context, errorMessage);
    }
  }

  /// Returns empty String if code is correct
  /// Returns error message if code is not correct
  String validateCode(String code) {
    if (code != verificationCode) return 'incorrect code';
    return '';
  }

  /// Returns empty String if phone is valid
  /// Returns error message if phone is not valid
  String validatePhone(String phone) {
    if (phone == null) return 'empty number';
    final String phoneDigits = digits(phone);
    final int numberOfDigits = phoneDigits.length;
    if (numberOfDigits < 9) return 'please enter more digits';
    if (10 < numberOfDigits) return 'please delete extra digits';
    return '';
  }
}
