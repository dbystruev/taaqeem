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
  final List<int> orderIds;
  final String phone;
  final DateTime registrationDate;

  User({
    this.avatar,
    this.email,
    this.id,
    this.name,
    this.orderIds,
    this.phone,
    DateTime registrationDate,
  }) : this.registrationDate = registrationDate ?? DateTime.now();

  factory User.over(
    User user, {
    String avatar,
    String email,
    int id,
    String name,
    List<int> orderIds,
    String phone,
    DateTime registrationDate,
  }) =>
      User(
        avatar: avatar ?? user?.avatar,
        email: email ?? user?.email,
        id: id ?? user?.id,
        name: name ?? user?.name,
        orderIds: orderIds ?? user?.orderIds,
        phone: phone ?? user?.phone,
        registrationDate: registrationDate ?? user?.registrationDate,
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
