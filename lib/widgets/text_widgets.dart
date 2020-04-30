//
//  lib/widgets/text_widgets.dart
//
//  Created by Denis Bystruev on 13/03/2020, updated 18/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;

class TheText extends StatelessWidget with Scale {
  final Color backgroundColor;
  final Color color;
  final List<Color> colors; // for optional rich text
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final String text;
  final TextAlign textAlign;
  final List<String> texts; // for optional rich text
  final double textScaleFactor;

  TheText({
    this.backgroundColor,
    Color color,
    this.colors,
    String fontFamily,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.text,
    TextAlign textAlign,
    this.texts,
    this.textScaleFactor,
  })  : this.color = color ?? globals.textColor,
        this.fontFamily = fontFamily ?? globals.fontFamily,
        this.textAlign = textAlign ?? TextAlign.start;

  factory TheText.bold({
    Color backgroundColor,
    Color color,
    List<Color> colors,
    double fontSize,
    double height,
    String text,
    TextAlign textAlign,
    List<String> texts,
    double textScaleFactor,
  }) =>
      TheText(
        backgroundColor: backgroundColor,
        color: color,
        colors: colors,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        height: height,
        text: text,
        textAlign: textAlign,
        texts: texts,
        textScaleFactor: textScaleFactor,
      );

  factory TheText.normal({
    Color backgroundColor,
    Color color,
    List<Color> colors,
    double fontSize,
    double height,
    String text,
    TextAlign textAlign,
    List<String> texts,
    double textScaleFactor,
  }) =>
      TheText(
        backgroundColor: backgroundColor,
        color: color,
        colors: colors,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        height: height,
        text: text,
        textAlign: textAlign,
        texts: texts,
        textScaleFactor: textScaleFactor,
      );

  factory TheText.w300({
    Color backgroundColor,
    Color color,
    List<Color> colors,
    double fontSize,
    double height,
    String text,
    TextAlign textAlign,
    List<String> texts,
    double textScaleFactor,
  }) =>
      TheText(
        backgroundColor: backgroundColor,
        color: color,
        colors: colors,
        fontSize: fontSize,
        fontWeight: FontWeight.w300,
        height: height,
        text: text,
        textAlign: textAlign,
        texts: texts,
        textScaleFactor: textScaleFactor,
      );

  factory TheText.w600({
    Color backgroundColor,
    Color color,
    List<Color> colors,
    double fontSize,
    double height,
    String text,
    TextAlign textAlign,
    List<String> texts,
    double textScaleFactor,
  }) =>
      TheText(
        backgroundColor: backgroundColor,
        color: color,
        colors: colors,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        height: height,
        text: text,
        textAlign: textAlign,
        texts: texts,
        textScaleFactor: textScaleFactor,
      );

  factory TheText.w700({
    Color backgroundColor,
    Color color,
    List<Color> colors,
    double fontSize,
    double height,
    String text,
    TextAlign textAlign,
    List<String> texts,
    double textScaleFactor,
  }) =>
      TheText(
        backgroundColor: backgroundColor,
        color: color,
        colors: colors,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        height: height,
        text: text,
        textAlign: textAlign,
        texts: texts,
        textScaleFactor: textScaleFactor,
      );

  @override
  Widget build(BuildContext context) {
    final int colorsLength = colors?.length ?? 0;
    final TextStyle defaultStyle = TextStyle(
      backgroundColor: backgroundColor,
      color: color,
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    );
    final bool isRichText = texts != null && 0 < texts.length;
    final double scale = textScaleFactor ?? Scale.getScale(context);
    return isRichText
        ? RichText(
            text: TextSpan(
              children: texts
                  .asMap()
                  .map(
                    (int index, String text) => MapEntry(
                      index,
                      TextSpan(
                        text: text,
                        style: TextStyle(
                          color: index < colorsLength ? colors[index] : null,
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
              style: defaultStyle,
            ),
            textAlign: textAlign,
            textScaleFactor: scale,
          )
        : Text(
            text,
            style: defaultStyle,
            textAlign: textAlign,
            textScaleFactor: scale,
          );
  }
}
