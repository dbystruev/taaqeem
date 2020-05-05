//
//  lib/models/plan+all.dart
//
//  Created by Denis Bystruev on 18/03/2020.
//

import 'package:taaqeem/models/plan.dart';

extension AllPlans on Plan {
  static List<Plan> get local => [
        Plan(
          'Service for Villa & Apartment',
          description:
              'We provide You best companies with govt-approved sanitisation and disinfection or cleaning services for your home. Yalla!',
          icon: 'living',
          id: 1,
          image: 'residence',
          type: 'Villa & Apartment',
          subtitle: 'start from 30 m²',
        ),
        Plan(
          'Service for offices',
          description: 'We provide You best companies with govt-approved sani',
          icon: 'building',
          id: 2,
          image: 'office',
          type: 'Offices',
          subtitle: 'start from 50 m²',
        ),
        Plan(
          'Service for F&B outlets',
          description:
              'We provide You best companies with govt-approved sanitisation and disinfection or cleaning services for your restaurant. Yalla!',
          icon: 'food',
          id: 3,
          image: 'f&b',
          type: 'F&B Outlets',
          subtitle: 'start from 100 m²',
        ),
        Plan(
          'Service for industrial area ',
          description:
              'We provide You best companies with govt-approved sanitisation and disinfection or cleaning services for your workspace. Yalla!',
          icon: 'warehouse',
          id: 4,
          image: 'industrial',
          type: 'Industrial areas',
          subtitle: 'start from 500 m²',
        ),
      ];
}
