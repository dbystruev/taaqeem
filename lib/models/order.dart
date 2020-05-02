//
//  lib/models/order.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'dart:math';
import 'package:taaqeem/models/plan.dart';

class Order {
  final DateTime cleaningDate;
  final DateTime creationDate;
  final int id;
  final double meters;
  final Plan plan;
  final String service;

  static int _maxId = 0;
  static get maxId => _maxId;

  Order({
    this.cleaningDate,
    DateTime creationDate,
    int id,
    this.meters,
    this.plan,
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
    Plan plan,
    String service,
  }) =>
      Order(
        cleaningDate: cleaningDate ?? order?.cleaningDate,
        creationDate: creationDate ?? order?.creationDate,
        id: id ?? order?.id,
        meters: meters ?? order?.meters,
        plan: plan ?? order?.plan,
        service: service ?? order?.service,
      );
}
