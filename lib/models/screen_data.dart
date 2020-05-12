//
//  lib/models/screen_data.dart
//
//  Created by Denis Bystruev on 2/05/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'package:json_annotation/json_annotation.dart';
import 'package:taaqeem/models/order.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/models/server_data.dart';
import 'package:taaqeem/models/user.dart';
import 'package:taaqeem/models/user_feedback.dart';
part 'screen_data.g.dart';

@JsonSerializable(explicitToJson: true)
class ScreenData {
  bool get isPlanSelected =>
      selectedPlan != null &&
      plans?.plans != null &&
      0 <= selectedPlan &&
      selectedPlan < plans.plans.length;
  String lastError;
  DateTime lastErrorTime;
  Order order;
  Plans plans;
  int routeIndex;
  int selectedPlan;
  String url;
  User user;
  UserFeedback userFeedback;

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
        order: screenData?.order,
        plans: screenData?.plans,
        routeIndex: screenData?.routeIndex,
        selectedPlan: screenData?.selectedPlan,
        url: screenData?.url,
        user: screenData?.user,
        userFeedback: screenData?.userFeedback,
      );

  factory ScreenData.clearFeedback(ScreenData screenData) => ScreenData(
        lastError: screenData?.lastError,
        lastErrorTime: screenData?.lastErrorTime,
        order: screenData?.order,
        plans: screenData?.plans,
        routeIndex: screenData?.routeIndex,
        selectedPlan: screenData?.selectedPlan,
        url: screenData?.url,
        user: screenData?.user,
        userFeedback: UserFeedback(null),
      );

  factory ScreenData.clearOrder(ScreenData screenData) => ScreenData(
        lastError: screenData?.lastError,
        lastErrorTime: screenData?.lastErrorTime,
        order: Order(),
        plans: screenData?.plans,
        routeIndex: screenData?.routeIndex,
        selectedPlan: screenData?.selectedPlan,
        url: screenData?.url,
        user: screenData?.user,
        userFeedback: screenData?.userFeedback,
      );

  factory ScreenData.fromJson(Map<String, dynamic> json) => _$ScreenDataFromJson(json);

  factory ScreenData.fromServerData(
          ScreenData screenData, ServerData serverData) =>
      ScreenData.over(
        screenData,
        order: Order.merge(screenData?.order, serverData?.order),
        user: User.merge(screenData?.user, serverData?.user),
        userFeedback: UserFeedback.merge(
          screenData?.userFeedback,
          serverData?.userFeedback,
        ),
      );

  factory ScreenData.logout(ScreenData screenData) => ScreenData(
        lastError: screenData?.lastError,
        lastErrorTime: screenData?.lastErrorTime,
        order: screenData?.order,
        plans: screenData?.plans,
        routeIndex: screenData?.routeIndex,
        selectedPlan: screenData?.selectedPlan,
        url: screenData?.url,
        user: User(),
        userFeedback: screenData?.userFeedback,
      );

  factory ScreenData.merge(ScreenData screenData, ScreenData newScreenData) =>
      ScreenData(
        lastError: newScreenData?.lastError ?? screenData?.lastError,
        lastErrorTime:
            newScreenData?.lastErrorTime ?? screenData?.lastErrorTime,
        order: newScreenData?.order ?? screenData?.order,
        plans: newScreenData?.plans ?? screenData?.plans,
        routeIndex: newScreenData?.routeIndex ?? screenData?.routeIndex,
        selectedPlan: newScreenData?.selectedPlan ?? screenData?.selectedPlan,
        url: newScreenData?.url ?? screenData?.url,
        user: newScreenData?.user ?? screenData?.user,
        userFeedback: newScreenData?.userFeedback ?? screenData?.userFeedback,
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
        lastError: lastError ?? screenData?.lastError,
        lastErrorTime: lastErrorTime ?? screenData?.lastErrorTime,
        order: Order.merge(screenData?.order, order),
        plans: plans ?? screenData?.plans,
        routeIndex: routeIndex ?? screenData?.routeIndex,
        selectedPlan: selectedPlan ?? screenData?.selectedPlan,
        url: url ?? screenData?.url,
        user: User.merge(screenData?.user, user),
        userFeedback:
            UserFeedback.merge(screenData?.userFeedback, userFeedback),
      );

  @override
  String toString() {
    return '''ScreenData(
  lastError: '$lastError',
  lastErrorTime: '$lastErrorTime',
  order: '$order', // isPending: ${order?.isPending}
  // plans: ${plans?.plans?.length} ${plans?.plans?.map((plan) => plan.type)},
  routeIndex: $routeIndex,
  selectedPlan: $selectedPlan,
  url: '$url',
  user: '$user',
  userFeedback: '$userFeedback', // isPending: ${userFeedback?.isPending}
)''';
  }

  assign(
    String lastError,
    DateTime lastErrorTime,
    Order order,
    Plans plans,
    int routeIndex,
    int selectedPlan,
    String url,
    User user,
    UserFeedback userFeedback,
  ) {
    this.lastError = lastError ?? this.lastError;
    this.lastErrorTime = lastErrorTime ?? this.lastErrorTime;
    this.order = order ?? this.order;
    this.plans = plans ?? this.plans;
    this.routeIndex = routeIndex ?? this.routeIndex;
    this.selectedPlan = selectedPlan ?? this.selectedPlan;
    this.url = url ?? this.url;
    this.user = user ?? this.user;
    this.userFeedback = userFeedback ?? this.userFeedback;
  }

  clear() {
    lastError = null;
    lastErrorTime = null;
    order = null;
    plans = null;
    routeIndex = null;
    selectedPlan = null;
    url = null;
    user = null;
    userFeedback = null;
  }

  merge(ScreenData screenData) {
    lastError = screenData?.lastError ?? lastError;
    lastErrorTime = screenData?.lastErrorTime ?? lastErrorTime;
    order = screenData?.order ?? order;
    plans = screenData?.plans ?? plans;
    routeIndex = screenData?.routeIndex ?? routeIndex;
    selectedPlan = screenData?.selectedPlan ?? selectedPlan;
    url = screenData?.url ?? url;
    user = screenData?.user ?? user;
    userFeedback = screenData?.userFeedback ?? userFeedback;
  }

  Map<String, dynamic> toJson() => _$ScreenDataToJson(this);
}
