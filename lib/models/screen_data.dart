//
//  lib/models/screen_data.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

import 'package:taaqeem/models/order.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/models/server_data.dart';
import 'package:taaqeem/models/user.dart';
import 'package:taaqeem/models/user_feedback.dart';

class ScreenData {
  bool get isPlanSelected =>
      selectedPlan != null &&
      plans?.plans != null &&
      0 <= selectedPlan &&
      selectedPlan < plans.plans.length;
  final String lastError;
  final DateTime lastErrorTime;
  final Order order;
  final Plans plans;
  final int routeIndex;
  final int selectedPlan;
  final String url;
  final User user;
  final UserFeedback userFeedback;

  ScreenData({
    this.lastError,
    this.lastErrorTime,
    this.order,
    this.plans,
    this.routeIndex,
    this.selectedPlan,
    this.url,
    this.user,
    this.userFeedback,
  });

  factory ScreenData.clearErrorCodes(ScreenData screenData) => ScreenData(
        lastError: null,
        lastErrorTime: null,
        order: screenData.order,
        plans: screenData.plans,
        routeIndex: screenData.routeIndex,
        selectedPlan: screenData.selectedPlan,
        url: screenData.url,
        user: screenData.user,
        userFeedback: screenData.userFeedback,
      );

  factory ScreenData.clearFeedback(ScreenData screenData) => ScreenData(
        lastError: screenData.lastError,
        lastErrorTime: screenData.lastErrorTime,
        order: screenData.order,
        plans: screenData.plans,
        routeIndex: screenData.routeIndex,
        selectedPlan: screenData.selectedPlan,
        url: screenData.url,
        user: screenData.user,
        userFeedback: UserFeedback(null),
      );

  factory ScreenData.clearOrder(ScreenData screenData) => ScreenData(
        lastError: screenData.lastError,
        lastErrorTime: screenData.lastErrorTime,
        order: Order(),
        plans: screenData.plans,
        routeIndex: screenData.routeIndex,
        selectedPlan: screenData.selectedPlan,
        url: screenData.url,
        user: screenData.user,
        userFeedback: screenData.userFeedback,
      );

  factory ScreenData.fromServerData(
          ScreenData screenData, ServerData serverData) =>
      ScreenData.over(
        screenData,
        order: Order.merge(screenData.order, serverData.order),
        user: User.merge(screenData.user, serverData.user),
        userFeedback: UserFeedback.merge(
          screenData.userFeedback,
          serverData.userFeedback,
        ),
      );

  factory ScreenData.logout(ScreenData screenData) => ScreenData(
        lastError: screenData.lastError,
        lastErrorTime: screenData.lastErrorTime,
        order: screenData.order,
        plans: screenData.plans,
        routeIndex: screenData.routeIndex,
        selectedPlan: screenData.selectedPlan,
        url: screenData.url,
        user: User(),
        userFeedback: screenData.userFeedback,
      );

  factory ScreenData.over(
    ScreenData screenData, {
    String lastError,
    DateTime lastErrorTime,
    Order order,
    Plans plans,
    int routeIndex,
    int selectedPlan,
    String url,
    User user,
    UserFeedback userFeedback,
  }) =>
      ScreenData(
        lastError: lastError ?? screenData.lastError,
        lastErrorTime: lastErrorTime ?? screenData.lastErrorTime,
        order: Order.merge(screenData.order, order),
        plans: plans ?? screenData.plans,
        routeIndex: routeIndex ?? screenData.routeIndex,
        selectedPlan: selectedPlan ?? screenData.selectedPlan,
        url: url ?? screenData.url,
        user: User.merge(screenData.user, user),
        userFeedback: UserFeedback.merge(screenData.userFeedback, userFeedback),
      );

  @override
  String toString() {
    return '''ScreenData(
  lastError: '$lastError',
  lastErrorTime: '$lastErrorTime',
  order: '$order', // isPending: ${order.isPending}
  // plans: ${plans?.plans?.length},
  routeIndex: $routeIndex,
  selectedPlan: $selectedPlan,
  url: '$url',
  user: '$user',
  userFeedback: '$userFeedback', // isPending: ${userFeedback.isPending}
)''';
  }
}
