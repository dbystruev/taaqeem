//
//  lib/models/server_data.dart
//
//  Created by Denis Bystruev on 3/05/2020.
//
//  https://flutter.dev/docs/development/data-and-backend/json

import 'package:json_annotation/json_annotation.dart';
import 'package:taaqeem/models/order.dart';
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/models/user.dart';
import 'package:taaqeem/models/user_feedback.dart';

part 'server_data.g.dart';

@JsonSerializable(explicitToJson: true)
class ServerData {
  final Order order;
  final User user;
  final UserFeedback userFeedback;

  ServerData({this.order, this.user, this.userFeedback});

  ServerData.fromScreenData(ScreenData screenData)
      : order = screenData.order,
        user = screenData.user,
        userFeedback = screenData.userFeedback;

  factory ServerData.fromJson(Map<String, dynamic> json) =>
      _$ServerDataFromJson(json);

  Map<String, dynamic> toJson() => _$ServerDataToJson(this);
}
