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
  String get feedbackUrl => Data.fromJson(_decodedData).feedbackUrl;
  final String message;
  String get plansUrl => Data.fromJson(_decodedData).plansUrl;
  final String status;
  final int time;
  final String token;
  String get version => versionDynamic.toString();

  @JsonKey(name: 'version')
  final dynamic versionDynamic;

  AppData(
    this.status, {
    this.data,
    this.message,
    this.time,
    this.token,
    this.versionDynamic,
  });

  factory AppData.fromJson(Map<String, dynamic> json) =>
      _$AppDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppDataToJson(this);
}
