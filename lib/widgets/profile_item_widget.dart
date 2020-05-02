//
//  lib/widgets/profile_item_widget.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class ProfileItemWidget extends StatelessWidget with Scale {
  final double scale;
  final String superscript;
  final Color superscriptColor;
  final double superscriptFontSize;
  final double superscriptHeight;
  final String text;
  final Color textColor;
  final double textFontSize;
  final double textHeight;

  ProfileItemWidget(
    this.superscript,
    this.text, {
    this.scale,
    this.superscriptColor = globals.superscriptColor,
    this.superscriptFontSize = 16,
    this.superscriptHeight = 1.75,
    this.textColor = globals.textColor,
    this.textFontSize = 18,
    this.textHeight = 2.11,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    return Column(
      children: [
        TheText.normal(
          color: superscriptColor,
          fontSize: superscriptFontSize,
          height: superscriptHeight,
          text: superscript,
          textScaleFactor: scale,
        ),
        SizedBox(height: 6 * scale),
        TheText.w600(
          color: textColor,
          fontSize: textFontSize,
          height: textHeight,
          text: text,
          textScaleFactor: scale,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
