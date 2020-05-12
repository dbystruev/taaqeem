// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreenData _$ScreenDataFromJson(Map<String, dynamic> json) {
  return ScreenData(
    lastError: json['lastError'] as String,
    lastErrorTime: json['lastErrorTime'] == null
        ? null
        : DateTime.parse(json['lastErrorTime'] as String),
    order: json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    plans: json['plans'] == null
        ? null
        : Plans.fromJson(json['plans'] as Map<String, dynamic>),
    routeIndex: json['routeIndex'] as int,
    selectedPlan: json['selectedPlan'] as int,
    url: json['url'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    userFeedback: json['userFeedback'] == null
        ? null
        : UserFeedback.fromJson(json['userFeedback'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ScreenDataToJson(ScreenData instance) =>
    <String, dynamic>{
      'lastError': instance.lastError,
      'lastErrorTime': instance.lastErrorTime?.toIso8601String(),
      'order': instance.order?.toJson(),
      'plans': instance.plans?.toJson(),
      'routeIndex': instance.routeIndex,
      'selectedPlan': instance.selectedPlan,
      'url': instance.url,
      'user': instance.user?.toJson(),
      'userFeedback': instance.userFeedback?.toJson(),
    };
