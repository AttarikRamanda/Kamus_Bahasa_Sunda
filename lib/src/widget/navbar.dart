import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sundaku/src/HomeScreen.dart';
import 'package:sundaku/src/Route.dart';

class navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('atarik'),
            accountEmail: Text('atarik.ramanda32@gmail.com'),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage('assets/images/ciamis.jpg'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('home'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route) => false,
                );
              }),
          ListTile(
            leading: Icon(Icons.quiz),
            title: Text('Quiz'),
            onTap: () {
              Navigator.pushNamed(context, '/quis');
            },
          ),
        ],
      ),
    );
  }
}
