//
//  lib/screens/authorization_screen.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taaqeem/controllers/network_controller.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/models/user.dart';
import 'package:taaqeem/screens/main_screen.dart';
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
  ScreenData screenData;
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
                  if (isCode && digits(text).length == 4 ||
                      validatePhone(text).isEmpty &&
                          validatePhone(text + '0').isNotEmpty)
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
    screenData = widget.screenData;
    phone = screenData.user?.phone;
    phoneController = TextEditingController();
    debugPrint(
      'lib/screens/authorization_screen.dart:178 screenData = $screenData',
    );
  }

  bool isTestingPhone(String phone) =>
      phone.trim().startsWith('+') &&
      digits(phone).startsWith('7') &&
      digits(phone).length == 11;

  void routeToProfileScreenIfValid() async {
    hideKeyboard();
    if (isCode) {
      final String codeFromUser = codeController.text;
      final String errorMessage = await validateCode(codeFromUser);
      if (errorMessage.isEmpty) {
        screenData = ScreenData.over(
          ScreenData.clearErrorCodes(screenData),
          user: User.over(
            screenData.user,
            phone: phone,
          ),
        );
        final bool isPending = screenData.user.isFilled &&
            screenData.user.isLoggedIn &&
            (screenData.order.isPending || screenData.userFeedback.isPending);
        final Widget build = isPending
            ? MainScreen(screenData)
            : ProfileLandingScreen(screenData);
        final String routeName =
            isPending ? MainScreen.routeName : ProfileLandingScreen.routeName;
        NetworkController.shared.savePrefs(screenData);
        pushRouteIfValid(
          context,
          builder: (context) => build,
          maintainState: false,
          name: routeName,
          replace: true,
        );
      } else {
        showMessageInContext(context, errorMessage);
        if (--AuthorizationScreen.attemptsRemaining < 1)
          setState(() {
            verificationCode = null;
          });
      }
    } else {
      final String phoneFromUser = phoneController.text;
      final String errorMessage = validatePhone(phoneFromUser);
      if (errorMessage.isEmpty) {
        final String randomCode = getRandomCode();
        screenData = await NetworkController.shared.getRequest(
          query: {
            'generatedCode': randomCode,
            'phone': testingPrefix(phoneFromUser) + phoneFromUser,
          },
          screenData: screenData,
        );
        verificationCode = screenData.user?.token;
        if (verificationCode == null) {
          showMessageInContext(
            context,
            'server was not available.  Please try again',
          );
        } else {
          AuthorizationScreen.attemptsRemaining = 2;
          setState(() {
            phone = testingPrefix(phoneFromUser) + phoneFromUser;
          });
          if (randomCode == verificationCode)
            showMessageInContext(context, 'your code is: $randomCode');
        }
      } else
        showMessageInContext(context, errorMessage);
    }
  }

  String testingPrefix(String phone) =>
      isTestingPhone(phone) ? '' : globals.phonePrefix;

  /// Returns empty String if code is correct
  /// Returns error message if code is not correct
  Future<String> validateCode(String code) async {
    screenData = await NetworkController.shared.getRequest(
      query: {'phone': screenData.user?.phone, 'responseCode': code},
      screenData: screenData,
    );
    if (!screenData.user.isLoggedIn) return 'incorrect code';
    return '';
  }

  /// Returns empty String if phone is valid
  /// Returns error message if phone is not valid
  String validatePhone(String phone) {
    if (phone == null) return 'empty number';
    final String phoneDigits = digits(phone);
    final int numberOfDigits = phoneDigits.length;
    if (isTestingPhone(phone)) return '';
    if (numberOfDigits < 9) return 'please enter more digits';
    if (10 < numberOfDigits) return 'please delete extra digits';
    return '';
  }
}
