import 'dart:async';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import '../widget/navbar.dart';

class trans extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<trans> {
  final translator = GoogleTranslator();
  final FlutterTts flutterTts = FlutterTts();

  String _translatedText = '';
  String _fromLang = 'id';
  String _toLang = 'su';

  final Map<String, String> _languages = {
    'id': 'Indonesia',
    'su': 'Sunda',
  };

  Timer? _timer; // Tambahkan Timer

  Future<void> _translate(String text) async {
    if (text.isEmpty) {
      setState(() {
        _translatedText = '';
      });
      return;
    }
    var translation =
        await translator.translate(text, from: _fromLang, to: _toLang);
    setState(() {
      _translatedText = translation.text;
    });
  }

  void _resetTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(seconds: 1), () {
      _translate(_translatedText);
    });
  }

  void _copy() {
    Clipboard.setData(ClipboardData(text: _translatedText));
    Fluttertoast.showToast(
        msg: "Teks berhasil disalin!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _speak() async {
    await flutterTts.setLanguage(_toLang);
    await flutterTts.speak(_translatedText);
  }

  void _switchLang() {
    setState(() {
      var temp = _fromLang;
      _fromLang = _toLang;
      _toLang = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Translate'),
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Terjemahkan dari',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Tahoma', // menggunakan font Tahoma
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    DropdownButton(
                      value: _fromLang,
                      onChanged: (value) {
                        setState(() {
                          _fromLang = value.toString();
                          _resetTimer(); // Setiap kali bahasa diubah, reset Timer
                        });
                      },
                      items: _languages.entries
                          .map((e) => DropdownMenuItem(
                                value: e.key,
                                child: Text(
                                  e.value,
                                  style: TextStyle(
                                    color: Colors
                                        .white, // ubah warna text menjadi putih
                                    fontFamily:
                                        'Tahoma', // ubah font text menjadi Tahoma
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    IconButton(
                      onPressed: _switchLang,
                      icon: Icon(
                        Icons.swap_horiz,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    DropdownButton(
                      value: _toLang,
                      onChanged: (value) {
                        setState(() {
                          _toLang = value.toString();
                          _resetTimer(); // Setiap kali bahasa diubah, reset Timer
                        });
                      },
                      items: _languages.entries
                          .map((e) => DropdownMenuItem(
                                value: e.key,
                                child: Text(
                                  e.value,
                                  style: TextStyle(
                                    color: Colors
                                        .white, // ubah warna text menjadi putih
                                    fontFamily:
                                        'Tahoma', // ubah font text menjadi Tahoma
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Masukkan teks',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _resetTimer(); // Setiap kali ada perubahan teks masukan, reset Timer
                        _translatedText =
                            value; // Tampilkan teks masukan tanpa menunggu Timer
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1),
          Container(
            height: 200,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.cyanAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _translatedText.isNotEmpty
                          ? _translatedText
                          : "Hasilna didie",
                      style: TextStyle(
                          fontFamily: 'Tahoma',
                          fontSize: 16,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: _copy,
                icon: Icon(
                  Icons.copy,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: Icon(Icons.record_voice_over),
                onPressed: () {
                  _speak();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
