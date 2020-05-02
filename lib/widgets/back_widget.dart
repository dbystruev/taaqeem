//
//  lib/widgets/back_widget.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/image_widget.dart';
import 'package:taaqeem/widgets/padding_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class BackWidget extends StatelessWidget with RouteValidator {
  final Color color;
  final double fontSize;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final double scale;
  final String text;

  BackWidget(
    this.text, {
    this.color = globals.textColor,
    this.fontSize = 20,
    this.marginBottom = 45,
    this.marginLeft = 20,
    this.marginRight = 20,
    this.marginTop = 40,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    return PaddingWidget(
      child: Row(
        children: [
          InkWell(
            child: ImageWidget('left', height: 15, scale: scale, width: 20),
            onTap: () => popRoute(context),
          ),
          SizedBox(width: 15 * scale),
          TheText.w600(
            color: color,
            fontSize: fontSize,
            text: text,
            textScaleFactor: scale,
          ),
        ],
      ),
      marginBottom: marginBottom,
      marginLeft: marginLeft,
      marginRight: marginRight,
      marginTop: marginTop,
    );
  }
}
