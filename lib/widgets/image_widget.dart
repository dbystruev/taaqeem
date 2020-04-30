//
//  lib/widgets/image_widget.dart
//
//  Created by Denis Bystruev on 27/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';

class ImageWidget extends StatelessWidget with Scale {
  final double height;
  final String name;
  final double scale;
  final String suffix;
  final double width;

  ImageWidget(
    this.name,
    this.suffix, {
    this.height = 9,
    this.scale,
    this.width = 15,
  });

  @override
  Widget build(BuildContext context) {
    if (name == null) return Container();
    final String imageSuffix = suffix == null ? '' : '_$suffix';
    final String imageName = 'assets/images/$name$imageSuffix.png';
    final double scale = this.scale ?? Scale.getScale(context);
    final double imageHeight = height == null ? null : height * scale;
    final double imageWidth = width == null ? null : width * scale;
    return name.startsWith('http')
        ? Image.network(name, height: imageHeight, width: imageWidth)
        : Image.asset(imageName, height: imageHeight, width: imageWidth);
  }
}
