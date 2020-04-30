//
//  lib/widgets/back_widget.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/image_widget.dart';
import 'package:taaqeem/widgets/padding_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class BackWidget extends StatelessWidget with Scale {
  final Color color;
  final double fontSize;
  final double scale;
  final String text;

  BackWidget(
    this.text, {
    this.color = globals.textColor,
    this.fontSize = 20,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    return PaddingWidget(
      child: Row(
        children: [
          InkWell(
            child:
                ImageWidget('left', height: 15, scale: scale, width: 20),
            onTap: () {
              Navigator.pop(context);
            },
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
      marginBottom: 45,
      marginTop: 40,
    );
  }
}