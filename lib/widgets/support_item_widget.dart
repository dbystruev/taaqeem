//
//  lib/widgets/support_item_widget.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/controllers/network_controller.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/widgets/circle_icon_widget.dart';
import 'package:taaqeem/widgets/profile_item_widget.dart';

class SupportItemWidget extends StatelessWidget with Scale {
  final String iconName;
  final double iconSize;
  final double scale;
  final String superscript;
  final Color superscriptColor;
  final double superscriptFontSize;
  final double superscriptHeight;
  final String text;
  final Color textColor;
  final double textFontSize;
  final double textHeight;
  final String url;

  SupportItemWidget(
    this.iconName, {
    this.iconSize = 25,
    this.scale,
    this.superscript,
    this.superscriptColor = globals.superscriptColor,
    this.superscriptFontSize = 16,
    this.superscriptHeight = 1.75,
    this.text,
    this.textColor = globals.accentColor,
    this.textFontSize = 24,
    this.textHeight = 1.58,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    final Widget widget = Row(
      children: [
        CircleIconWidget(iconName,
            iconSize: iconSize, radius: 22.5, scale: scale),
        SizedBox(width: 20 * scale),
        ProfileItemWidget(
          superscript,
          text,
          scale: scale,
          superscriptColor: superscriptColor,
          superscriptFontSize: superscriptFontSize,
          superscriptHeight: superscriptHeight,
          textColor: textColor,
          textFontSize: textFontSize,
          textHeight: textHeight,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
    return url == null
        ? widget
        : InkWell(
            child: widget,
            onTap: () => NetworkController.launchURL(url),
          );
  }
}
