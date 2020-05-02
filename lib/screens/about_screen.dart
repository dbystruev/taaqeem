//
//  lib/screens/about_screen.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/widgets/about_item_widget.dart';
import 'package:taaqeem/widgets/background_top_widget.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/circle_icon_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/scaffold_bar_widget.dart';

class AboutScreen extends StatelessWidget with Scale, RouteValidator {
  static const int routeIndex = 1;
  static String get routeName => NavigatorWidget.routeName(routeIndex);

  final ScreenData screenData;

  AboutScreen(ScreenData screenData)
      : this.screenData = ScreenData.over(screenData, routeIndex: routeIndex);

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getScale(context);
    return ScaffoldBarWidget(
      body: BackgroundTopWidget(
        child: Padding(
          child: Column(
            children: [
              SizedBox(height: 29 * scale),
              AboutItemWidget(
                'mail_icon',
                iconSize: 20,
                scale: scale,
                superscript: 'E-mail address:',
                text: 'info@taaqeem.ae',
              ),
              SizedBox(height: 32 * scale),
              AboutItemWidget(
                'web_icon',
                iconSize: 25,
                scale: scale,
                superscript: 'Website:',
                text: 'www.taaqeem.ae',
              ),
              SizedBox(height: 31 * scale),
              AboutItemWidget(
                'point_icon',
                iconSize: 22,
                scale: scale,
                superscript: 'Address:',
                text: 'Dubai, United\nArab Emirates',
              ),
              SizedBox(height: 48 * scale),
              ButtonWidget(
                'Сall us +971 55 999 9863',
                onPressed: () {},
                width: Scale.getScreenWidth(context),
                scale: scale,
              ),
              SizedBox(height: 20 * scale),
              Row(
                children: [
                  CircleIconWidget('facebook_icon', scale: scale),
                  SizedBox(width: 12 * scale),
                  CircleIconWidget('instagram_icon', scale: scale),
                  SizedBox(width: 12 * scale),
                  CircleIconWidget('telegram_icon', iconSize: 22, scale: scale),
                  SizedBox(width: 12 * scale),
                  CircleIconWidget('whatsapp_icon', scale: scale),
                  SizedBox(width: 12 * scale),
                  CircleIconWidget('youtube_icon', scale: scale),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              SizedBox(
                height: max(200, Scale.getScreenHeight(context) - 540) * scale,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20 * scale),
        ),
        subtitle:
            'Write to us in messengers, call\nor look at the answers to FAQ',
        title: 'How can we help you?',
      ),
      screenData: screenData,
    );
  }
}
