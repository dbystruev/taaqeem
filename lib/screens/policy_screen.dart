//
//  lib/screens/policy_screen.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/policy.dart';
import 'package:taaqeem/models/policy+all.dart';
import 'package:taaqeem/models/policy_section.dart';
import 'package:taaqeem/widgets/back_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class PolicyScreen extends StatelessWidget {
  static const routeIndex = 9;
  static String get routeName => NavigatorWidget.routeName(routeIndex);

  final bool showToS;

  PolicyScreen({this.showToS = false});

  final List<Policy> policies = AllPolicies.local;

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getHorizontalScale(context);
    final Policy policy = showToS ? AllPolicies.local[1] : AllPolicies.local[0];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BackWidget(
              policy.title,
              marginBottom: 40,
              scale: scale,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, int index) {
                  final PolicySection section = policy.sections[index];
                  return Column(
                    children: [
                      TheText.w600(
                        color: globals.textColor,
                        fontSize: 18,
                        text: section.name,
                        textScaleFactor: scale,
                      ),
                      SizedBox(height: 20 * scale),
                      TheText.normal(
                        color: globals.subtitleColor,
                        fontSize: 14,
                        height: 1.57,
                        text: section.text,
                        textScaleFactor: scale,
                      ),
                      SizedBox(height: 40 * scale),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  );
                },
                itemCount: policy.sections.length,
                padding: EdgeInsets.symmetric(horizontal: 20 * scale),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
