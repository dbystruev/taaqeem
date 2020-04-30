//
//  lib/models/policy.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'package:taaqeem/models/policy_section.dart';

class Policy {
  final List<PolicySection> sections;
  final String title;

  Policy(this.title, {this.sections});
}
