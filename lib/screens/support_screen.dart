//
//  lib/screens/support_screen.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taaqeem/controllers/network_controller.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/widgets/background_top_widget.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/circle_icon_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/scaffold_bar_widget.dart';
import 'package:taaqeem/widgets/support_item_widget.dart';

class SupportScreen extends StatelessWidget with RouteValidator {
  static const routeIndex = 2;
  static String get routeName => NavigatorWidget.routeName(routeIndex);

  final ScreenData screenData;

  SupportScreen(ScreenData screenData)
      : this.screenData = ScreenData.over(screenData, routeIndex: routeIndex);

  @override
  Widget build(BuildContext context) {
    final EdgeInsets safePadding = Scale.getSafePadding(context);
    final double scale = Scale.getScale(context);
    return ScaffoldBarWidget(
      body: BackgroundTopWidget(
        child: Padding(
          child: Column(
            children: [
              SizedBox(height: 28 * scale),
              SupportItemWidget(
                'mail_icon',
                iconSize: 20,
                scale: scale,
                superscript: 'E-mail address:',
                text: 'info@taaqeem.ae',
                url: 'mailto:info@taaqeem.ae',
              ),
              SizedBox(height: 32 * scale),
              SupportItemWidget(
                'web_icon',
                iconSize: 25,
                scale: scale,
                superscript: 'Website:',
                text: 'www.taaqeem.ae',
                url: 'https://taaqeem.ae/',
              ),
              SizedBox(height: 31 * scale),
              SupportItemWidget(
                'point_icon',
                iconSize: 22,
                scale: scale,
                superscript: 'Address:',
                text: 'Dubai, United\nArab Emirates',
                url: 'https://goo.gl/maps/rugvndYnKKqXu9hL7',
              ),
              SizedBox(height: 48 * scale),
              ButtonWidget(
                'Сall us +971 55 999 9863',
                onPressed: () =>
                    NetworkController.launchURL('tel:+971-55-999-9863'),
                scale: scale,
                width: 335,
              ),
              SizedBox(height: 20 * scale),
              Row(
                children: [
                  CircleIconWidget(
                    'facebook_icon',
                    scale: scale,
                    url:
                        'https://www.facebook.com/taaqeem?roistat_visit=105268',
                  ),
                  CircleIconWidget(
                    'instagram_icon',
                    scale: scale,
                    url:
                        'https://www.instagram.com/taaqeem.ae/?roistat_visit=105268',
                  ),
                  CircleIconWidget(
                    'whatsapp_icon',
                    scale: scale,
                    url:
                        'https://wa.me/971508689923?roistat_visit=105268&text=Please%20send%20this%20message%20and%20wait%20for%20a%20response.%20Your%20ticket%20number:%20105268',
                  ),
                  CircleIconWidget(
                    'youtube_icon',
                    scale: scale,
                    url:
                        'https://www.youtube.com/channel/UCuBMtezf2_IqaSWAPeKhCpg?roistat_visit=105268',
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              SizedBox(
                height: max(200, Scale.getScreenHeight(context) - 540) * scale,
              ),
            ],
          ),
          padding: EdgeInsets.only(
            left: 20 * scale + safePadding.left,
            right: 20 * scale + safePadding.right,
          ),
        ),
        maxOffset: 360,
        scale: scale,
        subtitle:
            'Write to us in messengers, call\nor look at the answers to FAQ',
        title: 'How can we help you?',
      ),
      color: Scale.isHorizontal(context)
          ? Theme.of(context).primaryColor
          : globals.backgroundTopColor,
      getScreenData: () => screenData,
      safeAreaLeft: false,
      safeAreaRight: false,
      safeAreaTop: false,
    );
  }
}
