//
//  lib/widgets/dropdown_widget.dart
//
//  Created by Denis Bystruev on 29/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/decoration_widget.dart';
import 'package:taaqeem/widgets/image_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class DropdownWidget extends StatelessWidget with Scale {
  final String hint;
  final List<String> items;
  final ValueChanged<int> onChanged;
  final double scale;
  final int selectedService;

  DropdownWidget(
    this.items, {
    this.hint,
    @required this.onChanged,
    this.scale,
    this.selectedService,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    Widget itemWidget(
      String text, {
      bool showDivider = false,
      bool isHint = false,
      bool isLast = false,
    }) {
      final bool showArrow = showDivider && isHint;
      return Column(
        children: [
          if (showDivider && !isHint)
            Container(
              color: globals.dividerColor,
              height: scale,
            ),
          if (showDivider && !isHint)
            SizedBox(height: 15 * scale),
          Row(
            children: [
              TheText.normal(
                color: isHint ? globals.subtitleColor : globals.menuItemColor,
                fontSize: 15,
                // height: 1.6,
                text: text,
                textScaleFactor: scale,
              ),
              if (showArrow)
                Expanded(
                  child: Container(),
                ),
              if (showArrow) ImageWidget('up', 'grey'),
            ],
          ),
          // if (isLast) SizedBox(height: 28 * scale),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );
    }

    final List<DropdownMenuItem> menuItems = [hint, ...items]
        .asMap()
        .map(
          (int index, String item) => MapEntry(
            index,
            DropdownMenuItem(
              child: itemWidget(
                item,
                isHint: index < 1,
                isLast: index == items.length,
                showDivider: true,
              ),
              value: index - 1,
            ),
          ),
        )
        .values
        .toList();
    return DecorationWidget(
      child: Theme(
        child: DropdownButton<int>(
          hint: selectedService == null
              ? itemWidget(hint, isHint: true)
              : itemWidget(items[selectedService]),
          icon: ImageWidget('down', 'grey'),
          isExpanded: true,
          items: menuItems,
          onChanged: onChanged,
          underline: Container(),
        ),
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
        ),
      ),
      marginTop: 4,
      paddingLeft: 26,
      paddingRight: 19,
    );
  }
}
