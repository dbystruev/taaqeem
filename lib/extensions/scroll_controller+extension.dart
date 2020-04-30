//
//  lib/extensions/scroll_controller+extension.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';

extension ScrollControllerExtension on ScrollController {
  void scrollTo(
    int index, {
    double collapsedHeight = 87,
    @required BuildContext context,
    double expandedHeight = 257,
    int expandedIndex = 2147483647,
    double footerHeight = 97,
    double headerHeight = 464,
    double scale,
  }) {
    final double localScale = scale ?? Scale.getScale(context);
    final double height = index < expandedIndex
        ? (index + 1) * collapsedHeight
        : index * collapsedHeight + expandedHeight;
    final double scrollHeight = max(
      (headerHeight + height + footerHeight) * localScale +
          Scale.getSafeMargin(context) -
          Scale.getScreenHeight(context),
      0,
    );
    this.animateTo(
      scrollHeight,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
