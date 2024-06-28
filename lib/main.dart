import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idioms_and_phrases/OnBoardingPage/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

import 'HomePage/home.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization failed: $e");
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _getFirstStartPreference(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          bool firstStart = snapshot.data ?? true;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SafeArea(
              child: firstStart ? OnBoardingScreen() : OnBoardingScreen(), //HomeScreen(),
            ),
          );
        }
      },
    );
  }

  Future<bool> _getFirstStartPreference() async {
    bool? firstStart = prefs.getBool('first_start');
    if (firstStart == null) {
      await prefs.setBool('first_start', false);
      firstStart = false;
      return true;
    }
    return firstStart;
  }
}