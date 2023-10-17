import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sundaku/src/Route.dart';
import 'package:sundaku/src/components/Question.dart';
import 'dart:async';

class Quis extends StatefulWidget {
  @override
  _KuisState createState() => _KuisState();
}

class _KuisState extends State<Quis> {
  List<Map<String, dynamic>> _selectedQuestions = [];
  int _currentQuestion = 0;
  int _score = 0;
  late Timer _timer;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  final Duration _totalTime = const Duration(seconds: 30);
  late Duration _timeLeft;
  bool _isSkipButtonDisabled = false;
  int _skipTimeLeft = 0;
  bool _answerSelected = false;

  @override
  void initState() {
    super.initState();
    _timeLeft = _totalTime;
    _selectedQuestions = _shuffleAndTakeQuestions();
    startTimer();
  }

  List<Map<String, dynamic>> _shuffleAndTakeQuestions() {
    List<Map<String, dynamic>> shuffledQuestions = [...questions];
    shuffledQuestions.shuffle(Random(DateTime.now().millisecondsSinceEpoch));
    return shuffledQuestions.take(5).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _nextQuestion(String selectedOption) async {
    if (!_answerSelected) {
      if (_selectedQuestions[_currentQuestion]['answer'] == selectedOption) {
        setState(() {
          _score++;
          _correctAnswers++;
          _selectedQuestions[_currentQuestion]['selectedOption'] =
              selectedOption;
        });
      } else {
        setState(() {
          _wrongAnswers++;
          _selectedQuestions[_currentQuestion]['selectedOption'] =
              selectedOption;
        });
      }
      _answerSelected = true;

      // Jeda selama 1 detik sebelum beralih ke pertanyaan berikutnya
      await Future.delayed(Duration(seconds: 1));

      if (_currentQuestion < _selectedQuestions.length - 1) {
        setState(() {
          _currentQuestion++;
          _answerSelected = false;
        });
        _resetTimer();
      } else {
        // End the quiz
        _showResult();
      }
    }
  }

  void _resetTimer() {
    _timer.cancel();
    _timeLeft = _totalTime;
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_timeLeft < oneSec) {
          timer.cancel();
          _nextQuestion('');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Time is up!'),
            duration: Duration(seconds: 2),
          ));
        } else {
          _timeLeft = _timeLeft - oneSec;
        }
      });
    });
  }

  void _showResult() {
    _timer.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hasil Kuis'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Skor Anda: $_score'),
              Text('Jawaban Benar: $_correctAnswers'),
              Text('Jawaban Salah: $_wrongAnswers'),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, homescreen);
                _resetQuiz();
              },
              child: Text('Selesai'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _resetQuiz(); // Panggil fungsi resetQuiz ketika tombol "Ulangi Kuis" ditekan
              },
              child: Text('Ulangi Kuis'),
            ),
          ],
        );
      },
    );
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestion = 0;
      _score = 0;
      _correctAnswers = 0;
      _wrongAnswers = 0;
      _answerSelected = false; // Reset status _answerSelected menjadi false
      _skipTimeLeft = 0;
      _isSkipButtonDisabled = false;
      _timeLeft = _totalTime;
      _selectedQuestions =
          _shuffleAndTakeQuestions(); // Acak dan ambil 5 pertanyaan lagi
      for (var question in _selectedQuestions) {
        question['selectedOption'] = null; // Reset pilihan jawaban menjadi null
      }
    });
    startTimer(); // Mulai timer lagi setelah mengulangi kuis
  }

  void _skipButtonDisabled() {
    setState(() {
      _isSkipButtonDisabled = true; // nonaktifkan tombol "Skip"
      _skipTimeLeft = 5; // set timer "Skip" ke 5 detik
    });

    // setiap 1 detik, kurangi timer "Skip" sebanyak 1 detik
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_skipTimeLeft > 0) {
          _skipTimeLeft--;
        } else {
          _isSkipButtonDisabled =
              false; // aktifkan kembali tombol "Skip" setelah 5 detik
          timer.cancel(); // hentikan timer setelah 5 detik
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white, // Atur warna latar belakang
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue
                    .withOpacity(0.3), // Atur warna latar belakang pertanyaan
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Question ${_currentQuestion + 1}: ${_selectedQuestions[_currentQuestion]['question']}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: _buildOptions(),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _isSkipButtonDisabled
                      ? null
                      : () {
                          _skipButtonDisabled();
                          _nextQuestion('');
                        },
                  style: ElevatedButton.styleFrom(
                    primary: _isSkipButtonDisabled ? Colors.grey : Colors.red,
                    onPrimary: Colors.white,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text('Skip'),
                      Visibility(
                        visible: _skipTimeLeft > 0,
                        child: Positioned(
                          right: 0,
                          child: Text(
                            '(${_skipTimeLeft}s)',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    'Time Left: ${_timeLeft.inSeconds} seconds',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions() {
    List<Widget> optionWidgets = [];
    List<String> options = _selectedQuestions[_currentQuestion]['options'];
    for (int i = 0; i < options.length; i++) {
      String option = options[i];
      bool isCorrectAnswer =
          option == _selectedQuestions[_currentQuestion]['answer'];
      bool isSelected =
          option == _selectedQuestions[_currentQuestion]['selectedOption'];

      optionWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _nextQuestion(option);
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            margin: EdgeInsets.only(bottom: 12.0),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(width: 2.0, color: Colors.blue),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              // Tentukan warna berdasarkan jawaban benar atau salah
              color: isSelected
                  ? (isSelected && isCorrectAnswer ? Colors.green : Colors.red)
                  : null,
            ),
            child: Text(
              option,
              style: TextStyle(
                  fontSize: 16.0,
                  color: isSelected ? Colors.white : Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    return ListView(
      shrinkWrap: true,
      children: optionWidgets,
    );
  }
}
