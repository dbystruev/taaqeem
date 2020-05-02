//
//  lib/screens/about_screen.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/scaffold_bar_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class AboutScreen extends StatelessWidget with RouteValidator {
  static const int routeIndex = 1;
  static String get routeName => NavigatorWidget.routeName(routeIndex);

  final ScreenData screenData;

  AboutScreen(ScreenData screenData)
      : this.screenData = ScreenData.over(screenData, routeIndex: routeIndex);

  @override
  Widget build(BuildContext context) {
    return ScaffoldBarWidget(
      body: Center(
        child: TheText(text: 'AboutScreen'),
      ),
      screenData: screenData,
    );
  }
}
