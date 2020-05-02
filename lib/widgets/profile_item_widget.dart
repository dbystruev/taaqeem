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
  final String text;

  ProfileItemWidget(this.superscript, this.text, {this.scale});

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    return Column(
      children: [
        TheText.normal(
          color: globals.superscriptColor,
          fontSize: 16,
          height: 1.75,
          text: superscript,
          textScaleFactor: scale,
        ),
        SizedBox(height: 6 * scale),
        TheText.w600(
          color: globals.textColor,
          fontSize: 18,
          height: 2.11,
          text: text,
          textScaleFactor: scale,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
