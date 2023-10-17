import 'dart:ui';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/ciamis.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                height: 300,
                margin:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.withOpacity(0.6),
                      Colors.purple.withOpacity(0.7),
                      Colors.red.withOpacity(0.9),
                    ],
                  ),
                  border: Border.all(color: Color.fromARGB(255, 167, 158, 158)),
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildIconButton(
                              context,
                              Icons.translate,
                              'translate',
                              '/translate',
                            ),
                            _buildIconButton(
                              context,
                              Icons.book_rounded,
                              'Kamus',
                              '/kamus',
                            ),
                            _buildIconButton(
                              context,
                              Icons.chrome_reader_mode_sharp,
                              'Aksara',
                              '/aksaras',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildIconButton(
                              context,
                              Icons.auto_stories,
                              'Peribahasa',
                              '/favorite',
                            ),
                            _buildIconButton(
                              context,
                              Icons.quiz_sharp,
                              'Game/quiz',
                              '/quis',
                            ),
                            _buildIconButton(
                              context,
                              Icons.bookmark_add,
                              'About',
                              '/tentang',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildIconButton(
  BuildContext context,
  IconData icon,
  String label,
  String route,
) {
  return GestureDetector(
    onTap: () {
      Navigator.pushReplacementNamed(context, route);
    },
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.black,
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
