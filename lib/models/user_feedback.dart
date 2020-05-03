//
//  lib/models/user_feedback.dart
//
//  Created by Denis Bystruev on 3/05/2020.
//

import 'package:json_annotation/json_annotation.dart';
part 'user_feedback.g.dart';

@JsonSerializable()
class UserFeedback {
  final DateTime date;
  final int id;
  final String text;

  UserFeedback(this.text, {DateTime date, this.id})
      : this.date = date ?? DateTime.now();

  factory UserFeedback.over(UserFeedback feedback,
          {DateTime date, String text}) =>
      UserFeedback(
        text ?? feedback?.text,
        date: date ?? feedback?.date ?? DateTime.now(),
      );

  factory UserFeedback.fromJson(Map<String, dynamic> json) =>
      _$UserFeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$UserFeedbackToJson(this);
}
