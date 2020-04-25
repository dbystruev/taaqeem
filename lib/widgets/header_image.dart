//
//  lib/widgets/header_image.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  final String imageName;
  final bool hasLogo;
  final double height;
  final EdgeInsets padding;
  final double scale;
  final double width;

  HeaderImage(
    this.imageName, {
    this.hasLogo = false,
    @required this.height,
    this.padding = const EdgeInsets.all(0),
    this.scale = 1,
    @required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (hasLogo)
          Positioned(
            child: Image(
              height: 65 * scale,
              image: AssetImage('assets/images/logo_q.png'),
              width: 46 * scale,
            ),
            right: 20 * scale,
            top: 24 * scale,
          ),
        Padding(
          child: Image(
            height: height * scale,
            image: AssetImage(imageName),
            width: width * scale,
          ),
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
