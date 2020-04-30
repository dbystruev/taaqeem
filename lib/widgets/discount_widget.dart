//
//  lib/widgets/discount_widget.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/image_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class DiscountWidget extends StatelessWidget with Scale {
  final double scale;
  final String text;

  DiscountWidget(this.text, {this.scale});

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    return Padding(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Container(
              child: TheText.w600(
                color: globals.discountTextColor,
                fontSize: 18,
                text: text,
                textScaleFactor: scale,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6 * scale),
                color: globals.discountBackgroundColor,
              ),
              height: 65 * scale,
              padding: EdgeInsets.only(left: 20 * scale, top: 10 * scale),
              width: 335 * scale,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 15 * scale,
                  color: globals.shadowColor,
                ),
              ],
            ),
            padding: EdgeInsets.only(top: 10 * scale),
          ),
          Positioned(
            bottom: 14 * scale,
            child: Container(
              child: ImageWidget('wow', height: 40, width: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6 * scale),
                color: Theme.of(context).primaryColor,
              ),
              height: 60 * scale,
              padding: EdgeInsets.symmetric(vertical: 10 * scale),
              width: 60 * scale,
            ),
            left: Scale.getMidX(context) +
                77.5 * scale -
                Scale.getSafeMargin(context),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        bottom: 15 * scale,
        left: 20 * scale,
        right: 20 * scale,
        top: 16 * scale,
      ),
    );
  }
}
