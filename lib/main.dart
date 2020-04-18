import 'package:flutter/material.dart';
import 'package:taaqeem/globals.dart' as globals;
import 'package:taaqeem/screens/launch_screen.dart';

void main() {
  runApp(
    Main(),
  );
}

class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LaunchScreen(),
      title: 'Taqeem',
      theme: ThemeData(
        accentColor: globals.accentColor,
        primaryColor: globals.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
