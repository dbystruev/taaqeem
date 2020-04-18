//
//  lib/widgets/text_widgets.dart
//
//  Created by Denis Bystruev on 13/03/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;

class TheText extends StatelessWidget {
  final Color color;
  final List<Color> colors; // for optional rich text
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final String text;
  final List<String> texts; // for optional rich text
  final TextAlign textAlign;

  TheText({
    Color color,
    this.colors,
    String fontFamily,
    this.fontSize,
    this.fontWeight,
    TextAlign textAlign,
    this.text,
    this.texts,
  })  : this.color = color ?? globals.textColor,
        this.fontFamily = fontFamily ?? globals.fontFamily,
        this.textAlign = textAlign ?? TextAlign.start;

  factory TheText.bold({
    Color color,
    List<Color> colors,
    double fontSize,
    String text,
    List<String> texts,
  }) =>
      TheText(
        color: color,
        colors: colors,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        text: text,
        texts: texts,
      );

  factory TheText.normal({
    Color color,
    List<Color> colors,
    double fontSize,
    String text,
    List<String> texts,
  }) =>
      TheText(
        color: color,
        colors: colors,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        text: text,
        texts: texts,
      );

  factory TheText.w300({
    Color color,
    List<Color> colors,
    double fontSize,
    String text,
    List<String> texts,
  }) =>
      TheText(
        color: color,
        colors: colors,
        fontSize: fontSize,
        fontWeight: FontWeight.w300,
        text: text,
        texts: texts,
      );

  factory TheText.w600({
    Color color,
    List<Color> colors,
    double fontSize,
    String text,
    List<String> texts,
  }) =>
      TheText(
        color: color,
        colors: colors,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        text: text,
        texts: texts,
      );

  @override
  Widget build(BuildContext context) {
    final int colorsLength = colors?.length ?? 0;
    final TextStyle defaultStyle = TextStyle(
      color: color,
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
    final bool isRichText = texts != null && 0 < texts.length;
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
          )
        : Text(
            text,
            style: defaultStyle,
            textAlign: textAlign,
          );
  }
}
