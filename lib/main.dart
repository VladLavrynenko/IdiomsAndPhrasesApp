import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idioms_and_phrases/OnBoardingPage/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

import 'HomePage/home.dart';
// import 'firebase_options.dart';

SharedPreferences? prefs = null;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    // Handle Firebase initialization errors (e.g., log the error, show a user-friendly message)
    print("Firebase initialization failed: $e");
  }
  runApp(MyApp());
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

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: HomeScreen(), //OnBoardingScreen()),
    ));
  }
}

// Future<void> getPrefs() async {
//   prefs = await SharedPreferences.getInstance();
// }
