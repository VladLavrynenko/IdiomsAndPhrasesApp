import 'package:flutter/cupertino.dart';
import 'package:idioms_and_phrases/OnBoardingPage/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';

SharedPreferences? prefs = null;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // getPrefs();
    // var firstStart = prefs?.getBool('first_start');
    // print(firstStart.toString());

    // var firstScreen = null;
    // if (firstStart != null && firstStart) {
    //   firstScreen = HomeScreen();
    // } else
    //   firstScreen = OnBoardingScreen();

    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}

// Future<void> getPrefs() async {
//   prefs = await SharedPreferences.getInstance();
// }
