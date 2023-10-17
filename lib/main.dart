import 'package:flutter/material.dart';
import 'package:sundaku/src/Route.dart' as route;
import 'package:sundaku/src/widget/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      onGenerateRoute: route.controller,
    );
  }
}
