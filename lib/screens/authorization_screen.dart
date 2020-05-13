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
import 'package:taaqeem/widgets/image_widget.dart';
import 'package:taaqeem/widgets/keyboard_actions_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/scaffold_bar_widget.dart';
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
    final double ratio = Scale.isHorizontal(context)
        ? 0.5
        : max(
            Scale.getScreenWidth(context) / Scale.getScreenHeight(context),
            0.46,
          );
    final double scale = Scale.getHorizontalScale(context);
    final TextStyle underline =
        const TextStyle(decoration: TextDecoration.underline);
    return ScaffoldBarWidget(
      body: SafeArea(
        child: GestureDetector(
          child: KeyboardActionsWidget(
            child: ListView(
              children: [
                SizedBox(height: 53 * scale),
                Row(
                  children: [
                    TheText.w600(
                      color: Theme.of(context).accentColor,
                      fontSize: 28,
                      text: 'Please enter\nyour $item',
                      textScaleFactor: scale,
                    ),
                    if (!isCode) SizedBox(width: 50 * scale),
                    if (!isCode)
                      Column(
                        children: [
                          InkWell(
                            child: ImageWidget(
                              'left',
                              height: 15,
                              scale: scale,
                              width: 20,
                            ),
                            onTap: () => popRoute(context),
                          ),
                          SizedBox(height: 30 * scale),
                        ],
                      ),
                  ],
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
                Row(
                  children: [
                    if (!isCode)
                      FormWidget(
                        enabled: false,
                        boxHeight: 80 / ratio,
                        boxWidth: 150 * ratio,
                        controller: TextEditingController(),
                        decoration: BoxDecoration(border: null),
                        fontWeight: FontWeight.w600,
                        inputDecoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: globals.textColor,
                            fontSize: 28 * scale,
                          ),
                          hintText: globals.phonePrefix,
                        ),
                        marginLeft: 0,
                        marginRight: 0,
                        paddingLeft: 0,
                        paddingRight: 0,
                        scale: scale,
                      ),
                    FormWidget(
                      boxHeight: 80 / ratio,
                      boxWidth: isCode ? 168 * ratio : 428 * ratio,
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
                        hintStyle: TextStyle(
                          color: globals.hintColor,
                          fontSize: 28 * scale,
                        ),
                        hintText: isCode ? '9999' : '99-999-9999',
                      ),
                      marginLeft: 0,
                      marginRight: 0,
                      paddingLeft: 0,
                      paddingRight: 0,
                      onChanged: (String text) {
                        if (isCode && digits(text).length == 4 ||
                            validatePhone(text).isEmpty &&
                                validatePhone(text + '0').isNotEmpty)
                          routeToProfileScreenIfValid();
                      },
                      onEditingComplete: routeToProfileScreenIfValid,
                      scale: scale,
                    ),
                    Column(
                      children: [
                        // if (Platform.isAndroid) SizedBox(height: 7 * scale),
                        ImageWidget('pen', height: 15, scale: scale, width: 15),
                      ],
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
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
                      routeIndex: PolicyScreen.routeIndex,
                      scale: scale,
                    );
                  },
                ),
              ],
              padding: EdgeInsets.symmetric(horizontal: 20 * scale),
            ),
            focusNode: keyboardNode,
            onTapAction: routeToProfileScreenIfValid,
          ),
          onTap: hideKeyboard,
        ),
      ),
      getScreenData: () => screenData,
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
  }

  bool isTestingPhone(String phone) {
    final bool result = phone.trim().startsWith('+') &&
        digits(phone).startsWith('7') &&
        digits(phone).length == 11;
    return result;
  }

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
        final int routeIndex =
            isPending ? MainScreen.routeIndex : ProfileLandingScreen.routeIndex;
        NetworkController.shared.saveScreenDataToPrefs(screenData);
        pushRouteIfValid(
          context,
          builder: (context) => build,
          maintainState: false,
          removePrevious: true,
          replace: true,
          routeIndex: routeIndex,
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
    String errorMessage = '';
    if (!isTestingPhone(phone)) {
      if (phone == null || phone.trim().isEmpty)
        errorMessage = 'empty number';
      else {
        final String phoneDigits = digits(phone);
        final int numberOfDigits = phoneDigits.length;
        if (numberOfDigits < 8)
          errorMessage = 'please enter more digits';
        else if (10 < numberOfDigits)
          errorMessage = 'please delete extra digits';
      }
    }
    return errorMessage;
  }
}
