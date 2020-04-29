//
//  lib/widgets/calendar_widget.dart
//
//  Created by Denis Bystruev on 29/04/2020.
//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/decoration_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime selectedDay;

  CalendarWidget({DateTime selectedDay})
      : this.selectedDay = selectedDay ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    return DecorationWidget(
      child: TheText.normal(
        color: globals.subtitleColor,
        fontSize: 15,
        height: 1.6,
        text: 'Preferable date: ${DateFormat.yMd().format(selectedDay)}',
      ),
      icon: 'calendar',
      paddingLeft: 26,
    );
  }
}
