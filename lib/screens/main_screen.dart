//
//  lib/screens/main_screen.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class MainScreen extends StatefulWidget {
  final Plans plans;

  MainScreen(this.plans);

  @override
  _MainScreenState createState() => _MainScreenState(plans);
}

class _MainScreenState extends State<MainScreen> with Scale {
  final Plans plans;
  int selectedPlan;

  _MainScreenState(this.plans);

  @override
  Widget build(BuildContext context) {
    final double safeMargin = isHorizontal(context) ? 44 : 0;
    final double scale = getScale(context);
    return Container(
      child: Scaffold(
        body: Padding(
          child: ListView(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Image(
                      height: 65 * scale,
                      image: AssetImage('assets/images/logo_q.png'),
                      width: 46 * scale,
                    ),
                    right: 20 * scale,
                    top: 24 * scale,
                  ),
                  Padding(
                    child: Image(
                      height: 205 * scale,
                      image: AssetImage('assets/images/main.png'),
                      width: 286 * scale,
                    ),
                    padding: EdgeInsets.only(top: 60 * scale),
                  ),
                ],
              ),
              Padding(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      child: Container(
                        child: TheText.w600(
                          color: globals.discountTextColor,
                          fontSize: 18,
                          text: 'Get 19% discount\non your first order',
                          textScaleFactor: scale,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6 * scale),
                          color: globals.discountBackgroundColor,
                        ),
                        height: 65 * scale,
                        padding:
                            EdgeInsets.only(left: 20 * scale, top: 10 * scale),
                        width: 335 * scale,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15 * scale,
                            color: globals.shadowColor,
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(top: 10 * scale),
                    ),
                    Positioned(
                        bottom: 14 * scale,
                        child: Container(
                          child: Image(
                            height: 40 * scale,
                            image: AssetImage('assets/images/wow.png'),
                            width: 10 * scale,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6 * scale),
                            color: globals.primaryColor,
                          ),
                          height: 60 * scale,
                          padding: EdgeInsets.symmetric(vertical: 10 * scale),
                          width: 60 * scale,
                        ),
                        left: getMidX(context) + 77.5 * scale - safeMargin),
                  ],
                ),
                padding: EdgeInsets.only(
                  bottom: 15 * scale,
                  left: 20 * scale,
                  right: 20 * scale,
                  top: 16 * scale,
                ),
              ),
            ],
            padding: const EdgeInsets.only(),
          ),
          padding: EdgeInsets.all(safeMargin),
        ),
      ),
    );
  }
}
