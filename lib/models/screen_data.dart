//
//  lib/models/screen_data.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'package:taaqeem/models/order.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/models/user.dart';

class ScreenData {
  bool get isPlanSelected =>
      selectedPlan != null &&
      plans?.plans != null &&
      selectedPlan < plans.plans.length;
  final Order order;
  final Plans plans;
  final int routeIndex;
  final int selectedPlan;
  final User user;

  ScreenData({
    this.order,
    this.plans,
    this.routeIndex,
    this.selectedPlan,
    this.user,
  });

  factory ScreenData.over(
    ScreenData screenData, {
    Order order,
    Plans plans,
    int routeIndex,
    int selectedPlan,
    User user,
  }) =>
      ScreenData(
        order: order ?? screenData.order,
        plans: plans ?? screenData.plans,
        routeIndex: routeIndex ?? screenData.routeIndex,
        selectedPlan: selectedPlan ?? screenData.selectedPlan,
        user: user ?? screenData.user,
      );
}
