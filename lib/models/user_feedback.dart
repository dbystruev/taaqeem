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
  bool get isPending => text != null && text.isNotEmpty;
  final String text;

  UserFeedback(this.text, {DateTime date, this.id})
      : this.date = date ?? DateTime.now();

  factory UserFeedback.merge(UserFeedback feedback, UserFeedback newData) =>
      UserFeedback(
        newData?.text ?? feedback?.text,
        date: feedback?.date ?? newData?.date,
        id: newData?.id ?? feedback?.id,
      );

  factory UserFeedback.over(
    UserFeedback feedback, {
    DateTime date,
    String text,
  }) =>
      UserFeedback.merge(
        feedback,
        UserFeedback(text, date: date),
      );

  factory UserFeedback.fromJson(Map<String, dynamic> json) =>
      _$UserFeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$UserFeedbackToJson(this);

  @override
  String toString() {
    return '''UserFeedback(
    '$text',
    date: '$date',
    id: $id
  )''';
  }
}
