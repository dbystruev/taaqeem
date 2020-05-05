//
//  lib/screens/main_screen.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/controllers/network_controller.dart';
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

class _MainScreenState extends State<MainScreen> with RouteValidator {
  DateTime lastCall;
  int lastIndex;
  List<Plan> plans;
  ScreenData screenData;
  ScrollController scrollController;
  int selectedPlan;
  bool sendingOrderOrFeedbackInProcess;

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
                  pushRouteIfValid(
                    context,
                    builder: (context) => OrderScreen(
                      ScreenData.over(screenData, selectedPlan: index),
                    ),
                    name: OrderScreen.routeName,
                    replace: true,
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
      getScreenData: () => ScreenData.over(screenData, selectedPlan: selectedPlan),
    );
  }

  void delay([double seconds = 0.25]) async {
    final int ms = (seconds / 1000).round();
    final Duration duration = Duration(milliseconds: ms);
    await Future.delayed(duration);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    screenData = widget.screenData;
    plans = screenData.plans.plans;
    scrollController = ScrollController();
    selectedPlan = screenData.selectedPlan ?? plans.length;
    sendingOrderOrFeedbackInProcess = false;
    WidgetsBinding.instance.addPostFrameCallback(sendOrderOrFeedbackAsNeeded);
    if (screenData.user.isLoggedIn) {
      NetworkController.shared.savePrefs(screenData);
    } else
      NetworkController.shared.loadPrefs().then((ScreenData prefsScreenData) {
        screenData = ScreenData.merge(screenData, prefsScreenData);
        debugPrint(
          'lib/screens/main_screen.dart:152 screenData.user = ${screenData.user}',
        );
      });
    debugPrint(
      'lib/screens/main_screen.dart:156 screenData = $screenData',
    );
  }

  void sendOrderOrFeedbackAsNeeded(Duration duration) async {
    final DateTime now = DateTime.now();
    const Duration second = Duration(seconds: 1);
    if (lastCall != null && now.difference(lastCall) < second) return;
    lastCall = now;
    if (!screenData.user.isLoggedIn) return;
    if (!screenData.order.isPending && !screenData.userFeedback.isPending)
      return;
    if (screenData.order.id != null || screenData.userFeedback.id != null) {
      showAndClearPendingTasks();
      return;
    }
    if (sendingOrderOrFeedbackInProcess) return;
    sendingOrderOrFeedbackInProcess = true;
    screenData = await NetworkController.shared.postRequest(screenData);
    showAndClearPendingTasks();
    sendingOrderOrFeedbackInProcess = false;
  }

  void showAndClearPendingTasks() {
    if (screenData.order.id != null) {
      print('BEFORE: screenData.order.id = ${screenData.order.id}' +
          ', screenData.order.meters = ${screenData.order.meters}');
      screenData = ScreenData.clearOrder(screenData);
      showMessageInContext(
        context,
        'Thanks for request.\nWe will help You immediately!',
      );
      print('screenData.order.id AFTER = ${screenData.order.id}' +
          ', screenData.order.meters = ${screenData.order.meters}');
    }
    if (screenData.userFeedback.id != null) {
      print(
        'screenData.userFeedback.id BEFORE = ${screenData.userFeedback.id}' +
            ', screenData.userFeedback.text = ${screenData.userFeedback.text}',
      );
      screenData = ScreenData.clearFeedback(screenData);
      showMessageInContext(
        context,
        'Thanks for feedback!\nWe will take it to an account',
      );
      print(
        'screenData.userFeedback.id AFTER = ${screenData.userFeedback.id}' +
            ', screenData.userFeedback.text = ${screenData.userFeedback.text}',
      );
    }
  }
}
