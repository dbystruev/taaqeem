//
//  lib/models/user_feedback.dart
//
//  Created by Denis Bystruev on 3/05/2020.
//

import 'package:json_annotation/json_annotation.dart';
part 'user_feedback.g.dart';

@JsonSerializable()
class UserFeedback {
  DateTime date;
  int id;
  bool get isPending => text != null && text.isNotEmpty;
  String text;

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
      UserFeedback(text ?? feedback.text, date: date ?? feedback.date);

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

  assign(
    DateTime date,
    int id,
    String text,
  ) {
    this.date = date ?? this.date;
    this.id = id ?? this.id;
    this.text = text ?? this.text;
  }

  clear() {
    date = null;
    id = null;
    text = null;
  }

  copy(UserFeedback feedback) {
    date = feedback.date;
    id = feedback.id;
    text = feedback.text;
  }

  bool isSimilar(UserFeedback feedback) =>
      date == feedback.date && text == feedback.text;

  merge(UserFeedback feedback) {
    date = feedback.date ?? date;
    id = feedback.id ?? id;
    text = feedback.text ?? text;
  }
}
