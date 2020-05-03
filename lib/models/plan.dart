//
//  lib/models/plan.dart
//
//  Created by Denis Bystruev on 18/03/2020, updated 19/04/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'package:json_annotation/json_annotation.dart';

/// This allows the `Plan` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'plan.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Plan {
  final String description;
  final String icon;
  final int id;
  bool get isValid =>
      description != null &&
      description.isNotEmpty &&
      icon != null &&
      icon.isNotEmpty &&
      id != null &&
      0 < id &&
      image != null &&
      image.isNotEmpty &&
      title != null &&
      title.isNotEmpty &&
      type != null &&
      type.isNotEmpty &&
      subtitle != null &&
      subtitle.isNotEmpty;
  final String image;
  final String title;
  final String type;
  final String subtitle;

  Plan(
    this.title, {
    this.description,
    this.icon,
    this.id,
    this.image,
    this.type,
    this.subtitle,
  });

  /// A necessary factory constructor for creating a new Plan instance
  /// from a map. Pass the map to the generated `_$PlanFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Plan.
  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PlanToJson`.
  Map<String, dynamic> toJson() => _$PlanToJson(this);

  @override
  String toString() =>
      '\nPlan(\'$title\'' +
      (description == null ? '' : ', description: \'$description\'') +
      (icon == null ? '' : ', icon: \'$icon\'') +
      (id == null ? '' : ', id: \'$id\'') +
      (image == null ? '' : ', image: \'$image\'') +
      (type == null ? '' : ', type: \'$type\'') +
      (subtitle == null ? '' : ', subtitle: \'$subtitle\'') +
      ')';
}
