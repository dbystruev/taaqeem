//
//  lib/widgets/back_widget.dart
//
//  Created by Denis Bystruev on 30/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/widgets/image_widget.dart';

class BackWidget extends StatelessWidget {
  final String text;

  BackWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(children: [ImageWidget('left')],);
  }
}