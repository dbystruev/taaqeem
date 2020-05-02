//
//  lib/widgets/circle_icon_widget.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/controllers/network_controller.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/widgets/circle_widget.dart';
import 'package:taaqeem/widgets/image_widget.dart';

class CircleIconWidget extends StatelessWidget {
  final Color borderColor;
  final double borderWidth;
  final Color color;
  final String iconName;
  final double iconSize;
  final double radius;
  final double scale;
  final String url;

  CircleIconWidget(
    this.iconName, {
    this.borderColor = globals.accentColor,
    this.borderWidth = 1,
    this.color = globals.primaryColor,
    this.iconSize = 19,
    this.radius = 28.5,
    this.scale,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    final double iconSize = this.iconSize * scale;
    final double radius = this.radius * scale;
    final Widget widget = CircleWidget(
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
    return url == null
        ? widget
        : InkWell(
            child: widget,
            onTap: () => NetworkController.launchURL(url),
          );
  }
}
