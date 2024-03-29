//
//  lib/widgets/decoration_padding_widget.dart
//
//  Created by Denis Bystruev on 29/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/image_widget.dart';
import 'package:taaqeem/widgets/padding_widget.dart';

class DecorationPaddingWidget extends StatelessWidget {
  final AlignmentGeometry alignment;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final Widget child;
  final Decoration decoration;
  final double height;
  final String icon;
  final double iconHeight;
  final double iconWidth;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double scale;
  final double width;

  DecorationPaddingWidget({
    this.alignment = Alignment.centerLeft,
    this.borderColor = globals.subtitleColor,
    this.borderRadius = 5,
    this.borderWidth = 1,
    @required this.child,
    this.decoration,
    this.height = 52,
    this.icon,
    this.iconHeight = 20,
    this.iconWidth = 20,
    double marginBottom,
    double marginLeft,
    double marginRight,
    double marginTop,
    double paddingBottom,
    double paddingLeft,
    double paddingRight,
    double paddingTop,
    this.scale,
    this.width,
  })  : this.marginBottom = marginBottom ?? 5,
        this.marginLeft = marginLeft ?? 20,
        this.marginRight = marginRight ?? 20,
        this.marginTop = marginTop ?? 5,
        this.paddingBottom = paddingBottom ?? 0,
        this.paddingLeft = paddingLeft ?? 15,
        this.paddingRight = paddingRight ?? 15,
        this.paddingTop = paddingTop ?? 0;

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    return PaddingWidget(
      child: Container(
        alignment: alignment,
        child: Row(
          children: [
            Expanded(child: child),
            ImageWidget(icon, height: iconHeight, width: iconWidth)
          ],
        ),
        decoration: decoration ??
            BoxDecoration(
              border:
                  Border.all(color: borderColor, width: borderWidth * scale),
              borderRadius: BorderRadius.circular(borderRadius * scale),
            ),
        height: height * scale,
        padding: EdgeInsets.fromLTRB(
          paddingLeft * scale,
          paddingTop * scale,
          paddingRight * scale,
          paddingBottom * scale,
        ),
        width: width == null ? null : width * scale,
      ),
      marginBottom: marginBottom,
      marginLeft: marginLeft,
      marginRight: marginRight,
      marginTop: marginTop,
      scale: scale,
    );
  }
}
