//
//  lib/screens/profile_screen.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/mixins/scale_mixin.dart';
import 'package:taaqeem/widgets/text_widgets.dart';

class ProfileScreen extends StatefulWidget {
  final String phone;

  ProfileScreen(this.phone);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Scale {
  @override
  Widget build(BuildContext context) {
    final double scale = Scale.getScale(context);
    return Scaffold(
      body: InkWell(
        child: Center(
          child: TheText.w600(
            color: globals.textColor,
            fontSize: 18,
            height: 2.11,
            text: widget.phone,
            textScaleFactor: scale,
          ),
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
