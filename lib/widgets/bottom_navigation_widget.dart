//
//  lib/widgets/bottom_navigation_widget.dart
//
//  Created by Denis Bystruev on 27/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;

class BottomNavigationWidget extends BottomNavigationBar {
  static const labelStyle = TextStyle(
    fontFamily: globals.fontFamily,
    fontWeight: FontWeight.w600,
  );

  BottomNavigationWidget({
    int currentIndex = 0,
    ValueChanged<int> onTap,
    double scale = 1,
  }) : super(
          currentIndex: currentIndex,
          items: [
            barItem(name: 'home', scale: scale, text: 'Main page', width: 22),
            barItem(height: 18, scale: scale, text: 'About us', width: 27),
            barItem(),
            barItem(scale: scale, text: 'Support'),
            barItem(name: 'user', scale: scale, text: 'My Taaqeem'),
          ],
          onTap: onTap,
          selectedFontSize: 12 * scale,
          selectedItemColor: globals.accentColor,
          selectedLabelStyle: labelStyle,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: globals.subtitleColor,
          unselectedFontSize: 12 * scale,
          unselectedLabelStyle: labelStyle,
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
}
