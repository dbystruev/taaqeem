import 'package:flutter/material.dart';

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
      home: Scaffold(
        body: Center(
          child: Text(
            'Protect your\nhome &\nbusiness from\nCOVID-19',
            style: TextStyle(
              fontFamily: 'Museo Sans Cyrl',
              fontSize: 38,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      title: 'Taqeem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
