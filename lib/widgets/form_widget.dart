//
//  lib/widgets/form_widget.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/decoration_widget.dart';

class FormWidget extends StatelessWidget with Scale {
  final Color color;
  final TextEditingController controller;
  final InputDecoration decoration;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final String hintText;
  final TextInputType keyboardType;
  final String labelText;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final double scale;
  final String suffixText;

  FormWidget({
    this.color = globals.menuItemColor,
    this.controller,
    this.decoration,
    this.fontFamily = globals.fontFamily,
    this.fontSize = 15,
    this.fontWeight = FontWeight.normal,
    this.height = 1.6,
    this.hintText,
    this.keyboardType = const TextInputType.numberWithOptions(decimal: true),
    this.labelText,
    this.obscureText = false,
    this.onChanged,
    this.onEditingComplete,
    this.scale,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    return DecorationWidget(
      child: TextFormField(
        controller: controller,
        cursorColor: globals.subtitleColor,
        decoration: decoration ??
            InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5 * scale),
                borderSide: BorderSide.none,
              ),
              isDense: true,
              hintStyle: TextStyle(
                color: globals.subtitleColor,
              ),
              hintText: hintText,
              suffixText: suffixText,
              suffixStyle: TextStyle(color: color),
            ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        style: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontSize: fontSize * scale,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
    );
  }
}
