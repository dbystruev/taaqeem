// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    cleaningDate: json['cleaningDate'] == null
        ? null
        : DateTime.parse(json['cleaningDate'] as String),
    creationDate: json['creationDate'] == null
        ? null
        : DateTime.parse(json['creationDate'] as String),
    id: json['id'] as int,
    meters: (json['meters'] as num)?.toDouble(),
    planId: json['planId'] as int,
    service: json['service'] as String,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'cleaningDate': instance.cleaningDate?.toIso8601String(),
      'creationDate': instance.creationDate?.toIso8601String(),
      'id': instance.id,
      'meters': instance.meters,
      'planId': instance.planId,
      'service': instance.service,
    };
