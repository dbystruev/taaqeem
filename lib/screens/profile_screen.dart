//
//  lib/screens/profile_screen.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/models/user.dart';
import 'package:taaqeem/screens/main_screen.dart';
import 'package:taaqeem/screens/profile_edit_screen.dart';
import 'package:taaqeem/widgets/avatar_widget.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/profile_item_widget.dart';
import 'package:taaqeem/widgets/scaffold_bar_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class ProfileScreen extends StatefulWidget {
  static const routeIndex = 6;
  static String get routeName => NavigatorWidget.routeName(routeIndex);

  final ScreenData screenData;

  ProfileScreen(ScreenData screenData)
      : this.screenData = ScreenData.over(screenData, routeIndex: routeIndex);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with RouteValidator {
  @override
  Widget build(BuildContext context) {
    final double safeMargin = Scale.getSafeMargin(context);
    final double scale = Scale.getScale(context);
    return ScaffoldBarWidget(
      body: Stack(
        children: [
          Positioned(
            child: AvatarWidget(widget.screenData.user, scale: scale),
            right: 21 * scale + safeMargin,
            top: 33 * scale + safeMargin,
          ),
          ListView(
            children: [
              SizedBox(height: 33 * scale),
              ProfileItemWidget('Your phone', widget.screenData.user.phone),
              SizedBox(height: 35 * scale),
              InkWell(
                child: TheText.normal(
                  color: Theme.of(context).accentColor,
                  fontSize: 16,
                  height: 1.75,
                  text: 'Please introduce yourself',
                  textScaleFactor: scale,
                ),
                onTap: editProfile,
              ),
              SizedBox(height: 183 * scale),
              ButtonWidget(
                'Give us a feedback',
                onPressed: () {},
                width: 335,
                scale: scale,
              ),
              SizedBox(height: 10 * scale),
              ButtonWidget(
                'Log out',
                borderColor: Theme.of(context).accentColor,
                borderWidth: 1,
                buttonColor: Theme.of(context).primaryColor,
                imageHeight: 20,
                imageName: 'logout',
                imageWidth: 20,
                onPressed: logout,
                scale: scale,
                textColor: Theme.of(context).accentColor,
                textDecoration: TextDecoration.underline,
                width: 335,
              ),
              SizedBox(height: 40 * scale),
              TheText.w600(
                color: globals.hintColor,
                fontSize: 16,
                height: 1.75,
                text: 'Taaqeem. Version 1.0.',
                textAlign: TextAlign.center,
                textScaleFactor: scale,
              ),
            ],
            padding: EdgeInsets.symmetric(
              horizontal: 20 * scale + safeMargin,
              vertical: safeMargin,
            ),
          ),
        ],
      ),
      screenData: widget.screenData,
    );
  }

  void editProfile() {
    pushRouteIfValid(
      context,
      builder: (context) => ProfileEditScreen(widget.screenData),
      name: ProfileEditScreen.routeName,
    );
  }

  void logout() {
    pushRouteIfValid(
      context,
      builder: (context) => MainScreen(
        ScreenData.over(
          widget.screenData,
          user: User(),
        ),
      ),
      name: MainScreen.routeName,
      replace: true,
    );
  }
}
