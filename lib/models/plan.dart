//
//  lib/models/plan.dart
//
//  Created by Denis Bystruev on 18/03/2020, updated 19/04/2020.
//

import 'package:taaqeem/models/place.dart';

class Plan {
  final String currency;
  final String description;
  final int hours;
  final int id;
  final Place place;
  final int price;
  final String title;

  static int _maxId = 0;
  static int get maxId => _maxId;

  Plan(
    this.title, {
    this.currency = 'AED',
    this.hours = 0,
    this.description,
    this.place,
    this.price,
  }) : id = ++_maxId;

  void dispose() => _maxId -= id == _maxId ? 1 : 0;

  @override
  String toString() =>
      'Plan(\'$title\'' +
      (currency == null ? '' : ', currency: \'$currency\'') +
      (description == null ? '' : ', description: \'$description\'') +
      (place == null ? '' : ', place: "\'place\'') +
      (price == null ? '' : ', price: \'$price\'') +
      ')';
}
