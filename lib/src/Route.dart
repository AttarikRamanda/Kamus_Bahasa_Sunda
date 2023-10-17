import 'package:flutter/material.dart';
import 'package:sundaku/src/HomeScreen.dart';
import 'package:sundaku/src/View/Quis/quis.dart';
import 'package:sundaku/src/View/aksara.dart';
import 'package:sundaku/src/View/kamusna.dart';
import 'package:sundaku/src/View/MainQuis.dart';
import 'package:sundaku/src/View/tentang.dart';
import 'package:sundaku/src/View/trans.dart';
import 'package:sundaku/src/View/kamus.dart';
import 'package:sundaku/src/widget/splash_screen.dart';

const String homescreen = 'home';
const String kamus = 'kamusna';
const String translate = 'translate';
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homescreen:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case '/favorite':
      return MaterialPageRoute(builder: (context) => kamusna());
    // case '/trans':
    //   return MaterialPageRoute(builder: (context) => translatesunda());
    case '/translate':
      return MaterialPageRoute(builder: (context) => trans());
    case '/kamus':
      return MaterialPageRoute(builder: (context) => Kamus());
    case '/tentang':
      return MaterialPageRoute(builder: (context) => Tentang());
    case '/aksaras':
      return MaterialPageRoute(builder: (context) => Aksara());
    case '/quis':
      return MaterialPageRoute(builder: (context) => MainQuis());
    case '/quismulai':
      return MaterialPageRoute(builder: (context) => Quis());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ));
  }
}
