//
//  lib/widgets/backgound_top_widget.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class BackgroundTopWidget extends StatelessWidget {
  final Widget child;
  final double scale;
  final ScrollController scrollController;
  final String subtitle;
  final String title;

  BackgroundTopWidget({
    this.child,
    this.scale,
    this.scrollController,
    this.subtitle,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    final double safeMargin = Scale.getSafeMargin(context);
    final double scale = this.scale ?? Scale.getScale(context);
    return Container(
      child: ListView(
        children: [
          SizedBox(height: 33 * scale + safeMargin),
          Padding(
            child: TheText.w600(
              color: color,
              fontSize: 24,
              text: title,
              textScaleFactor: scale,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20 * scale + safeMargin),
          ),
          SizedBox(height: 20 * scale),
          Padding(
            child: TheText.normal(
              color: color,
              fontSize: 15,
              height: 1.6,
              text: subtitle,
              textScaleFactor: scale,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20 * scale + safeMargin),
          ),
          SizedBox(height: 36 * scale),
          Container(
            child: child,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30 * scale),
              color: color,
            ),
            width: double.infinity,
          ),
        ],
        controller: scrollController,
        padding: EdgeInsets.zero,
      ),
      decoration: BoxDecoration(
        color: globals.backgroundTopColor,
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage("assets/images/background_top.png"),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
