//
//  lib/screens/order_screen.dart
//
//  Created by Denis Bystruev on 29/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/models/plan.dart';
import 'package:taaqeem/widgets/dropdown_widget.dart';
import 'package:taaqeem/widgets/header_image_widget.dart';
import 'package:taaqeem/widgets/title_widget.dart';

class OrderScreen extends StatefulWidget {
  final Plan plan;

  OrderScreen(this.plan);

  @override
  _OrderScreenState createState() => _OrderScreenState(plan);
}

class _OrderScreenState extends State<OrderScreen> with Scale {
  final Plan plan;
  int selectedService;
  final List<String> services = [
    'Sanitation & disinfection',
    'Cleaning & maintenance',
  ];

  _OrderScreenState(this.plan);

  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context);
    return Container(
      child: Scaffold(
        body: ListView(
          children: [
            HeaderImageWidget(plan.image, scale: scale),
            SizedBox(height: 16 * scale),
            TitleWidget(
              plan.title,
              scale: scale,
              subtitle: 'Fill in the form, please and we will help' +
                  '\nYou immediately',
            ),
            DropdownWidget(
              services,
              hint: 'Type of service',
              onChanged: (int index) {
                setState(() => selectedService = index < 0 ? null : index);
              },
              selectedService: selectedService,
            )
          ],
          padding: EdgeInsets.all(
            getSafeMargin(context),
          ),
        ),
      ),
    );
  }
}
