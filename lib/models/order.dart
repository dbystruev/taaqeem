//
//  lib/models/order.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:taaqeem/models/plan.dart';

class Order {
  final DateTime day;
  final double meters;
  final Plan plan;
  final String service;

  Order({this.day, this.meters, this.plan, this.service});
}
