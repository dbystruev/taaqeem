//
//  lib/screens/feedback_screen.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/models/user_feedback.dart';
import 'package:taaqeem/screens/main_screen.dart';
import 'package:taaqeem/widgets/back_widget.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/form_widget.dart';
import 'package:taaqeem/widgets/keyboard_actions_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/scaffold_bar_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class FeedbackScreen extends StatelessWidget with RouteValidator {
  static const routeIndex = 8;
  static String get routeName => NavigatorWidget.routeName(routeIndex);

  final TextEditingController feedbackController = TextEditingController();
  final FocusNode feedbackNode = FocusNode();
  final ScreenData screenData;

  FeedbackScreen(ScreenData screenData)
      : this.screenData = ScreenData.over(screenData, routeIndex: routeIndex);

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getHorizontalScale(context);
    return ScaffoldBarWidget(
      body: KeyboardActionsWidget(
        child: ListView(
          children: [
            BackWidget(
              'Give us a feedback',
              marginBottom: 20,
              // marginTop: 31,
              scale: scale,
            ),
            Padding(
              child: TheText.normal(
                color: globals.subtitleColor,
                fontSize: 15,
                height: 1.6,
                text: 'What should we pay attention\nto in our service?',
                textScaleFactor: scale,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20 * scale),
            ),
            SizedBox(height: 25 * scale),
            FormWidget(
              borderColor: globals.subtitleColor,
              boxHeight: 85,
              color: globals.textColor,
              controller: feedbackController,
              hintColor: globals.subtitleColor,
              hintText: 'Your commentary',
              keyboardNode: feedbackNode,
              keyboardType: TextInputType.text,
              maxLines: 3,
              onEditingComplete: () => routeToMainScreenIfValid(context),
              scale: scale,
            ),
            SizedBox(height: 5 * scale),
            ButtonWidget(
              'Send a feedback',
              onPressed: () => routeToMainScreenIfValid(context),
              scale: scale,
              width: 335,
            )
          ],
        ),
        focusNode: feedbackNode,
        onTapAction: () => routeToMainScreenIfValid(context),
      ),
      getScreenData: () => screenData,
      removePreviousRoute: true,
    );
  }

  void routeToMainScreenIfValid(BuildContext context) {
    final String errorMessage = validateFeedback();
    if (errorMessage.isNotEmpty)
      showMessageInContext(context, errorMessage);
    else {
      final ScreenData screenData = ScreenData.over(
        this.screenData,
        userFeedback: UserFeedback.over(
          this.screenData.userFeedback,
          date: DateTime.now(),
          text: feedbackController.text,
        ),
      );
      pushRouteIfValid(
        context,
        builder: (context) => MainScreen(screenData),
        removePrevious: true,
        replace: true,
        routeIndex: MainScreen.routeIndex,
      );
    }
  }

  /// Returns empty String if the sending is good
  /// Returns error message if feedback was not sent
  String validateFeedback() {
    final String comment = feedbackController?.text?.trim();
    if (comment == null || comment.isEmpty)
      return 'please leave some commentary';
    return '';
  }
}
