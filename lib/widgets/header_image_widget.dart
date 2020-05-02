//
//  lib/widgets/header_image_widget.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/widgets/image_widget.dart';

class HeaderImageWidget extends StatelessWidget {
  final String imageName;
  final bool hasLogo;
  final double height;
  final EdgeInsets padding;
  final double scale;
  final double width;

  HeaderImageWidget(
    this.imageName, {
    this.hasLogo = false,
    this.height,
    this.padding = const EdgeInsets.only(top: 64),
    this.scale,
    this.width = 305,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        if (hasLogo)
          Positioned(
            child: ImageWidget('logo', suffix: 'q', height: 65, width: 46),
            right: 20 * scale,
            top: 24 * scale,
          ),
        Padding(
          child: ImageWidget(imageName, height: height, width: width),
          padding: EdgeInsets.fromLTRB(
            scale * padding.left,
            scale * padding.top,
            scale * padding.right,
            scale * padding.bottom,
          ),
        ),
      ],
    );
  }
}
