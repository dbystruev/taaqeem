//
//  lib/screens/order_screen.dart
//
//  Created by Denis Bystruev on 29/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/route_validator_mixin.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/extensions/scroll_controller+extension.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/models/order.dart';
import 'package:taaqeem/models/plan.dart';
import 'package:taaqeem/models/plans.dart';
import 'package:taaqeem/screens/authorization_screen.dart';
import 'package:taaqeem/widgets/back_widget.dart';
import 'package:taaqeem/widgets/bottom_navigation_widget.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/calendar_widget.dart';
import 'package:taaqeem/widgets/dropdown_widget.dart';
import 'package:taaqeem/widgets/form_widget.dart';
import 'package:taaqeem/widgets/header_image_widget.dart';
import 'package:taaqeem/widgets/keyboard_actions_widget.dart';
import 'package:taaqeem/widgets/plus_button_widget.dart';
import 'package:taaqeem/widgets/title_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class OrderScreen extends StatefulWidget {
  final Plan plan;
  final Plans plans;

  OrderScreen({this.plan, @required this.plans});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with RouteValidator, Scale {
  CalendarController calendarController;
  FocusNode keyboardNode;
  List<Plan> plans;
  int selectedPlanIndex;
  int selectedServiceIndex;
  final List<String> services = [
    'Sanitation & disinfection',
    'Cleaning & maintenance',
  ];
  ScrollController scrollController;
  DateTime selectedDay;
  bool showCalendar = false;
  TextEditingController squareMetersController;
  double squareMeters;

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getScale(context);
    final bool showPlanSelection = widget.plan == null;
    final List<Widget> children = [
      if (showPlanSelection) BackWidget('Create new booking'),
      if (!showPlanSelection) HeaderImageWidget(widget.plan.image),
      if (!showPlanSelection) SizedBox(height: 16 * scale),
      if (!showPlanSelection)
        TitleWidget(
          widget.plan.title,
          subtitle:
              'Fill in the form, please and we will help\nYou immediately',
        ),
      if (showPlanSelection)
        DropdownWidget(
          plans.map<String>((plan) => plan.type).toList(),
          hint: 'Type of area',
          onChanged: (int index) {
            setState(() => selectedPlanIndex = index < 0 ? null : index);
            hideCalendarAndKeyboard();
          },
          selectedItemIndex: selectedPlanIndex,
        ),
      DropdownWidget(
        services,
        hint: 'Type of service',
        onChanged: (int index) {
          setState(() => selectedServiceIndex = index < 0 ? null : index);
          hideCalendarAndKeyboard();
        },
        selectedItemIndex: selectedServiceIndex,
      ),
      FormWidget(
        controller: squareMetersController,
        hintText: 'Square meters²',
        keyboardNode: keyboardNode,
        onEditingComplete: hideCalendarAndKeyboard,
        onChanged: (String text) {
          squareMeters = double.tryParse(text);
          hideCalendar();
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
                this.selectedDay = selectedDay;
                hideCalendarAndKeyboard();
              },
              onUnavailableDaySelected: hideCalendarAndKeyboard,
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
          onPressed: routeToTheNextScreenIfValid,
          width: 335,
        ),
        opacity: showCalendar ? 0 : 1,
      ),
    ];
    return Scaffold(
      body: GestureDetector(
        child: KeyboardActionsWidget(
          child: ListView(
            children: children
                .map(
                  (child) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: child,
                    onTap: hideCalendarAndKeyboard,
                  ),
                )
                .toList(),
            controller: scrollController,
            padding: EdgeInsets.all(
              Scale.getSafeMargin(context),
            ),
          ),
          focusNode: keyboardNode,
          onTapAction: hideCalendarAndKeyboard,
        ),
        onTap: hideCalendarAndKeyboard,
      ),
      bottomNavigationBar: BottomNavigationWidget(
        onTap: (int index) {
          setState(() => BottomNavigationWidget.selectedBottomBarItem = index);
        },
        selectedIndex: BottomNavigationWidget.selectedBottomBarItem,
      ),
      floatingActionButton:
          PlusButtonWidget(onTap: routeToTheNextScreenIfValid),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    squareMetersController.dispose();
    scrollController.dispose();
    keyboardNode.dispose();
    calendarController.dispose();
    super.dispose();
  }

  void hideCalendar() {
    if (showCalendar) setState(() => showCalendar = false);
  }

  void hideCalendarAndKeyboard() {
    FocusScope.of(context).unfocus();
    hideCalendar();
  }

  @override
  void initState() {
    super.initState();
    calendarController = CalendarController();
    keyboardNode = FocusNode();
    plans = widget.plans.plans;
    scrollController = ScrollController();
    squareMetersController = TextEditingController();
  }

  void routeToTheNextScreenIfValid() {
    hideCalendarAndKeyboard();
    routeIfValid(
      context,
      builder: (context) => AuthorizationScreen(
        order: Order(
          day: selectedDay,
          meters: squareMeters,
          plan: widget.plan,
          service: services[selectedServiceIndex],
        ),
      ),
      validator: validator,
    );
  }

  String validatePlan(Plan plan) {
    if (plan?.id == null) return 'please choose the type of area';
    if (selectedServiceIndex == null ||
        selectedServiceIndex < 0 ||
        services.length <= selectedServiceIndex)
      return 'please choose the type of service';
    if (squareMeters == null || squareMeters < 1)
      return 'please enter a positive number of square meters';
    if (selectedDay == null ||
        selectedDay.isBefore(
          DateTime.now(),
        )) return 'please select a date in the future';
    return '';
  }

  String validator() {
    final Plan plan = widget.plan ??
        (selectedPlanIndex == null ? null : plans[selectedPlanIndex]);
    return validatePlan(plan);
  }
}
