import 'package:flutter/material.dart';
import '../widget/navbar.dart';

class Aksara extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/aksara2.jpg',
    // Tambahkan path gambar lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar(),
      appBar: AppBar(
        title: Text('Aksara'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: imagePaths.map((imagePath) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill, // Mengisi seluruh ruang yang tersedia
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
