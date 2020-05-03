//
//  lib/models/app_data.dart
//
//  Created by Denis Bystruev on 23/04/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'dart:convert' as convert;
import 'package:json_annotation/json_annotation.dart';
import 'package:taaqeem/models/data.dart';
part 'app_data.g.dart';

@JsonSerializable()
class AppData {
  final String data;
  Map<String, dynamic> get _decodedData => convert.jsonDecode(data);
  final int feedbackId;
  String get feedbackUrl => Data.fromJson(_decodedData).feedbackUrl;
  final String message;
  final int orderId;
  String get plansUrl => Data.fromJson(_decodedData).plansUrl;
  final String status;
  final int time;
  final String token;
  final int userId;
  String get version => versionDynamic.toString();

  @JsonKey(name: 'version')
  final dynamic versionDynamic;

  AppData(
    this.status, {
    this.data,
    this.feedbackId,
    this.message,
    this.orderId,
    this.time,
    this.token,
    this.userId,
    this.versionDynamic,
  });

  factory AppData.fromJson(Map<String, dynamic> json) =>
      _$AppDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppDataToJson(this);
}
