//
//  lib/screens/main_screen.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/widgets/discount_widget.dart';
import 'package:taaqeem/widgets/header_image_widget.dart';
import 'package:taaqeem/widgets/plan_widget.dart';
import 'package:taaqeem/widgets/title_widget.dart';

class MainScreen extends StatefulWidget {
  final Plans plans;

  MainScreen(this.plans);

  @override
  _MainScreenState createState() => _MainScreenState(plans);
}

class _MainScreenState extends State<MainScreen> with Scale {
  int lastIndex;
  // final List<Key> planKeys;
  final ItemScrollController scrollController = ItemScrollController();
  final Plans plans;
  // final List<ItemScrollController> scrollControllers;
  bool scrollToSelected = false;
  int selectedIndex;

  _MainScreenState(this.plans)
      :
        // planKeys = List<Key>.generate(
        //     plans.plans.length + 1,
        //     (_) => UniqueKey(),
        //     growable: false,
        //   ),
        //   scrollControllers = List<ItemScrollController>.generate(
        //     plans.plans.length + 1,
        //     (_) => ItemScrollController(),
        //     growable: false,
        //   ),
        selectedIndex = plans.plans.length;

  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context);
    return Container(
      child: Scaffold(
        body: ScrollablePositionedList.builder(
          // key: planKeys[selectedIndex],
          itemBuilder: (BuildContext context, int index) {
            if (scrollToSelected && selectedIndex < plans.plans.length) {
              scrollToSelected = false;
              Future.delayed(Duration(milliseconds: 40)).then(
                (_) => scrollController.scrollTo(
                  // scrollControllers[selectedIndex].scrollTo(
                  duration: Duration(milliseconds: 500),
                  index: selectedIndex,
                ),
              );
            }
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
                  isSelected: selectedIndex == planIndex,
                  onExpansionChanged: (int index, bool expanded) {
                    debugPrint(
                      '\nlib/screens/main_screen.dart:99 index = $index, expanded = $expanded, lastIndex = $lastIndex',
                    );
                    if (expanded && lastIndex != null && lastIndex != index) {
                      debugPrint(
                        'lib/screens/main_screen.dart:103 PlanWidget.keys[$lastIndex].currentState.collapse()',
                      );
                      PlanWidget.keys[lastIndex].currentState.collapse();
                    }
                    Future.delayed(
                      Duration(milliseconds: 300),
                    ).then(
                      (_) {
                        if (expanded && lastIndex == null) {
                          debugPrint(
                            'lib/screens/main_screen.dart:114 lastIndex = $lastIndex, scrollTo(index: $index)',
                          );
                          scrollController.scrollTo(
                              duration: Duration(milliseconds: 500),
                              index: index);
                        }
                        lastIndex = expanded ? index : null;
                        debugPrint(
                          '/lib/screens/main_screen.dart:113 lastIndex = $lastIndex',
                        );
                        setState(() {
                          selectedIndex =
                              expanded ? planIndex : plans.plans.length;
                        });
                      },
                    );
                  },
                  onPressed: (int index) {
                    debugPrint(
                      'lib/screens/main_screen.dart:121 index = $index, planIndex = $planIndex',
                    );
                  },
                  scale: scale,
                );
            }
          },
          itemCount: plans.plans.length + 3,
          itemScrollController: scrollController,
          // itemScrollController: scrollControllers[selectedIndex],
          padding: EdgeInsets.all(
            getSafeMargin(context),
          ),
        ),
      ),
    );
  }
}
