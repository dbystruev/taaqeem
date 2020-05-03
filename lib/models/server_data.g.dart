// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerData _$ServerDataFromJson(Map<String, dynamic> json) {
  return ServerData(
    order: json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    userFeedback: json['userFeedback'] == null
        ? null
        : UserFeedback.fromJson(json['userFeedback'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ServerDataToJson(ServerData instance) =>
    <String, dynamic>{
      'order': instance.order?.toJson(),
      'user': instance.user?.toJson(),
      'userFeedback': instance.userFeedback?.toJson(),
    };
