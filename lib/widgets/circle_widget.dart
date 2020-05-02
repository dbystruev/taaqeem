//
//  lib/widgets/circle_icon_widget.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/scale_mixin.dart';

class CircleWidget extends StatelessWidget {
  final Color borderColor;
  final double borderWidth;
  final Widget child;
  final Color color;
  final double radius;
  final double scale;

  CircleWidget({
    this.borderColor = globals.accentColor,
    this.borderWidth = 1,
    this.child,
    this.color = globals.primaryColor,
    this.radius = 28.5,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    final double radius = this.radius * scale;
    final double diameter = 2 * radius;
    return Container(
      child: Center(child: child),
      decoration: ShapeDecoration(
        color: color,
        shape: CircleBorder(
          side: BorderSide(
            color: borderColor,
            width: borderWidth * scale,
          ),
        ),
      ),
      height: diameter,
      width: diameter,
    );
  }
}
