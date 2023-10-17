import 'package:flutter/material.dart';
import '../widget/navbar.dart';

class Tentang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar(),
      appBar: AppBar(
        title: Text('About'),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tentang aplikasi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Aplikasi Sundaku bertujuan untuk memberikan wahana belajar dalam berbentuk kamus bahasa sunda yg secara interaktif dan mudah untuk pada pakai. menggunakan antar muka yg menarik serta fitur-fitur khusus pengguna mempelajari kosakata, pribahasa, celoteh istilah serta aksara Sunda dengan praktis. Selain itu perangkat lunak ini pada lengkapi dengan fitur audio buat pengguna bertujuan buat menghafal kata istilah menggunakan bahasa sunda. ',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Version',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1.0.0',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Developed ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Attarik Ramanda',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'atarik.ramanda32@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
