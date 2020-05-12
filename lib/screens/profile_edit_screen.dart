//
//  lib/screens/profile_edit_screen.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/controllers/network_controller.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/models/user.dart';
import 'package:taaqeem/screens/main_screen.dart';
import 'package:taaqeem/screens/profile_screen.dart';
import 'package:taaqeem/widgets/back_widget.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/form_widget.dart';
import 'package:taaqeem/widgets/keyboard_actions_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/scaffold_bar_widget.dart';

class ProfileEditScreen extends StatefulWidget {
  static const routeIndex = 7;
  static String get routeName => NavigatorWidget.routeName(routeIndex);

  final ScreenData screenData;

  ProfileEditScreen(ScreenData screenData)
      : this.screenData = ScreenData.over(screenData, routeIndex: routeIndex);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen>
    with RouteValidator {
  TextEditingController emailController;
  FocusNode emailNode;
  bool showName;
  TextEditingController nameController;
  FocusNode nameNode;
  ScreenData screenData;

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getHorizontalScale(context);
    return ScaffoldBarWidget(
      body: KeyboardActionsWidget(
        child: ListView(
          children: [
            BackWidget(
              'Profile info',
              scale: scale,
            ),
            FormWidget(
              borderColor: globals.inactiveColor,
              enabled: false,
              hintColor: globals.inactiveColor,
              hintText: screenData.user.phone,
              scale: scale,
            ),
            FormWidget(
              borderColor:
                  showName ? globals.inactiveColor : globals.subtitleColor,
              color: showName ? globals.inactiveColor : globals.textColor,
              controller: emailController,
              enabled: !showName,
              hintColor:
                  showName ? globals.inactiveColor : globals.subtitleColor,
              hintText: showName ? screenData.user.email : 'Your email',
              keyboardNode: emailNode,
              keyboardType: TextInputType.emailAddress,
              onEditingComplete: nextFieldOrRoute,
              scale: scale,
            ),
            if (showName)
              FormWidget(
                borderColor: globals.subtitleColor,
                color: globals.textColor,
                controller: nameController,
                hintColor: globals.subtitleColor,
                hintText: 'Your name',
                keyboardNode: nameNode,
                keyboardType: TextInputType.text,
                onEditingComplete: nextFieldOrRoute,
                scale: scale,
              ),
            SizedBox(height: 5 * scale),
            ButtonWidget(
              'Accept',
              onPressed: nextFieldOrRoute,
              scale: scale,
              width: 335,
            )
          ],
        ),
        focusNode: showName ? nameNode : emailNode,
        onTapAction: nextFieldOrRoute,
      ),
      removePreviousRoute: true,
      getScreenData: () => screenData,
    );
  }

  @override
  void initState() {
    super.initState();
    screenData = widget.screenData;
    emailController = TextEditingController(text: screenData.user.email);
    emailNode = FocusNode();
    nameController = TextEditingController(text: screenData.user.name);
    nameNode = FocusNode();
    showName = false;
  }

  @override
  void dispose() {
    nameNode.dispose();
    nameController.dispose();
    emailNode.dispose();
    emailController.dispose();
    super.dispose();
  }

  void nextFieldOrRoute() async {
    if (!showName) {
      final String errorMessage = validateEmail();
      if (errorMessage.isNotEmpty) {
        showMessageInContext(context, errorMessage);
        return;
      }
      screenData = ScreenData.over(
        screenData,
        user: User.over(screenData.user, email: emailController.text),
      );
      setState(() => showName = true);
      NetworkController.shared.postRequest(screenData).then(
          (serverScreenData) =>
              screenData = ScreenData.merge(screenData, serverScreenData));
      return;
    }
    final String errorMessage = validateName();
    if (errorMessage.isNotEmpty) {
      showMessageInContext(context, errorMessage);
      return;
    }
    screenData = ScreenData.over(
      screenData,
      user: User.over(screenData.user, name: nameController.text),
    );

    final bool isPending =
        screenData.order.isPending || screenData.userFeedback.isPending;
    final build =
        isPending ? MainScreen(screenData) : ProfileScreen(screenData);
    final int routeIndex =
        isPending ? MainScreen.routeIndex : ProfileScreen.routeIndex;
    if (!isPending)
      screenData = await NetworkController.shared.postRequest(screenData);
    pushRouteIfValid(
      context,
      builder: (BuildContext context) => build,
      removePrevious: true,
      replace: true,
      routeIndex: routeIndex,
    );
  }

  // https://stackoverflow.com/a/16888554
  String validateEmail() {
    final String email = emailController?.text?.trim();
    if (email == null || email.isEmpty) return 'please enter your email';
    final bool valid = RegExp(
            r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email);
    if (!valid) return 'please correct your email';
    return '';
  }

  String validateName() {
    final String name = nameController?.text?.trim();
    if (name == null || name.isEmpty) return 'please enter your name';
    return '';
  }
}
