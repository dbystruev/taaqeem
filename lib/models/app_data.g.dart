// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppData _$AppDataFromJson(Map<String, dynamic> json) {
  return AppData(
    json['status'] as String,
    data: json['data'] as String,
    feedbackId: json['feedbackId'] as int,
    message: json['message'] as String,
    orderId: json['orderId'] as int,
    time: json['time'] as int,
    token: json['token'] as String,
    userId: json['userId'] as int,
    versionDynamic: json['version'],
  );
}

Map<String, dynamic> _$AppDataToJson(AppData instance) => <String, dynamic>{
      'data': instance.data,
      'feedbackId': instance.feedbackId,
      'message': instance.message,
      'orderId': instance.orderId,
      'status': instance.status,
      'time': instance.time,
      'token': instance.token,
      'userId': instance.userId,
      'version': instance.versionDynamic,
    };
