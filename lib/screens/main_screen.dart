//
//  lib/screens/main_screen.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/extensions/scroll_controller+extension.dart';
import 'package:taaqeem/models/plan.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/screens/order_screen.dart';
import 'package:taaqeem/widgets/discount_widget.dart';
import 'package:taaqeem/widgets/header_image_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/plan_widget.dart';
import 'package:taaqeem/widgets/scaffold_bar_widget.dart';
import 'package:taaqeem/widgets/title_widget.dart';

class MainScreen extends StatefulWidget {
  static const routeIndex = 0;
  static String get routeName => NavigatorWidget.routeName(routeIndex);

  final ScreenData screenData;

  MainScreen(ScreenData screenData)
      : this.screenData = ScreenData.over(screenData, routeIndex: routeIndex);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with RouteValidator, Scale {
  int lastIndex;
  List<Plan> plans;
  ScrollController scrollController;
  int selectedPlan;

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getScale(context);
    return ScaffoldBarWidget(
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
                plans[planIndex],
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
                        selectedPlan = expanded ? planIndex : plans.length;
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
                      builder: (context) => OrderScreen(
                        ScreenData.over(widget.screenData, selectedPlan: index),
                      ),
                    ),
                  );
                },
                scale: scale,
              );
          }
        },
        itemCount: plans.length + 3,
        padding: EdgeInsets.all(
          Scale.getSafeMargin(context),
        ),
      ),
      screenData: widget.screenData,
    );
  }

  @override
  void initState() {
    super.initState();
    plans = widget.screenData.plans.plans;
    scrollController = ScrollController();
    selectedPlan = widget.screenData.selectedPlan ?? plans.length;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
