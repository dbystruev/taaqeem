//
//  lib/widgets/plus_button_widget.dart
//
//  Created by Denis Bystruev on 29/04/2020.
//

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/text_widgets.dart';

class PlusButtonWidget extends StatelessWidget with Scale {
  final Color backgroundColor;
  final double blurRadius;
  final Color color;
  final void Function() onTap;
  final double radius;
  final double scale;

  PlusButtonWidget({
    this.backgroundColor = globals.accentColor,
    this.color = globals.primaryColor,
    this.onTap,
    this.radius = 27,
    this.scale,
  }) : blurRadius = max(10, 30 - radius);

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? getScale(context);
    final double doubleScale = 2 * scale;
    final double plusSize = doubleScale * (radius - 5);
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Container(),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: blurRadius * scale,
                  color: globals.shadowColor,
                ),
              ],
              color: color,
              shape: BoxShape.circle,
            ),
            height: doubleScale * radius,
            width: doubleScale * radius,
          ),
          Column(
            children: [
              Expanded(
                child: Container(color: Colors.transparent),
              ),
              Expanded(
                child: Container(color: color),
              ),
            ],
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              child: TheText.bold(
                color: color,
                fontSize: 30,
                text: '+',
                textScaleFactor: scale,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              height: plusSize,
              width: plusSize,
            ),
            onTap: onTap,
          )
        ],
      ),
      height: doubleScale * (radius + blurRadius),
      width: doubleScale * (radius + blurRadius),
    );
  }
}
