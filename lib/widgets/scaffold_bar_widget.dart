//
//  lib/widgets/scaffold_bar_widget.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/widgets/bottom_navigation_widget.dart';
import 'package:taaqeem/widgets/plus_button_widget.dart';

class ScaffoldBarWidget extends StatefulWidget {
  final Widget body;
  final VoidCallback onPlusTap;
  final ValueChanged<int> onTap;

  ScaffoldBarWidget({this.body, this.onPlusTap, this.onTap});

  @override
  _ScaffoldBarWidgetState createState() => _ScaffoldBarWidgetState();
}

class _ScaffoldBarWidgetState extends State<ScaffoldBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: BottomNavigationWidget(
        onTap: (int index) {
          setState(() => BottomNavigationWidget.selectedBottomBarItem = index);
          widget.onTap?.call(index);
        },
        selectedIndex: BottomNavigationWidget.selectedBottomBarItem,
      ),
      floatingActionButton: PlusButtonWidget(onTap: widget.onPlusTap),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
