//
//  lib/screens/order_screen.dart
//
//  Created by Denis Bystruev on 29/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/extensions/scroll_controller+extension.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/plan.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/calendar_widget.dart';
import 'package:taaqeem/widgets/dropdown_widget.dart';
import 'package:taaqeem/widgets/form_widget.dart';
import 'package:taaqeem/widgets/header_image_widget.dart';
import 'package:taaqeem/widgets/title_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class OrderScreen extends StatefulWidget {
  final Plan plan;

  OrderScreen(this.plan);

  @override
  _OrderScreenState createState() => _OrderScreenState(plan);
}

class _OrderScreenState extends State<OrderScreen> with Scale {
  final CalendarController calendarController = CalendarController();
  final Plan plan;
  int selectedService;
  final List<String> services = [
    'Sanitation & disinfection',
    'Cleaning & maintenance',
  ];
  final ScrollController scrollController = ScrollController();
  DateTime selectedDay;
  bool showCalendar = false;
  final TextEditingController squareMetersController = TextEditingController();
  double squareMeters;

  _OrderScreenState(this.plan);

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getScale(context);
    final List<Widget> children = [
      HeaderImageWidget(plan.image),
      SizedBox(height: 16 * scale),
      TitleWidget(
        plan.title,
        subtitle:
            'Fill in the form, please and we will help' + '\nYou immediately',
      ),
      DropdownWidget(
        services,
        hint: 'Type of service',
        onChanged: (int index) {
          setState(() => selectedService = index < 0 ? null : index);
          hideKeyboard();
        },
        selectedService: selectedService,
      ),
      FormWidget(
        controller: squareMetersController,
        hintText: 'Square meters²',
        onEditingComplete: () {},
        onChanged: (String text) {
          squareMeters = double.tryParse(text);
          if (showCalendar) setState(() => showCalendar = false);
        },
        suffixText: ' m²',
      ),
      showCalendar
          ? TableCalendar(
              availableCalendarFormats: const {CalendarFormat.month: ''},
              calendarController: calendarController,
              calendarStyle: CalendarStyle(
                selectedColor: Theme.of(context).accentColor,
                todayColor: globals.subtitleColor,
              ),
              holidays: globals.holidays,
              initialSelectedDay: selectedDay,
              onDaySelected: (DateTime selectedDay, _) {
                setState(() {
                  this.selectedDay = selectedDay;
                  this.showCalendar = false;
                });
              },
              startDay: DateTime.now(),
              weekendDays: const [DateTime.friday, DateTime.saturday],
            )
          : CalendarWidget(
              onTap: () {
                setState(() => showCalendar = true);
                scrollController.scrollTo(
                  3,
                  collapsedHeight: 62,
                  context: context,
                  expandedHeight: 391,
                  expandedIndex: 3,
                  headerHeight: 391,
                );
              },
              selectedDay: selectedDay,
            ),
      ButtonWidget(
        'Book Service',
        onPressed: () {
          hideKeyboard();
          debugPrint('lib/screens/order_screen.dart:102 book $plan');
        },
        width: 335,
      ),
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
          controller: scrollController,
          padding: EdgeInsets.all(
            Scale.getSafeMargin(context),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    calendarController.dispose();
    squareMetersController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
    if (showCalendar) setState(() => showCalendar = false);
  }
}
