//
//  lib/screens/order_screen.dart
//
//  Created by Denis Bystruev on 29/04/2020.
//

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/extensions/scroll_controller+extension.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/plan.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/widgets/back_widget.dart';
import 'package:taaqeem/widgets/bottom_navigation_widget.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/calendar_widget.dart';
import 'package:taaqeem/widgets/dropdown_widget.dart';
import 'package:taaqeem/widgets/form_widget.dart';
import 'package:taaqeem/widgets/header_image_widget.dart';
import 'package:taaqeem/widgets/plus_button_widget.dart';
import 'package:taaqeem/widgets/title_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class OrderScreen extends StatefulWidget {
  final Plan plan;
  final Plans plans;

  OrderScreen({this.plan, this.plans});

  @override
  _OrderScreenState createState() =>
      _OrderScreenState(plan: plan, plans: plans);
}

class _OrderScreenState extends State<OrderScreen> with Scale {
  final CalendarController calendarController = CalendarController();
  KeyboardActionsConfig keyboardConfig;
  final FocusNode keyboardNode = FocusNode();
  final Plan plan;
  final Plans plans;
  int selectedPlanIndex;
  int selectedServiceIndex;
  final List<String> services = [
    'Sanitation & disinfection',
    'Cleaning & maintenance',
  ];
  final ScrollController scrollController = ScrollController();
  DateTime selectedDay;
  bool showCalendar = false;
  final TextEditingController squareMetersController = TextEditingController();
  double squareMeters;

  _OrderScreenState({this.plan, this.plans});

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getScale(context);
    final bool showHeaderTitle = plan != null;
    final bool showPlanSelection = plans != null;
    final List<Widget> children = [
      if (!showHeaderTitle) BackWidget('Create new booking'),
      if (showHeaderTitle) HeaderImageWidget(plan.image),
      if (showHeaderTitle) SizedBox(height: 16 * scale),
      if (showHeaderTitle)
        TitleWidget(
          plan.title,
          subtitle:
              'Fill in the form, please and we will help\nYou immediately',
        ),
      if (showPlanSelection)
        DropdownWidget(
          plans.plans.map<String>((plan) => plan.type).toList(),
          hint: 'Type of area',
          onChanged: (int index) {
            setState(() => selectedPlanIndex = index < 0 ? null : index);
          },
          selectedItemIndex: selectedPlanIndex,
        ),
      DropdownWidget(
        services,
        hint: 'Type of service',
        onChanged: (int index) {
          setState(() => selectedServiceIndex = index < 0 ? null : index);
          hideKeyboard();
        },
        selectedItemIndex: selectedServiceIndex,
      ),
      FormWidget(
        controller: squareMetersController,
        hintText: 'Square meters²',
        keyboardNode: keyboardNode,
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
              availableGestures: AvailableGestures.horizontalSwipe,
              calendarController: calendarController,
              calendarStyle: CalendarStyle(
                selectedColor: Theme.of(context).accentColor,
                todayColor: globals.subtitleColor,
              ),
              holidays: globals.holidays,
              initialSelectedDay: selectedDay,
              locale: globals.locale,
              onDaySelected: (DateTime selectedDay, _) {
                setState(() {
                  this.selectedDay = selectedDay;
                  this.showCalendar = false;
                });
              },
              onUnavailableDaySelected: () => setState(
                () => this.showCalendar = false,
              ),
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
      Opacity(
        child: ButtonWidget(
          'Book Service',
          onPressed: () {
            hideKeyboard();
            debugPrint('lib/screens/order_screen.dart:143 book $plan');
          },
          width: 335,
        ),
        opacity: showCalendar ? 0 : 1,
      ),
    ];
    return Scaffold(
      body: GestureDetector(
        child: KeyboardActions(
          config: keyboardConfig,
          child: ListView(
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
        onTap: hideKeyboard,
      ),
      bottomNavigationBar: BottomNavigationWidget(
        onTap: (int index) {
          setState(() => BottomNavigationWidget.selectedBottomBarItem = index);
        },
        selectedIndex: BottomNavigationWidget.selectedBottomBarItem,
      ),
      floatingActionButton: PlusButtonWidget(
        onTap: () {
          debugPrint(
            'lib/screens/main_screen.dart:181 plus button',
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    calendarController.dispose();
    keyboardNode.dispose();
    squareMetersController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    keyboardConfig = KeyboardActionsConfig(
      actions: [
        KeyboardAction(
          displayArrows: false,
          focusNode: keyboardNode,
        )
      ],
    );
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
    if (showCalendar) setState(() => showCalendar = false);
  }
}
