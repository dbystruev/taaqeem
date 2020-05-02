//
//  lib/widgets/circle_icon_widget.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/widgets/circle_widget.dart';
import 'package:taaqeem/widgets/image_widget.dart';

class CircleIconWidget extends StatelessWidget with Scale {
  final Color borderColor;
  final double borderWidth;
  final Color color;
  final String iconName;
  final double iconSize;
  final double radius;
  final double scale;

  CircleIconWidget(
    this.iconName, {
    this.borderColor = globals.accentColor,
    this.borderWidth = 1,
    this.color = globals.primaryColor,
    this.iconSize = 19,
    this.radius = 28.5,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    final double iconSize = this.iconSize * scale;
    final double radius = this.radius * scale;
    return CircleWidget(
      borderColor: borderColor,
      borderWidth: borderWidth,
      child: ImageWidget(
        iconName,
        height: iconSize,
        scale: scale,
        width: iconSize,
      ),
      radius: radius,
      scale: scale,
    );
  }
}
