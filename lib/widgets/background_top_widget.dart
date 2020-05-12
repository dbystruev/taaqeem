//
//  lib/widgets/backgound_top_widget.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class BackgroundTopWidget extends StatelessWidget {
  final Widget child;
  final double maxOffset;
  final double scale;
  final ScrollController scrollController;
  final String subtitle;
  final String title;

  BackgroundTopWidget({
    this.child,
    this.maxOffset,
    this.scale,
    ScrollController scrollController,
    this.subtitle,
    this.title,
  }) : this.scrollController = scrollController ?? ScrollController();

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    final double scale = this.scale ?? Scale.getScale(context);
    final EdgeInsets safePadding = Scale.getSafePadding(context);
    final EdgeInsets padding = EdgeInsets.only(
      left: 20 * scale + safePadding.left,
      right: 20 * scale + safePadding.right,
    );
    Future.delayed(
      Duration(milliseconds: 100),
    ).then((_) {
      if (0 < scrollController.offset) scrollController.jumpTo(0);
      scrollController.addListener(() {
        if (maxOffset * scale < scrollController.offset) scrollController.jumpTo(maxOffset * scale);
        debugPrint('scrollController.offset / scale = ${scrollController.offset / scale}');
      });
    });
    return Container(
      child: ListView(
        children: [
          SizedBox(height: 33 * scale + safePadding.top),
          Padding(
            child: TheText.w600(
              color: color,
              fontSize: 24,
              text: title,
              textScaleFactor: scale,
            ),
            padding: padding,
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
            padding: padding,
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
        physics: Scale.isHorizontal(context)
            ? ClampingScrollPhysics()
            : NeverScrollableScrollPhysics(),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/images/background_top.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
