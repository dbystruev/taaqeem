//
//  lib/widgets/form_widget.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/decoration_padding_widget.dart';

class FormWidget extends StatelessWidget {
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double boxHeight;
  final double boxWidth;
  final Color color;
  final TextEditingController controller;
  final Decoration decoration;
  final bool enabled;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final Color hintColor;
  final String hintText;
  final InputDecoration inputDecoration;
  final FocusNode keyboardNode;
  final TextInputType keyboardType;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final int maxLines;
  final String labelText;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double scale;
  final String suffixText;
  final TextInputAction textInputAction;

  FormWidget({
    this.borderColor = globals.subtitleColor,
    this.borderRadius = 5,
    this.borderWidth = 1,
    this.boxHeight = 52,
    this.boxWidth,
    this.color = globals.menuItemColor,
    this.controller,
    this.decoration,
    this.enabled = true,
    this.fontFamily = globals.fontFamily,
    this.fontSize = 15,
    this.fontWeight = FontWeight.normal,
    this.height = 1.6,
    this.hintColor = globals.subtitleColor,
    this.hintText,
    this.inputDecoration,
    this.keyboardNode,
    this.keyboardType = const TextInputType.numberWithOptions(decimal: true),
    this.labelText,
    this.marginBottom,
    this.marginLeft,
    this.marginRight,
    this.marginTop,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
    this.onEditingComplete,
    this.paddingBottom,
    this.paddingLeft,
    this.paddingRight,
    this.paddingTop,
    this.scale,
    this.suffixText,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    return DecorationPaddingWidget(
      borderColor: borderColor,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      child: TextFormField(
        controller: controller,
        cursorColor: globals.subtitleColor,
        decoration: inputDecoration ??
            InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5 * scale),
                borderSide: BorderSide.none,
              ),
              isDense: true,
              hintStyle: TextStyle(
                color: hintColor,
              ),
              hintText: hintText,
              suffixText: suffixText,
              suffixStyle: TextStyle(color: color),
            ),
        enabled: enabled,
        keyboardType: keyboardType,
        maxLines: maxLines,
        focusNode: keyboardNode,
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
        textInputAction: textInputAction,
      ),
      decoration: decoration,
      height: boxHeight,
      marginBottom: marginBottom,
      marginLeft: marginLeft,
      marginRight: marginRight,
      marginTop: marginTop,
      paddingBottom: paddingBottom,
      paddingLeft: paddingLeft,
      paddingRight: paddingRight,
      paddingTop: paddingTop,
      width: boxWidth,
    );
  }
}
