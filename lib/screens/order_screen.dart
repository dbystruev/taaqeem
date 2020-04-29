//
//  lib/screens/order_screen.dart
//
//  Created by Denis Bystruev on 29/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/models/plan.dart';
import 'package:taaqeem/widgets/calendar_widget.dart';
import 'package:taaqeem/widgets/dropdown_widget.dart';
import 'package:taaqeem/widgets/form_widget.dart';
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
  final ScrollController scrollController = ScrollController();
  final TextEditingController squareMetersController = TextEditingController();
  double squareMeters;

  _OrderScreenState(this.plan);

  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context);
    final List<Widget> children = [
      HeaderImageWidget(plan.image, scale: scale),
      SizedBox(height: 16 * scale),
      TitleWidget(
        plan.title,
        scale: scale,
        subtitle:
            'Fill in the form, please and we will help' + '\nYou immediately',
      ),
      DropdownWidget(
        services,
        hint: 'Type of service',
        onChanged: (int index) {
          setState(() => selectedService = index < 0 ? null : index);
        },
        selectedService: selectedService,
      ),
      FormWidget(
        controller: squareMetersController,
        hintText: 'Square meters²',
        onChanged: (String text) {
          squareMeters = double.tryParse(text) ?? squareMeters;
        },
      ),
      CalendarWidget(),
    ];
    return Container(
      child: Scaffold(
        body: ListView(
          children: children
              .map(
                (child) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: child,
                  onTap: hideKeyboard,
                ),
              )
              .toList(),
          padding: EdgeInsets.all(
            getSafeMargin(context),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    squareMetersController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void hideKeyboard() => FocusScope.of(context).unfocus();
}
