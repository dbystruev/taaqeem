//
//  lib/models/order.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  DateTime cleaningDate;
  DateTime creationDate;
  int id;
  bool get isPending =>
      cleaningDate != null &&
      meters != null &&
      planId != null &&
      service != null;
  double meters;
  int planId;
  String service;

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

  assign({
    DateTime cleaningDate,
    DateTime creationDate,
    int id,
    double meters,
    int planId,
    String service,
  }) {
    this.cleaningDate = cleaningDate ?? this.cleaningDate;
    this.creationDate = creationDate ?? this.creationDate;
    this.id = id ?? this.id;
    this.meters = meters ?? this.meters;
    this.planId = planId ?? this.planId;
    this.service = service ?? this.service;
  }

  clear() {
    cleaningDate = null;
    creationDate = null;
    id = null;
    meters = null;
    planId = null;
    service = null;
  }

  copy(Order order) {
    cleaningDate = order.cleaningDate;
    creationDate = order.creationDate;
    id = order.id;
    meters = order.meters;
    planId = order.planId;
    service = order.service;
  }

  isSimilar(Order order) =>
      cleaningDate == order.cleaningDate &&
      creationDate == order.creationDate &&
      meters == order.meters &&
      planId == order.planId &&
      service == order.service;

  merge(
    Order order,
  ) {
    cleaningDate = order.cleaningDate ?? cleaningDate;
    creationDate = order.creationDate ?? creationDate;
    id = order.id ?? id;
    meters = order.meters ?? meters;
    planId = order.planId ?? planId;
    service = order.service ?? service;
  }
}
