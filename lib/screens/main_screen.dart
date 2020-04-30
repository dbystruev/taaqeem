//
//  lib/screens/main_screen.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/extensions/scroll_controller+extension.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/screens/order_screen.dart';
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
  int selectedPlan;

  _MainScreenState(this.plans) : selectedPlan = plans.plans.length;

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getScale(context);
    return Scaffold(
      body: ListView.builder(
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return HeaderImageWidget(
                'main',
                hasLogo: true,
                height: 205,
                padding: EdgeInsets.only(top: 60),
                scale: scale,
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
                        if (expanded && lastIndex == null)
                          scrollController.scrollTo(
                            index,
                            context: context,
                            expandedIndex: selectedPlan,
                          );
                        lastIndex = expanded ? index : null;
                      });
                    },
                  );
                },
                onPressed: (int index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrderScreen(plan: plans.plans[index]),
                    ),
                  );
                },
                scale: scale,
              );
          }
        },
        itemCount: plans.plans.length + 3,
        padding: EdgeInsets.all(
          Scale.getSafeMargin(context),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        onTap: (int index) {
          setState(() => BottomNavigationWidget.selectedBottomBarItem = index);
        },
        selectedIndex: BottomNavigationWidget.selectedBottomBarItem,
      ),
      floatingActionButton: PlusButtonWidget(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderScreen(plans: plans),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
