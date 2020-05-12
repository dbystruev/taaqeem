//
//  lib/screens/main_screen.dart
//
//  Created by Denis Bystruev on 25/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/controllers/network_controller.dart';
import 'package:taaqeem/extensions/scroll_controller+extension.dart';
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
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
  final String message;

  MainScreen(ScreenData screenData, {this.message})
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
    checkForNewScreenData();
    final double scale = Scale.getScale(context);
    List<Widget> children = [
      HeaderImageWidget(
        'main',
        hasLogo: true,
        height: 205,
        padding: EdgeInsets.only(top: 60),
        scale: scale,
      ),
      InkWell(
        child: DiscountWidget(
          'Get 19% discount\non your first order',
        ),
        onTap: routeToOrder,
      ),
      TitleWidget(
        'Choose your area',
        scale: scale,
        subtitle: 'Find the best companies in the UAE to provide' +
            '\ngovt-approved sanitation and disinfection services',
        subtitleHeight: 1.57,
        subtitleSize: 14,
      ),
    ];
    for (int planIndex = 0; planIndex < plans.length; planIndex++) {
      children.add(
        PlanWidget(
          plans[planIndex],
          index: planIndex,
          isSelected: selectedPlan == planIndex,
          onExpansionChanged: (int index, bool expanded) {
            if (expanded && lastIndex != null && lastIndex != index)
              PlanWidget.keys[lastIndex].currentState.collapse();
            lastIndex =
                expanded ? index : (lastIndex == index ? null : lastIndex);
            Future.delayed(
              Duration(milliseconds: 300),
            ).then((_) {
              setState(
                () => selectedPlan = expanded ? planIndex : plans.length,
              );
              if (expanded)
                scrollController.scrollTo(
                  index,
                  context: context,
                  scale: scale,
                );
            });
          },
          onPressed: routeToOrder,
          scale: scale,
        ),
      );
    }
    children.add(
      SizedBox(height: 204 * scale),
    );
    return ScaffoldBarWidget(
      body: ListView(
        children: children,
        controller: scrollController,
        physics: BouncingScrollPhysics(),
      ),
      getScreenData: () {
        checkForNewScreenData();
        return ScreenData.over(screenData, selectedPlan: selectedPlan);
      },
      safeAreaTop: false,
    );
  }

  void checkForNewScreenData() {
    if (NetworkController.shared.hasSreenData) {
      screenData = NetworkController.shared.getScreenDataIfLoaded(screenData);
      NetworkController.shared.saveScreenDataToPrefs(screenData);
    }
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
      NetworkController.shared.saveScreenDataToPrefs(screenData);
    } else
      NetworkController.shared
          .getScreenDataFromPrefs()
          .then((ScreenData prefsScreenData) {
        screenData = ScreenData.merge(screenData, prefsScreenData);
      });
  }

  void routeToOrder([int index]) {
    checkForNewScreenData();
    pushRouteIfValid(
      context,
      builder: (context) => OrderScreen(
        ScreenData.over(screenData, selectedPlan: index ?? selectedPlan),
      ),
      replace:
          index != null || selectedPlan != null && selectedPlan < plans.length,
      routeIndex: OrderScreen.routeIndex,
    );
  }

  void sendOrderOrFeedbackAsNeeded(Duration duration) async {
    final DateTime now = DateTime.now();
    const Duration second = Duration(seconds: 1);
    if (lastCall != null && now.difference(lastCall) < second) return;
    lastCall = now;
    if (widget.message != null) showMessageInContext(context, widget.message);
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
      showMessageInContext(
        context,
        'Thanks for request.\nWe will help You immediately!',
      );
      screenData = ScreenData.clearOrder(screenData);
      NetworkController.shared.saveScreenDataToPrefs(screenData);
    }
    if (screenData.userFeedback.id != null) {
      showMessageInContext(
        context,
        'Thanks for feedback!\nWe will take it to an account',
      );
      screenData = ScreenData.clearFeedback(screenData);
      NetworkController.shared.saveScreenDataToPrefs(screenData);
    }
  }
}
