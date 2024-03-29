//
//  lib/screens/about_screen.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/screens/order_screen.dart';
import 'package:taaqeem/widgets/background_top_widget.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/image_widget.dart';
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
    final Color accentColor = Theme.of(context).accentColor;
    final EdgeInsets safePadding = Scale.getSafePadding(context);
    final double scale = Scale.getScale(context);
    return ScaffoldBarWidget(
      body: BackgroundTopWidget(
        child: Padding(
          child: Column(
            children: [
              SizedBox(height: 20 * scale),
              ImageWidget('logo', height: 68, width: 166, scale: scale),
              SizedBox(height: 20 * scale),
              TheText.w600(
                color: accentColor,
                fontSize: 28,
                height: 1,
                text: 'We are here to help you!',
                textAlign: TextAlign.center,
                textScaleFactor: scale,
              ),
              SizedBox(height: 12 * scale),
              TheText.w300(
                color: globals.menuItemColor,
                fontSize: 16,
                height: 1.75,
                text: 'Taaqeem is a platform that helps companies' +
                    ' and individuals to find the best companies in' +
                    ' the UAE to provide govt-approved sanitisation' +
                    ' and disinfection services.\n' +
                    ' We only offer sanitation and cleaning services' +
                    ' from companies that have been approved by' +
                    ' UAE Municipality and Ministry of Health and' +
                    ' Prevention UAE.',
                textAlign: TextAlign.center,
                textScaleFactor: scale,
              ),
              SizedBox(height: 16 * scale),
              ButtonWidget(
                'Book cleaning',
                onPressed: () => pushRouteIfValid(
                  context,
                  builder: (context) => OrderScreen(screenData),
                  replace: screenData.isPlanSelected,
                  routeIndex: OrderScreen.routeIndex,
                ),
                scale: scale,
                width: 335,
              ),
              SizedBox(
                height: max(160, Scale.getScreenHeight(context) - 500) * scale,
              ),
            ],
          ),
          padding: EdgeInsets.only(
            left: 20 * scale + safePadding.left,
            right: 20 * scale + safePadding.right,
          ),
        ),
        maxOffset: 260,
        scale: scale,
        subtitle:
            'The first marketplace in UAE to help protect\nYou and keep You in healthy environment',
        title: 'About us',
      ),
      color: globals.backgroundTopColor,
      getScreenData: () => screenData,
      safeAreaLeft: false,
      safeAreaRight: false,
      safeAreaTop: false,
    );
  }
}
