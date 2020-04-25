//
//  lib/screens/main_screen.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/widgets/discount_widget.dart';
import 'package:taaqeem/widgets/header_image_widget.dart';
import 'package:taaqeem/widgets/title_widget.dart';

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
    final double scale = getScale(context);
    return Container(
      child: Scaffold(
        body: Padding(
          child: ListView(
            children: [
              HeaderImageWidget(
                'assets/images/main.png',
                hasLogo: true,
                height: 205,
                padding: EdgeInsets.only(top: 60),
                scale: scale,
                width: 286,
              ),
              DiscountWidget('Get 19% discount\non your first order'),
              TitleWidget(
                'Choose your area',
                scale: scale,
                subtitle:
                    'Find the best companies in the UAE to provide govt-approved sanitation and disinfection services',
                titleSize: 22,
                subtitleSize: 14,
              ),
            ],
            padding: const EdgeInsets.only(),
          ),
          padding: EdgeInsets.all(
            getSafeMargin(context),
          ),
        ),
      ),
    );
  }
}
