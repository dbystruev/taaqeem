//
//  lib/models/order.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'dart:math';
import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  final DateTime cleaningDate;
  final DateTime creationDate;
  final int id;
  final double meters;
  final int planId;
  final String service;

  static int _maxId = 0;
  static get maxId => _maxId;

  Order({
    this.cleaningDate,
    DateTime creationDate,
    int id,
    this.meters,
    this.planId,
    this.service,
  })  : this.creationDate = creationDate ?? DateTime.now(),
        this.id = id ?? ++_maxId {
    _maxId = max(this.id, _maxId);
  }

  factory Order.over(
    Order order, {
    DateTime cleaningDate,
    DateTime creationDate,
    int id,
    double meters,
    int planId,
    String service,
  }) =>
      Order(
        cleaningDate: cleaningDate ?? order?.cleaningDate,
        creationDate: creationDate ?? order?.creationDate,
        id: id ?? order?.id,
        meters: meters ?? order?.meters,
        planId: planId ?? order?.planId,
        service: service ?? order?.service,
      );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
