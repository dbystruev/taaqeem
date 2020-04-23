// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) {
  return Plan(
    json['title'] as String,
    description: json['description'] as String,
    icon: json['icon'] as String,
    id: json['id'] as int,
    image: json['image'] as String,
    type: json['type'] as String,
    subtitle: json['subtitle'] as String,
  );
}

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'description': instance.description,
      'icon': instance.icon,
      'id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'type': instance.type,
      'subtitle': instance.subtitle,
    };
