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
  bool get isFilled => email != null && name != null && phone != null;
  bool get isLoggedIn => token != null && token.length == 128;
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

  factory User.merge(User user, User newData) => User(
        avatar: newData?.avatar ?? user?.avatar,
        email: newData?.email ?? user?.email,
        id: newData?.id ?? user?.id,
        name: newData?.name ?? user?.name,
        phone: newData?.phone ?? user?.phone,
        registrationDate: user?.registrationDate ?? newData?.registrationDate,
        token: newData?.token ?? user?.token,
      );

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
      User.merge(
        user,
        User(
          avatar: avatar,
          email: email,
          id: id,
          name: name,
          phone: phone,
          registrationDate: registrationDate,
          token: token,
        ),
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return '''User(
    avatar: '$avatar',
    email: '$email',
    id: $id,
    name: '$name',
    phone: '$phone',
    registrationDate: '$registrationDate',
    token: '$token',
  )''';
  }
}
