//
//  lib/widgets/avatar_widget.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/models/user.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class AvatarWidget extends StatelessWidget {
  final double radius;
  final double scale;
  final User user;

  AvatarWidget(this.user, {this.radius = 25, this.scale});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = user?.name == null
        ? globals.inactiveColor
        : Theme.of(context).accentColor;
    final String initials = user?.name == null
        ? ''
        : user.name
            .split(' ')
            .map(
              (String word) => word[0].toUpperCase(),
            )
            .join()
            .substring(0, 2);
    final double scale = this.scale ?? Scale.getScale(context);
    return CircleAvatar(
      backgroundColor: backgroundColor,
      backgroundImage: user?.avatar == null ? null : NetworkImage(user.avatar),
      child: TheText.w600(
        color: Theme.of(context).primaryColor,
        fontSize: 0.4 * radius,
        text: initials,
        textScaleFactor: scale,
      ),
      radius: radius * scale,
    );
  }
}
