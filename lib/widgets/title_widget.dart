//
//  lib/widgets/title_widget.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/text_widgets.dart';

class TitleWidget extends StatelessWidget with Scale {
  final double scale;
  final String title;
  final double titleHeight;
  final double titleSize;
  final String subtitle;
  final double subtitleHeight;
  final double subtitleSize;

  TitleWidget(
    this.title, {
    this.scale,
    this.titleHeight,
    this.titleSize = 22,
    this.subtitle,
    this.subtitleHeight = 1.6,
    this.subtitleSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    return Padding(
      child: Column(
        children: [
          TheText.w600(
            fontSize: titleSize,
            height: titleHeight,
            text: title,
            textScaleFactor: scale,
          ),
          SizedBox(height: 10 * scale),
          TheText.normal(
            color: globals.subtitleColor,
            fontSize: subtitleSize,
            height: subtitleHeight,
            text: subtitle,
            textScaleFactor: scale,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: EdgeInsets.fromLTRB(20 * scale, 0, 20 * scale, 16 * scale),
    );
  }
}
