import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../util/constants.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  List<dynamic> jsonData = List.empty();

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
    var mode = "top10"; // "Favorites" "ALL"

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: [
        Text(
          "Here is Top-10",
          style: TextStyle(backgroundColor: Colors.amber, fontSize: 48),
        ),

        CarouselSlider(
          options: CarouselOptions(height: 400.0),
          items: jsonData.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.amber
                    ),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,

                          children: [
                            Text('text $i', style: TextStyle(fontSize: 36.0)),
                            Text('text $i', style: TextStyle(fontSize: 36.0)),
                          ],
                        )
                    )
                );
              },
            );
          }).toList(),
        )
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
    return Map();
  }
}
