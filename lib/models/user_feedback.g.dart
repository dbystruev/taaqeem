// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFeedback _$UserFeedbackFromJson(Map<String, dynamic> json) {
  return UserFeedback(
    json['text'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$UserFeedbackToJson(UserFeedback instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'id': instance.id,
      'text': instance.text,
    };
