import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../model/ScreensModes.dart';
import '../util/constants.dart';
import 'package:http/http.dart' as http;


class QuizScreen extends StatefulWidget {
  final ScreensModes screenMode;


  const QuizScreen({super.key, required this.screenMode});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      'idiom': 'Break the ice',
      'options': [
        {'text': 'To start a conversation', 'correct': true},
        {'text': 'To be very cold'},
        {'text': 'To break something made of ice'},
        {'text': 'To create a problem'},
      ],
      'selectedOption': '',
      'correctAnswer': 'To start a conversation',
    },
    {
      'idiom': 'Hit the sack',
      'options': [
        {'text': 'To go to bed', 'correct': true},
        {'text': 'To hit a bag'},
        {'text': 'To start working'},
        {'text': 'To be very tired'},
      ],
      'selectedOption': '',
      'correctAnswer': 'To go to bed',
    },
    // Add more questions here
  ];


  var title = 'Top-10';
  int? focusedIndex;
  bool isIdiomFocused = false;
  var flutterTts = FlutterTts();

  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  var _newVoiceText = "Lesson One";


  int currentQuestionIndex = 0;
  int score = 0;
  bool showAnswer = false;


  List<dynamic> jsonData = [];

  Future<void> _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText.isNotEmpty) {
      await flutterTts.speak(_newVoiceText);
    }
  }


  @override
  void initState() {
    var mode = widget.screenMode;

    super.initState();
    downloadJSONFile(top10URL).then((data) {
      setState(() {
        title = mode.title;

        if(mode == ScreensModes.TOP10){
          jsonData = data["idioms"];
        } else {
          jsonData = data["others"];
        }
      });
    });

  }

    @override
    Widget build(BuildContext context) {
      var currentQuestion =  questions[currentQuestionIndex];

      return Scaffold(
        appBar: AppBar(
          title: Text('Idioms Quiz'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${currentQuestionIndex + 1} of ${questions.length}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                currentQuestion['idiom'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ...currentQuestion['options'].map<Widget>((option) {
                return ListTile(
                  title: Text(option['text']),
                  leading: Radio(
                    value: option['text'],
                    groupValue: currentQuestion['selectedOption'],
                    onChanged: (value) {
                      setState(() {
                        currentQuestion['selectedOption'] = value;
                      });
                    },
                  ),
                );
              }).toList(),
              SizedBox(height: 20),
              if (showAnswer)
                Text(
                  currentQuestion['selectedOption'] == currentQuestion['correctAnswer']
                      ? 'Correct!'
                      : 'Wrong! Correct answer: ${currentQuestion['correctAnswer']}',
                  style: TextStyle(
                    fontSize: 18,
                    color: currentQuestion['selectedOption'] == currentQuestion['correctAnswer']
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showAnswer = true;
                    if (currentQuestion['selectedOption'] == currentQuestion['correctAnswer']) {
                      score++;
                    }
                  });
                },
                child: Text('Check Answer'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (currentQuestionIndex < questions.length - 1) {
                    setState(() {
                      currentQuestionIndex++;
                      showAnswer = false;
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(score: score, total: questions.length),
                      ),
                    );
                  }
                },
                child: Text(currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Finish Quiz'),
              ),
            ],
          ),
        ),
      );
    }
}

Future<Map<String, dynamic>> downloadJSONFile(String downloadURL) async {
  try {
    // Fetch the JSON file from the URL
    final http.Response response = await http.get(Uri.parse(downloadURL));

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Convert response body from JSON string to Map
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      // If request was not successful, throw an error
      throw Exception('Failed to load JSON file');
    }
  } catch (e) {
    print('Error downloading JSON file: $e');
    return {};
  }
}

void copyToClipBoard(BuildContext context, String textToCopy)  async {
  if (textToCopy.isNotEmpty) {
    try {
      await Clipboard.setData(ClipboardData(text: textToCopy));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Copied to Clipboard!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to copy to clipboard.')),
      );
    }
  }
}



class ResultPage extends StatelessWidget {
  final int score;
  final int total;

  ResultPage({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Text(
          'You scored $score out of $total!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
