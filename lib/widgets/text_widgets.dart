//
//  lib/widgets/text_widgets.dart
//
//  Created by Denis Bystruev on 13/03/2020, updated 18/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/globals.dart' as globals;

class TheText extends StatelessWidget {
  final Color backgroundColor;
  final Color color;
  final List<Color> colors; // for optional rich text
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final List<TextStyle> styles;
  final String text;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
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
    this.styles,
    this.text,
    TextAlign textAlign,
    this.textDecoration,
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
    List<TextStyle> styles,
    String text,
    TextAlign textAlign,
    TextDecoration textDecoration,
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
        styles: styles,
        text: text,
        textAlign: textAlign,
        textDecoration: textDecoration,
        texts: texts,
        textScaleFactor: textScaleFactor,
      );

  factory TheText.normal({
    Color backgroundColor,
    Color color,
    List<Color> colors,
    double fontSize,
    double height,
    List<TextStyle> styles,
    String text,
    TextAlign textAlign,
    TextDecoration textDecoration,
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
        styles: styles,
        text: text,
        textAlign: textAlign,
        textDecoration: textDecoration,
        texts: texts,
        textScaleFactor: textScaleFactor,
      );

  factory TheText.w300({
    Color backgroundColor,
    Color color,
    List<Color> colors,
    double fontSize,
    double height,
    List<TextStyle> styles,
    String text,
    TextAlign textAlign,
    TextDecoration textDecoration,
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
        styles: styles,
        text: text,
        textAlign: textAlign,
        textDecoration: textDecoration,
        texts: texts,
        textScaleFactor: textScaleFactor,
      );

  factory TheText.w600({
    Color backgroundColor,
    Color color,
    List<Color> colors,
    double fontSize,
    double height,
    List<TextStyle> styles,
    String text,
    TextAlign textAlign,
    TextDecoration textDecoration,
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
        styles: styles,
        text: text,
        textAlign: textAlign,
        textDecoration: textDecoration,
        texts: texts,
        textScaleFactor: textScaleFactor,
      );

  factory TheText.w700({
    Color backgroundColor,
    Color color,
    List<Color> colors,
    double fontSize,
    double height,
    List<TextStyle> styles,
    String text,
    TextAlign textAlign,
    TextDecoration textDecoration,
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
        styles: styles,
        text: text,
        textAlign: textAlign,
        textDecoration: textDecoration,
        texts: texts,
        textScaleFactor: textScaleFactor,
      );

  @override
  Widget build(BuildContext context) {
    final int colorsLength = colors?.length ?? 0;
    final int stylesLength = styles?.length ?? 0;
    final TextStyle defaultStyle = TextStyle(
      backgroundColor: backgroundColor,
      color: color,
      decoration: textDecoration,
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
                        style: index < stylesLength
                            ? styles[index]
                            : index < colorsLength
                                ? TextStyle(color: colors[index])
                                : null,
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
