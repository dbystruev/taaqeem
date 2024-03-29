//
//  lib/mixins/scale_mixin.dart
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
  static const double maxScale = 1.25;

  static bool isHorizontal(BuildContext context) =>
      getScreenHeight(context) < getScreenWidth(context);

  static double getHorizontalScale(
    BuildContext context, {
    bool deductSafeArea = false,
    double designWidth,
  }) {
    final bool isLandscape = isHorizontal(context);
    final double safeAreaWidth = isLandscape
        ? defaultSafeAreaLandscapeWidth
        : defaultSafeAreaPortraitWidth;
    final double defaultWidth =
        isLandscape ? defaultLongerSize : defaultShorterSize;
    final double deductWidth =
        deductSafeArea ? defaultWidth - safeAreaWidth : 0;
    final double width = designWidth == null || designWidth <= 0
        ? defaultWidth - deductWidth
        : designWidth;
    final double horizontalScale = getScreenWidth(context) / width;
    return min(horizontalScale, maxScale);
  }

  static double getMidX(BuildContext context) => getScreenWidth(context) / 2;

  static double getMidY(BuildContext context) => getScreenHeight(context) / 2;

  static EdgeInsets getSafePadding(BuildContext context) =>
      MediaQuery.of(context).padding;

  static double getScale(
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
    final double horizontalScale = getScreenWidth(context) / width;
    final double verticalScale = getScreenHeight(context) / height;
    final double scale = min(horizontalScale, verticalScale);
    // debugPrint('lib/mixins/scale_mixin.dart:80 scale = ${min(scale, maxScale)}');
    return min(scale, maxScale);
  }

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getVerticalScale(
    BuildContext context, {
    bool deductSafeArea = false,
    double designHeight,
  }) {
    final bool isLandscape = isHorizontal(context);
    final double safeAreaHeight = isLandscape
        ? defaultSafeAreaLandscapeHeight
        : defaultSafeAreaPortraitHeight;
    final double defaultHeight =
        isLandscape ? defaultShorterSize : defaultLongerSize;
    final double deductHeight =
        deductSafeArea ? defaultHeight - safeAreaHeight : 0;
    final double height = designHeight == null || designHeight <= 0
        ? defaultHeight - deductHeight
        : designHeight;
    final double verticalScale = getScreenHeight(context) / height;
    return min(verticalScale, maxScale);
  }
}
