import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen  extends StatelessWidget {
  const HomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello Screen. Home." , style: TextStyle(color: Colors.deepPurple),),
    );
  }
}