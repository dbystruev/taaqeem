//
//  lib/models/user.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//
//  https://flutter.dev/docs/development/data-and-backend/json

import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String avatar;
  final String email;
  final int id;
  final String name;
  final String phone;
  final DateTime registrationDate;
  final String token;

  User({
    this.avatar,
    this.email,
    this.id,
    this.name,
    this.phone,
    DateTime registrationDate,
    this.token,
  }) : this.registrationDate = registrationDate ?? DateTime.now();

  factory User.over(
    User user, {
    String avatar,
    String email,
    int id,
    String name,
    String phone,
    DateTime registrationDate,
    String token,
  }) =>
      User(
        avatar: avatar ?? user?.avatar,
        email: email ?? user?.email,
        id: id ?? user?.id,
        name: name ?? user?.name,
        phone: phone ?? user?.phone,
        registrationDate: registrationDate ?? user?.registrationDate,
        token: token ?? user?.token,
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
