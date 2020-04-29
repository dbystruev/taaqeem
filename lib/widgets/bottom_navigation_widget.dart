//
//  lib/widgets/bottom_navigation_widget.dart
//
//  Created by Denis Bystruev on 27/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/text_widgets.dart';

class BottomNavigationWidget extends StatelessWidget with Scale {
  final ValueChanged<int> onTap;
  final int selectedIndex;

  BottomNavigationWidget({this.onTap, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context);
    return Container(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: buildBottomAppBar(
          currentIndex: selectedIndex,
          onTap: onTap,
          scale: scale,
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 15 * scale,
            color: globals.shadowColor,
          )
        ],
      ),
    );
  }

  Widget buildBarItem(
    int index,
    String text, {
    double iconHeight = 20,
    String iconName,
    double iconWidth = 20,
    ValueChanged<int> onTap,
    double scale = 1,
    bool selected = false,
  }) {
    final Color color = selected ? globals.accentColor : globals.subtitleColor;
    final String imageName = iconName ?? text.split(' ').first.toLowerCase();
    final String imageSuffix = selected ? '_green' : '_grey';
    final Image image = Image(
      height: scale * iconHeight,
      image: AssetImage('assets/images/$imageName$imageSuffix.png'),
      width: scale * iconWidth,
    );
    final TheText textWidget = TheText.w600(
      color: color,
      fontSize: 12,
      text: text,
      textAlign: TextAlign.center,
      textScaleFactor: scale,
    );
    return InkWell(
      child: Column(
        children: [
          image,
          SizedBox(height: 5 * scale),
          textWidget,
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      onTap: () => onTap?.call(index),
    );
  }

  Widget buildBottomAppBar({
    int currentIndex = 0,
    ValueChanged<int> onTap,
    double scale = 1,
  }) {
    int barItemIndex = 0;
    Expanded barItem(
      String text, {
      double iconHeight = 20,
      String iconName,
      double iconWidth = 20,
    }) =>
        Expanded(
          child: buildBarItem(
            barItemIndex,
            text,
            iconHeight: iconHeight,
            iconName: iconName,
            iconWidth: iconWidth,
            onTap: onTap,
            scale: scale,
            selected: currentIndex == barItemIndex++,
          ),
        );
    return SizedBox(
      child: Row(
        children: [
          barItem('Main page', iconName: 'home', iconWidth: 22),
          barItem('About us', iconHeight: 18, iconWidth: 27),
          SizedBox(width: 14 * scale),
          barItem('Support'),
          barItem('My Taaqeem', iconName: 'user'),
        ],
      ),
      height: 70 * scale,
    );
  }
}
