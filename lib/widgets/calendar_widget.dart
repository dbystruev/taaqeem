//
//  lib/widgets/calendar_widget.dart
//
//  Created by Denis Bystruev on 29/04/2020.
//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/decoration_padding_widget.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class CalendarWidget extends StatelessWidget {
  final VoidCallback onTap;
  final DateTime selectedDay;

  CalendarWidget({
    this.onTap,
    this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: DecorationPaddingWidget(
        marginBottom: 10,
        child: TheText.normal(
          color: selectedDay == null ? globals.subtitleColor : globals.menuItemColor,
          fontSize: 15,
          height: 1.6,
          text: selectedDay == null
              ? 'Please choose the date'
              : 'Preferable date: ${DateFormat.yMd(globals.locale).format(selectedDay)}',
        ),
        icon: 'calendar',
        paddingLeft: 26,
      ),
      onTap: onTap,
    );
  }
}
