//
//  lib/design/scale.dart
//
//  Created by Denis Bystruev on 11/03/2020, updated 18/04/2020.
//

import 'dart:math';
import 'package:flutter/material.dart';

mixin Scale {
  // Defaults to iPhone 11 Pro / iPhone X (https://useyourloaf.com/blog/supporting-iphone-x)
  static const double defaultLongerSize = 812;
  static const double defaultSafeAreaLandscapeHeight = 354; // bottom: 21
  static const double defaultSafeAreaLandscapeWidth = 724; // left/right: 44
  static const double defaultSafeAreaPortraitHeight = 734; // bottom: 34 top: 44
  static const double defaultSafeAreaPortraitWidth = 375; // left/right: 0
  static const double defaultShorterSize = 375;

  bool isHorizontal(BuildContext context) =>
      MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;

  double getScale(
    BuildContext context, {
    bool deductSafeArea = false,
    double designHeight,
    double designWidth,
  }) {
    final bool isLandscape = isHorizontal(context);
    final double safeAreaHeight = isLandscape
        ? defaultSafeAreaLandscapeHeight
        : defaultSafeAreaPortraitHeight;
    final double safeAreaWidth = isLandscape
        ? defaultSafeAreaLandscapeWidth
        : defaultSafeAreaPortraitWidth;
    final double defaultHeight =
        isLandscape ? defaultShorterSize : defaultLongerSize;
    final double defaultWidth =
        isLandscape ? defaultLongerSize : defaultShorterSize;
    final double deductHeight =
        deductSafeArea ? defaultHeight - safeAreaHeight : 0;
    final double deductWidth =
        deductSafeArea ? defaultWidth - safeAreaWidth : 0;
    final double height = designHeight == null || designHeight <= 0
        ? defaultHeight - deductHeight
        : designHeight;
    final double width = designWidth == null || designWidth <= 0
        ? defaultWidth - deductWidth
        : designWidth;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalScale = screenWidth / width;
    final double verticalScale = screenHeight / height;
    final double scale = min(horizontalScale, verticalScale);
    // debugPrint(
    //     'DEBUG in lib/design/scale.dart line 55: design $width x $height, screen $screenWidth x $screenHeight, scale = $scale');
    return scale;
  }
}
