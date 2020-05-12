//
//  lib/extensions/scroll_controller+extension.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';

extension ScrollControllerExtension on ScrollController {
  void scrollTo(
    int index, {
    double collapsedHeight = 87,
    @required BuildContext context,
    double expandedHeight = 257,
    double footerHeight = 97,
    double headerHeight = 464,
    double scale,
  }) {
    headerHeight += Scale.getSafePadding(context).top;
    final double localScale = scale ?? Scale.getScale(context);
    final double height = index * collapsedHeight + expandedHeight;
    final double fullHeight =
        (headerHeight + height + footerHeight) * localScale - offset;
    final double offsetDifference = fullHeight - Scale.getScreenHeight(context);
    if (0 < offsetDifference) {
      final double nextOffset = offset + offsetDifference;
      jumpTo(nextOffset);
    }
  }
}
