//
//  lib/widgets/padding_widget.dart
//
//  Created by Denis Bystruev on 29/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';

class PaddingWidget extends StatelessWidget with Scale {
  final Widget child;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final double scale;

  PaddingWidget({
    @required this.child,
    this.marginBottom = 5,
    this.marginLeft = 20,
    this.marginRight = 20,
    this.marginTop = 5,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final double scale = this.scale ?? Scale.getScale(context);
    return Padding(
      child: child,
      padding: EdgeInsets.fromLTRB(
        marginLeft * scale,
        marginTop * scale,
        marginRight * scale,
        marginBottom * scale,
      ),
    );
  }
}
