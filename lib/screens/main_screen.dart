//
//  lib/screens/main_screen.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/widgets/bottom_navigation_widget.dart';
import 'package:taaqeem/widgets/discount_widget.dart';
import 'package:taaqeem/widgets/header_image_widget.dart';
import 'package:taaqeem/widgets/plan_widget.dart';
import 'package:taaqeem/widgets/plus_button_widget.dart';
import 'package:taaqeem/widgets/title_widget.dart';

class MainScreen extends StatefulWidget {
  final Plans plans;

  MainScreen(this.plans);

  @override
  _MainScreenState createState() => _MainScreenState(plans);
}

class _MainScreenState extends State<MainScreen> with Scale {
  int lastIndex;
  final ScrollController scrollController = ScrollController();
  final Plans plans;
  int selectedBottomBarItem = 0;
  int selectedPlan;

  _MainScreenState(this.plans) : selectedPlan = plans.plans.length;

  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context);
    return Container(
      child: Scaffold(
        body: ListView.builder(
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return HeaderImageWidget(
                  'assets/images/main.png',
                  hasLogo: true,
                  height: 205,
                  padding: EdgeInsets.only(top: 60),
                  scale: scale,
                  width: 286,
                );
              case 1:
                return DiscountWidget(
                  'Get 19% discount\non your first order',
                );
              case 2:
                return TitleWidget(
                  'Choose your area',
                  scale: scale,
                  subtitle: 'Find the best companies in the UAE to provide' +
                      '\ngovt-approved sanitation and disinfection services',
                  subtitleHeight: 1.57,
                  titleSize: 22,
                  subtitleSize: 14,
                );
              default:
                final int planIndex = index - 3;
                return PlanWidget(
                  plans.plans[planIndex],
                  index: planIndex,
                  isSelected: selectedPlan == planIndex,
                  onExpansionChanged: (int index, bool expanded) {
                    if (expanded && lastIndex != null && lastIndex != index) {
                      PlanWidget.keys[lastIndex].currentState.collapse();
                    }
                    Future.delayed(
                      Duration(milliseconds: 250),
                    ).then(
                      (_) {
                        setState(() {
                          selectedPlan =
                              expanded ? planIndex : plans.plans.length;
                          if (expanded && lastIndex == null) scrollTo(index);
                          lastIndex = expanded ? index : null;
                        });
                      },
                    );
                  },
                  onPressed: (int index) {
                    debugPrint(
                      'lib/screens/main_screen.dart:94 order index = $index, planIndex = $planIndex',
                    );
                  },
                  scale: scale,
                );
            }
          },
          itemCount: plans.plans.length + 3,
          padding: EdgeInsets.all(
            getSafeMargin(context),
          ),
        ),
        bottomNavigationBar: BottomNavigationWidget(
          onTap: (int index) {
            setState(() => selectedBottomBarItem = index);
            debugPrint(
              'lib/screens/main_screen.dart:110 bottom index = $index',
            );
          },
          selectedIndex: selectedBottomBarItem,
        ),
        floatingActionButton: PlusButtonWidget(
          onTap: () {
            debugPrint(
              'lib/screens/main_screen.dart:118 plus button',
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  void scrollTo(int index) {
    final double scale = getScale(context);
    final double collapsedHeight = 87 * scale;
    final double expandedHeight = 257 * scale;
    final double headerHeight = 464 * scale;
    final double footerHeight = 97 * scale;
    final double height = index < selectedPlan
        ? (index + 1) * collapsedHeight
        : index * collapsedHeight + expandedHeight;
    final double scrollHeight = max(
      headerHeight +
          height +
          footerHeight +
          getSafeMargin(context) -
          getScreenHeight(context),
      0,
    );
    scrollController.animateTo(
      scrollHeight,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
