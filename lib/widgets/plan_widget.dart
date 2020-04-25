//
//  lib/widgets/plan_widget.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/plan.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class PlanWidget extends StatefulWidget {
  final Plan plan;

  PlanWidget(
    this.plan, {
    Key key,
  }) : super(key: key);

  @override
  _PlanWidgetState createState() => _PlanWidgetState(
        description: plan.description,
        leadingIcon: plan.icon,
        subtitle: plan.subtitle,
        title: plan.type,
      );
}

class _PlanWidgetState extends State<PlanWidget> with Scale {
  final String description;
  final String leadingIcon;
  bool open = false;
  final String subtitle;
  final String title;

  _PlanWidgetState({
    this.description,
    this.leadingIcon,
    this.subtitle,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context);
    return Card(
      child: ListTileTheme(
        contentPadding:
            EdgeInsets.fromLTRB(13 * scale, 0, 24 * scale, open ? 0 : 12 * scale,
                ),
        child: ExpansionTile(
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
                text: description,
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
                onPressed: () {
                  debugPrint(
                      'lib/widgets/plan_widget.dart:67 Book Service Pressed');
                },
                scale: scale,
              ),
            ),
          ],
          initiallyExpanded: open,
          leading: leadingIcon.startsWith('http')
              ? NetworkImage(leadingIcon)
              : Image.asset(
                  'assets/images/$leadingIcon.png',
                  height: 34 * scale,
                  width: 34 * scale,
                ),
          onExpansionChanged: (bool expanded) {
            setState(() {
              open = expanded;
            });
          },
          subtitle: TheText.w700(
            color: Theme.of(context).accentColor,
            fontSize: 16,
            height: 1.37,
            text: subtitle,
            textScaleFactor: scale,
          ),
          title: TheText.w700(
            fontSize: 16,
            height: 1.37,
            text: title,
            textScaleFactor: scale,
          ),
          trailing: Image.asset(
            'assets/images/${open ? 'up' : 'down'}.png',
            height: 9 * scale,
            width: 15 * scale,
          ),
        ),
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
