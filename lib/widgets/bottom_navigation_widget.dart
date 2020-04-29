//
//  lib/widgets/bottom_navigation_widget.dart
//
//  Created by Denis Bystruev on 27/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/text_widgets.dart';

class BottomNavigationWidget extends BottomAppBar {
  BottomNavigationWidget({
    int currentIndex = 0,
    ValueChanged<int> onTap,
    double scale = 1,
  }) : super(
          child: buildBottomAppBarContents(
            currentIndex: currentIndex,
            onTap: onTap,
          ),
        );

  static BottomNavigationBarItem barItem({
    String name,
    double height = 20,
    double scale = 1,
    String text,
    double width = 20,
  }) {
    final String imageName = name ?? text?.split(' ')?.first?.toLowerCase();
    return text == null
        ? BottomNavigationBarItem(
            icon: SizedBox(width: scale),
            title: Text(''),
          )
        : BottomNavigationBarItem(
            activeIcon: Image(
              height: scale * height,
              image: AssetImage('assets/images/${imageName}_green.png'),
              width: scale * width,
            ),
            icon: Image(
              height: scale * height,
              image: AssetImage('assets/images/${imageName}_grey.png'),
              width: scale * width,
            ),
            title: Text(text),
          );
  }

  static Widget buildBarItem(
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
    return GestureDetector(
      child: Column(
        children: [
          image,
          SizedBox(height: 5 * scale),
          textWidget,
        ],
      ),
      onTap: () => onTap?.call(index),
    );
  }

  static Container buildBottomAppBarContents({
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
    return Container(
      child: Row(
        children: [
          barItem('Main page', iconName: 'home', iconWidth: 22),
          barItem('About us', iconHeight: 18, iconWidth: 27),
          SizedBox(width: 14 * scale),
          barItem('Support'),
          barItem('My Taaqeem', iconName: 'user'),
        ],
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
      height: 40 * scale,
    );
  }
}
