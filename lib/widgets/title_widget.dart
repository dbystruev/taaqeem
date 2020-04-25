//
//  lib/widgets/title_widget.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/text_widgets.dart';

class TitleWidget extends StatelessWidget {
  final double scale;
  final String title;
  final double titleSize;
  final String subtitle;
  final double subtitleSize;

  TitleWidget(
    this.title, {
    this.scale,
    this.titleSize,
    this.subtitle,
    this.subtitleSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        children: [
          TheText.w600(
            fontSize: titleSize,
            text: title,
            textScaleFactor: scale,
          ),
          SizedBox(height: 10 * scale),
          TheText.normal(
            color: globals.subtitleColor,
            fontSize: subtitleSize,
            text: subtitle,
            textScaleFactor: scale,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
    );
  }
}
