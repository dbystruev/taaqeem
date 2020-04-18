import 'package:flutter/material.dart';
import 'package:taaqeem/design/scale.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/widgets/text_widgets.dart';

void main() {
  runApp(
    Main(),
  );
}

class Main extends StatelessWidget with Scale {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final double scale = 1; // getScale(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: TheText.w600(
            colors: [null, globals.accentColor],
            texts: [
              'Protect your\n',
              'home &\nbusiness',
              ' from\nCOVID-19',
            ],
            fontSize: 38 * scale,
          ),
        ),
      ),
      title: 'Taqeem',
      theme: ThemeData(
        accentColor: globals.accentColor,
        primaryColor: globals.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
