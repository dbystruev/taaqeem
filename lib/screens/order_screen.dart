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
import 'package:taaqeem/models/screen_data.dart';
import 'package:taaqeem/screens/main_screen.dart';
import 'package:taaqeem/screens/profile_landing_screen.dart';
import 'package:taaqeem/widgets/back_widget.dart';
import 'package:taaqeem/widgets/button_widget.dart';
import 'package:taaqeem/widgets/calendar_widget.dart';
import 'package:taaqeem/widgets/dropdown_widget.dart';
import 'package:taaqeem/widgets/form_widget.dart';
import 'package:taaqeem/widgets/header_image_widget.dart';
import 'package:taaqeem/widgets/keyboard_actions_widget.dart';
import 'package:taaqeem/widgets/navigator_widget.dart';
import 'package:taaqeem/widgets/scaffold_bar_widget.dart';
import 'package:taaqeem/widgets/title_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class OrderScreen extends StatefulWidget {
  static const routeIndex = 4;
  static String get routeName => NavigatorWidget.routeName(routeIndex);
  static const List<String> services = [
    'Sanitation & disinfection',
    'Cleaning & maintenance',
  ];

  final ScreenData screenData;

  OrderScreen(ScreenData screenData)
      : this.screenData = ScreenData.over(screenData, routeIndex: routeIndex);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with RouteValidator {
  CalendarController calendarController;
  FocusNode keyboardNode;
  Plan get plan => selectedPlan != null && selectedPlan < plans.length
      ? plans[selectedPlan]
      : null;
  List<Plan> plans;
  ScreenData screenData;
  int get selectedPlan => screenData.selectedPlan;
  int selectedPlanIndex;
  int selectedServiceIndex;
  ScrollController scrollController;
  DateTime selectedDay;
  bool showCalendar = false;
  TextEditingController squareMetersController;
  double squareMeters;

  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getHorizontalScale(context);
    final bool showPlanSelection = plan == null;
    final List<Widget> children = [
      if (showPlanSelection)
        BackWidget(
          'Create new booking',
          // marginTop: 31,
          scale: scale,
        ),
      if (!showPlanSelection) HeaderImageWidget(plan.image),
      if (!showPlanSelection) SizedBox(height: 16 * scale),
      if (!showPlanSelection)
        TitleWidget(
          plan.title,
          subtitle:
              'Fill in the form, please and we will help\nYou immediately',
        ),
      if (showPlanSelection)
        DropdownWidget(
          plans.map<String>((plan) => plan.type).toList(),
          hint: 'Type of area',
          onChanged: (int index) {
            setState(() => selectedPlanIndex = index < 0 ? null : index);
            screenData =
                ScreenData.over(screenData, selectedPlan: selectedPlanIndex);
            hideCalendarAndKeyboard();
          },
          selectedItemIndex: selectedPlanIndex,
        ),
      DropdownWidget(
        OrderScreen.services,
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
          onPressed: () => routeToMainOrProfileScreenIfValid(showPlanSelection),
          width: 335,
        ),
        opacity: showCalendar ? 0 : 1,
      ),
    ];
    return ScaffoldBarWidget(
      body: KeyboardActionsWidget(
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
      onPlusTap: () => routeToMainOrProfileScreenIfValid(showPlanSelection),
      onCanvasTap: hideCalendarAndKeyboard,
      removePreviousRoute: showPlanSelection,
      getScreenData: () => screenData,
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
    screenData = widget.screenData;
    plans = screenData.plans.plans;
    scrollController = ScrollController();
    squareMetersController = TextEditingController();
  }

  void routeToMainOrProfileScreenIfValid(bool showPlanSelection) {
    hideCalendarAndKeyboard();
    screenData = ScreenData.over(
      screenData,
      order: Order.over(
        screenData.order,
        cleaningDate: selectedDay,
        creationDate: DateTime.now(),
        meters: squareMeters,
        planId: plan?.id,
        service: OrderScreen.services[selectedServiceIndex],
      ),
    );
    final builder = screenData.user.isLoggedIn
        ? (BuildContext context) => MainScreen(screenData)
        : (BuildContext context) => ProfileLandingScreen(screenData);
    final String name = screenData.user.isLoggedIn
        ? MainScreen.routeName
        : ProfileLandingScreen.routeName;
    pushRouteIfValid(
      context,
      builder: builder,
      name: name,
      removePrevious: showPlanSelection,
      replace: true,
      validator: validator,
    );
  }

  String validatePlan(Plan plan) {
    if (plan?.id == null) return 'please choose the type of area';
    if (selectedServiceIndex == null ||
        selectedServiceIndex < 0 ||
        OrderScreen.services.length <= selectedServiceIndex)
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
    final Plan plan = this.plan ??
        (selectedPlanIndex == null ? null : plans[selectedPlanIndex]);
    return validatePlan(plan);
  }
}
