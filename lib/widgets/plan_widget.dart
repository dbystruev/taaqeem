//
//  lib/widgets/plan_widget.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/plan.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/expansion_tile_widget.dart';
import 'package:taaqeem/widgets/image_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class PlanWidget extends StatelessWidget {
  final ExpansionTileWidget expansionTile;
  final int index;
  static Map<int, GlobalKey<ExpansionTileWidgetState>> keys = {};
  final bool isSelected;
  final void Function(
    int index,
    bool expanded,
  ) onExpansionChanged;
  final ValueChanged<int> onPressed;
  final Plan plan;
  final double scale;

  PlanWidget(
    this.plan, {
    this.index,
    this.isSelected = false,
    this.onExpansionChanged,
    this.onPressed,
    @required this.scale,
  }) : expansionTile = ExpansionTileWidget(
          children: [
            Divider(
              endIndent: 24 * scale,
              indent: 13 * scale,
              thickness: scale,
            ),
            Padding(
              child: TheText.normal(
                color: globals.subtitleColor,
                fontSize: 14,
                height: 1.57,
                text: plan.description,
                textScaleFactor: scale,
              ),
              padding: EdgeInsets.fromLTRB(
                15 * scale,
                8 * scale,
                24 * scale,
                12 * scale,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                16 * scale,
                0,
                19 * scale,
                27 * scale,
              ),
              child: ButtonWidget(
                'Book Service',
                onPressed: () => onPressed(index),
              ),
            ),
          ],
          initiallyExpanded: isSelected,
          key: GlobalKey<ExpansionTileWidgetState>(),
          leading: ImageWidget(plan.icon, height: 34, width: 34),
          onExpansionChanged: (bool expanded) =>
              onExpansionChanged(index, expanded),
          subtitle: TheText.w700(
            color: globals.accentColor,
            fontSize: 16,
            height: 1.37,
            text: plan.subtitle,
            textScaleFactor: scale,
          ),
          title: TheText.w700(
            fontSize: 16,
            height: 1.37,
            text: plan.type,
            textScaleFactor: scale,
          ),
          trailing: ImageWidget(isSelected ? 'up' : 'down', suffix: 'green'),
        ) {
    keys[index] = expansionTile.key;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTileTheme(
        contentPadding: EdgeInsets.fromLTRB(
          13 * scale,
          0,
          24 * scale,
          isSelected ? 0 : 12 * scale,
        ),
        child: expansionTile,
        dense: true,
      ),
      elevation: 6,
      margin: EdgeInsets.fromLTRB(20 * scale, 10 * scale, 20 * scale, 0),
      shadowColor: globals.shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7 * scale),
      ),
    );
  }
}
