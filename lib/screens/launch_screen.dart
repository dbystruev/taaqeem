//
//  lib/screens/launch_screen.dart
//
//  Created by Denis Bystruev on 14/04/2020, updated 18/04/2020.
//

import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/text_widgets.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> with Scale {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    final double safeMargin = isHorizontal(context) ? 44 : 0;
    final double scale = getScale(context);
    navigateWithDelay(context, 3);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: TheText.w600(
                colors: [null, globals.accentColor],
                texts: [
                  'Protect your\n',
                  'home &\nbusiness',
                  ' from\nCOVID-19',
                ],
                fontSize: 38 * scale,
              ),
              left: 20 * scale + safeMargin,
              top: 40 * scale,
            ),
            Positioned(
              bottom: 30 * scale,
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                height: 58 * scale,
                width: 135 * scale,
              ),
              left: 20 * scale + safeMargin,
            ),
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0, -0.4),
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void navigateWithDelay(BuildContext context, int seconds) async {
    final duration = Duration(seconds: seconds);
    await Future.delayed(duration);
    if (tapped) return;
    tapped = true;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Text('Service Selection Screen'),
      ),
    );
  }
}
