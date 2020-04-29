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
  final double scale;
  final Function(String) onChanged;

  FormWidget({
    this.controller,
    this.decoration,
    this.fontFamily = globals.fontFamily,
    this.fontSize = 15,
    this.fontWeight = FontWeight.normal,
    this.height = 1.6,
    this.hintText,
    this.keyboardType = TextInputType.number,
    this.labelText,
    this.obscureText = false,
    this.onChanged,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? getScale(context);
    return DecorationWidget(
      child: TextFormField(
        controller: controller,
        cursorColor: Theme.of(context).accentColor,
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
            ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize * scale,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
    );
  }
}
