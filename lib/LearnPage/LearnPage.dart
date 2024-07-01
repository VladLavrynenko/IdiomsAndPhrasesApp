import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idioms_and_phrases/LearnPage/bloc/learn_bloc.dart';
import 'package:idioms_and_phrases/model/ScreensModes.dart';
import '../util/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import '../util/widgets/SoundIconButton.dart';

class LearnScreen extends StatefulWidget {
  final ScreensModes screenMode;
  const LearnScreen({super.key, required this.screenMode});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
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

  double _currentSliderValue = 100;

  var _newVoiceText = "Lesson One";

  void _changeFocus(int index, bool focusOnIdiom) {
    setState(() {
      if (focusedIndex == index && isIdiomFocused == focusOnIdiom) {
        // Reset focus if the same text is clicked again
        focusedIndex = null;
      } else {
        focusedIndex = index;
        isIdiomFocused = focusOnIdiom;
      }
    });
  }

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

        if (mode == ScreensModes.TOP10) {
          jsonData = data["idioms"];
        } else {
          if (mode == ScreensModes.TOP10) {
            jsonData = data["others"];
          } else {
            jsonData = data["idioms"] + data["others"];
          }
        }


        context.read<LearnBloc>().add(LoadedLearnIdioms(list: jsonData));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LearnBloc, LearnState>(
        builder: (BuildContext context, LearnState state) {

          if(state is LearnInitial){
            return Center(child: const CircularProgressIndicator(color: Colors.amberAccent,));
          }

          if(state is LearnLoaded){
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 48,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: CarouselSlider(
                    options: CarouselOptions(
                        height: double.infinity), // Take available height
                    items: state.list.map((i) {
                      int index = state.list.indexOf(i);
                      return Builder(
                        builder: (BuildContext context) {
                          bool isCurrentIdiomFocused =
                              focusedIndex == index && isIdiomFocused;
                          bool isCurrentExplanationFocused =
                              focusedIndex == index && !isIdiomFocused;

                          return Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 36),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 30.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),

                              child: SingleChildScrollView(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('№' + (index+1).toString(),
                                          style: TextStyle(fontSize: 36.0, color: Colors.black87)),
                                      TextButton(
                                        onLongPress: () {
                                          copyToClipBoard(context, i["idiom"]);
                                        },
                                        onPressed: () {
                                          _changeFocus(index, true);
                                        },
                                        child: AnimatedDefaultTextStyle(
                                          duration: const Duration(milliseconds: 200),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: isCurrentIdiomFocused
                                                  ? 36.0
                                                  : 18.0),
                                          child: Text(
                                              textAlign: TextAlign.center,
                                              '"${i["idiom"]}"'),
                                        ),
                                      ),
                                      SoundButton(
                                        onTap: () async {
                                          _newVoiceText = i["idiom"];
                                          _speak();
                                        },
                                      ),
                                      TextButton(
                                        onLongPress: () {
                                          copyToClipBoard(context, i["idiom"]);
                                        },
                                        onPressed: () {
                                          _changeFocus(index, false);
                                        },
                                        child: AnimatedDefaultTextStyle(
                                          duration: const Duration(milliseconds: 200),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: isCurrentExplanationFocused
                                                  ? 36.0
                                                  : 18.0),
                                          child: Text(
                                              textAlign: TextAlign.center,
                                              '${i["explanation"]}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),


                Slider(
                  value: _currentSliderValue,
                  max: 100,
                  divisions: 3,
                  label: _currentSliderValue.round().toString() + "%",
                  onChanged: (double value) {

                    context.read<LearnBloc>().add(ChangeModeLearnIdioms(list: jsonData));
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ],
            );
          } else {
            return Text('Something went wrong!');
          }
        },

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

void copyToClipBoard(BuildContext context, String textToCopy) async {
  if (textToCopy.isNotEmpty) {
    try {
      await Clipboard.setData(ClipboardData(text: textToCopy));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Copied to Clipboard!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to copy to clipboard.')),
      );
    }
  }
}


