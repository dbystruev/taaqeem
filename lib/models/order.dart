//
//  lib/models/order.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  final DateTime cleaningDate;
  final DateTime creationDate;
  final int id;
  bool get isPending =>
      cleaningDate != null &&
      meters != null &&
      planId != null &&
      service != null;
  final double meters;
  final int planId;
  final String service;

  Order({
    this.cleaningDate,
    DateTime creationDate,
    this.id,
    this.meters,
    this.planId,
    this.service,
  }) : this.creationDate = creationDate ?? DateTime.now();

  factory Order.merge(Order order, Order newData) => Order(
        cleaningDate: newData?.cleaningDate ?? order?.cleaningDate,
        creationDate: order?.creationDate ?? newData?.creationDate,
        id: newData?.id ?? order?.id,
        meters: newData?.meters ?? order?.meters,
        planId: newData?.planId ?? order?.planId,
        service: newData?.service ?? order?.service,
      );

  factory Order.over(
    Order order, {
    DateTime cleaningDate,
    DateTime creationDate,
    int id,
    double meters,
    int planId,
    String service,
  }) =>
      Order.merge(
        order,
        Order(
          cleaningDate: cleaningDate,
          creationDate: creationDate,
          id: id,
          meters: meters,
          planId: planId,
          service: service,
        ),
      );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  String toString() {
    return '''Order(
    cleaningDate: '$cleaningDate',
    creationDate: '$creationDate',
    id: $id,
    meters: $meters,
    planId: $planId,
    service: '$service',
  )''';
  }
}
