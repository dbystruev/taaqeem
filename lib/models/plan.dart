//
//  lib/models/plan.dart
//
//  Created by Denis Bystruev on 18/03/2020, updated 19/04/2020.
//

class Plan {
  final String description;
  final String icon;
  final int id;
  final String image;
  final String title;
  final String type;
  final String subtitle;

  static int _maxId = 0;
  static int get maxId => _maxId;

  Plan(
    this.title, {
    this.description,
    this.icon,
    this.image,
    this.type,
    this.subtitle,
  }) : id = ++_maxId;

  void dispose() => _maxId -= id == _maxId ? 1 : 0;

  @override
  String toString() =>
      'Plan(\'$title\'' +
      (description == null ? '' : ', description: \'$description\'') +
      (icon == null ? '' : ', icon: "\'icon\'') +
      (image == null ? '' : ', image: "\'image\'') +
      (type == null ? '' : ', place: "\'place\'') +
      (subtitle == null ? '' : ', subtitle: "\'subtitle\'') +
      ')';
}
