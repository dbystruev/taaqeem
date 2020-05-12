//
//  lib/screens/profile_screen.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/controllers/network_controller.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/models/user.dart';
import 'package:taaqeem/screens/feedback_screen.dart';
import 'package:taaqeem/screens/main_screen.dart';
import 'package:taaqeem/screens/profile_edit_screen.dart';
import 'package:taaqeem/widgets/avatar_widget.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/image_widget.dart';
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
    final double scale = Scale.getHorizontalScale(context);
    final User user = widget.screenData.user;
    final bool userHasName = user.name != null && user.name.trim().isNotEmpty;
    final bool userHasEmail =
        user.email != null && user.email.trim().isNotEmpty;
    return ScaffoldBarWidget(
      body: Stack(
        children: [
          Positioned(
            child: AvatarWidget(user, scale: scale),
            right: 21 * scale,
            top: 33 * scale,
          ),
          ListView(
            children: [
              SizedBox(height: 33 * scale),
              if (userHasName)
                Padding(
                  child: TheText.w600(
                    color: globals.textColor,
                    fontSize: 24,
                    text: user.name,
                    textScaleFactor: scale,
                  ),
                  padding: EdgeInsets.only(right: 70 * scale),
                ),
              if (userHasName) SizedBox(height: 35 * scale),
              ProfileItemWidget('Your phone', user.phone),
              if (userHasEmail) SizedBox(height: 20 * scale),
              if (userHasEmail) ProfileItemWidget('Your e-mail', user.email),
              if (userHasEmail) SizedBox(height: 36 * scale),
              if (userHasEmail)
                InkWell(
                  child: Row(
                    children: [
                      TheText.normal(
                        color: globals.subtitleColor,
                        fontSize: 16,
                        height: 1.75,
                        text: 'Edit info',
                        textScaleFactor: scale,
                      ),
                      SizedBox(width: 12 * scale),
                      ImageWidget('pen', height: 15, scale: scale, width: 15),
                    ],
                  ),
                  onTap: editProfile,
                ),
              if (userHasEmail) SizedBox(height: 54 * scale),
              if (!userHasEmail) SizedBox(height: 35 * scale),
              if (!userHasEmail)
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
              if (!userHasEmail) SizedBox(height: 183 * scale),
              ButtonWidget(
                'Give us a feedback',
                onPressed: leaveFeedback,
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
            padding: EdgeInsets.symmetric(horizontal: 20 * scale),
          ),
        ],
      ),
      getScreenData: () => widget.screenData,
    );
  }

  void editProfile() {
    pushRouteIfValid(
      context,
      builder: (context) => ProfileEditScreen(widget.screenData),
      routeIndex: ProfileEditScreen.routeIndex,
    );
  }

  @override
  void initState() {
    super.initState();
    NetworkController.shared.saveScreenDataToPrefs(widget.screenData);
  }

  void leaveFeedback() {
    pushRouteIfValid(
      context,
      builder: (context) => FeedbackScreen(widget.screenData),
      routeIndex: FeedbackScreen.routeIndex,
    );
  }

  void logout() {
    final ScreenData screenData = ScreenData.logout(widget.screenData);
    NetworkController.shared.saveScreenDataToPrefs(screenData);
    pushRouteIfValid(
      context,
      builder: (context) => MainScreen(screenData, message: 'You have been logged out'),
      replace: true,
      routeIndex: MainScreen.routeIndex,
    );
  }
}
