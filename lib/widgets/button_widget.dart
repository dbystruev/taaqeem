//
//  lib/widgets/button_widget.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/text_widgets.dart';

class ButtonWidget extends StatelessWidget with Scale {
  final Color borderColor;
  final double borderWidth;
  final Color buttonColor;
  final double fontSize;
  final double imageHeight;
  final String imageName;
  final double imageWidth;
  final double height;
  final MainAxisAlignment mainAxisAlignment;
  final VoidCallback onPressed;
  final double scale;
  final String text;
  final Color textColor;
  final TextDecoration textDecoration;
  final double width;

  ButtonWidget(
    this.text, {
    this.borderColor,
    this.borderWidth = 2,
    this.buttonColor = globals.accentColor,
    this.fontSize = 15,
    this.height = 52,
    this.imageHeight = 18,
    this.imageName,
    this.imageWidth = 18,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.onPressed,
    this.scale,
    this.textColor = globals.primaryColor,
    this.textDecoration,
    this.width = 300,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    final TheText textWidget = TheText.w600(
      color: textColor,
      fontSize: fontSize,
      height: 1.6,
      text: text,
      textDecoration: textDecoration,
      textScaleFactor: scale,
    );
    return Row(
      children: <Widget>[
        SizedBox(
          child: FlatButton(
            color: buttonColor,
            child: imageName == null
                ? textWidget
                : Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/$imageName.png',
                        height: imageHeight * scale,
                        width: imageWidth * scale,
                      ),
                      SizedBox(width: 8 * scale),
                      textWidget,
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
            onPressed: onPressed,
            shape: borderColor == null
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5 * scale),
                  )
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5 * scale),
                    side: BorderSide(
                      color: borderColor,
                      width: borderWidth * scale,
                    ),
                  ),
            textColor: textColor,
          ),
          height: height * scale,
          width: width * scale,
        ),
      ],
      mainAxisAlignment: mainAxisAlignment,
    );
  }
}