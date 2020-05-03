//
//  lib/models/screen_data.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'package:taaqeem/models/order.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/models/user.dart';
import 'package:taaqeem/models/user_feedback.dart';

class ScreenData {
  bool get isPlanSelected =>
      selectedPlan != null &&
      plans?.plans != null &&
      0 <= selectedPlan &&
      selectedPlan < plans.plans.length;
  final Order order;
  final Plans plans;
  final int routeIndex;
  final int selectedPlan;
  final String url;
  final User user;
  final UserFeedback userFeedback;

  ScreenData({
    this.order,
    this.plans,
    this.routeIndex,
    this.selectedPlan,
    this.url,
    this.user,
    this.userFeedback,
  });

  factory ScreenData.over(
    ScreenData screenData, {
    Order order,
    Plans plans,
    int routeIndex,
    int selectedPlan,
    String url,
    User user,
    UserFeedback userFeedback,
  }) =>
      ScreenData(
        order: order ?? screenData.order,
        plans: plans ?? screenData.plans,
        routeIndex: routeIndex ?? screenData.routeIndex,
        selectedPlan: selectedPlan ?? screenData.selectedPlan,
        url: url ?? screenData.url,
        user: user ?? screenData.user,
        userFeedback: userFeedback ?? screenData.userFeedback,
      );
}
