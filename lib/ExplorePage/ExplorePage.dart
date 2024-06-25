import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:idioms_and_phrases/util/enums.dart';
import '../util/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../util/widgets/SoundIconButton.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int? focusedIndex;
  bool isIdiomFocused = false;

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

  @override
  void initState() {
    super.initState();
    downloadJSONFile(top10URL).then((data) {
      setState(() {
        jsonData = data["idioms"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Here is Top-10",
          style: TextStyle(color: Colors.blueAccent, backgroundColor: Colors.amber, fontSize: 48),
        ),
        Expanded(
          child: CarouselSlider(
            options: CarouselOptions(height: double.infinity), // Take available height
            items: jsonData.map((i) {
              int index = jsonData.indexOf(i);
              return Builder(
                builder: (BuildContext context) {
                  bool isCurrentIdiomFocused = focusedIndex == index && isIdiomFocused;
                  bool isCurrentExplanationFocused = focusedIndex == index && !isIdiomFocused;

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                _changeFocus(index, true);
                              },
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 200),
                                style: TextStyle(fontSize: isCurrentIdiomFocused ? 36.0 : 18.0),
                                child: Text(textAlign: TextAlign.center, '${i["idiom"]}'),
                              ),
                            ),


                            IconButtonExample(),

                            TextButton(
                              onPressed: () {
                                _changeFocus(index, false);
                              },
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 200),
                                style: TextStyle(fontSize: isCurrentExplanationFocused ? 36.0 : 18.0),
                                child: Text(textAlign: TextAlign.center, '${i["explanation"]}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
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
