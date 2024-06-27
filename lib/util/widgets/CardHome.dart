import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardsHome extends StatefulWidget {
  final Future<void> Function() onTap;
  final String title;

  const CardsHome({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  State<CardsHome> createState() => _CardsHomeState();
}

class _CardsHomeState extends State<CardsHome> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          Padding(padding: EdgeInsets.only(left: 16.0, top: 16.0), child: Text("Explore")),
          cardExplore(),

          Padding(padding: EdgeInsets.only(left: 16.0, top: 16.0), child: Text("Learn" ),),
          cardLearn(),

          Padding(padding: EdgeInsets.only(left: 16.0, top: 16.0), child: Text("Quiz" ),),
          cardQuiz()
        ],
      ),
    );
  }
}

Widget cardExplore() {
  return Card(
    color: Colors.white,
    margin: EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.explore),
          // Uncomment and use your SoundButton here
          // leading: SoundButton(
          //   title: 'Sound',
          //   onTap: () async {
          //     _newVoiceText = i["idiom"];
          //     _speak();
          //   },
          // ),
          title: Text('Explore Top-10'),
          subtitle: Text('This is a notification'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.explore),
          // Uncomment and use your SoundButton here
          // leading: SoundButton(
          //   title: 'Sound',
          //   onTap: () async {
          //     _newVoiceText = i["idiom"];
          //     _speak();
          //   },
          // ),
          title: Text('Explore Others'),
          subtitle: Text('This is another notification'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.explore),
          // Uncomment and use your SoundButton here
          // leading: SoundButton(
          //   title: 'Sound',
          //   onTap: () async {
          //     _newVoiceText = i["idiom"];
          //     _speak();
          //   },
          // ),
          title: Text('Explore All'),
          subtitle: Text('This is yet another notification'),
        ),
      ],
    ),
  );
}

Widget cardLearn() {
  return Card(
    color: Colors.white,
    margin: EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.border_color),
          // Uncomment and use your SoundButton here
          // leading: SoundButton(
          //   title: 'Sound',
          //   onTap: () async {
          //     _newVoiceText = i["idiom"];
          //     _speak();
          //   },
          // ),
          title: Text('Learn Top-10'),
          subtitle: Text('This is a notification'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.border_color),
          // Uncomment and use your SoundButton here
          // leading: SoundButton(
          //   title: 'Sound',
          //   onTap: () async {
          //     _newVoiceText = i["idiom"];
          //     _speak();
          //   },
          // ),
          title: Text('Learn Others'),
          subtitle: Text('This is another notification'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.border_color),
          // Uncomment and use your SoundButton here
          // leading: SoundButton(
          //   title: 'Sound',
          //   onTap: () async {
          //     _newVoiceText = i["idiom"];
          //     _speak();
          //   },
          // ),
          title: Text('Learn All'),
          subtitle: Text('This is yet another notification'),
        ),
      ],
    ),
  );
}


Widget cardQuiz() {
  return Card(
    color: Colors.white,
    margin: EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.quiz),
          // Uncomment and use your SoundButton here
          // leading: SoundButton(
          //   title: 'Sound',
          //   onTap: () async {
          //     _newVoiceText = i["idiom"];
          //     _speak();
          //   },
          // ),
          title: Text('Notification 1'),
          subtitle: Text('This is a notification'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.quiz),
          // Uncomment and use your SoundButton here
          // leading: SoundButton(
          //   title: 'Sound',
          //   onTap: () async {
          //     _newVoiceText = i["idiom"];
          //     _speak();
          //   },
          // ),
          title: Text('Notification 2'),
          subtitle: Text('This is another notification'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.quiz),
          // Uncomment and use your SoundButton here
          // leading: SoundButton(
          //   title: 'Sound',
          //   onTap: () async {
          //     _newVoiceText = i["idiom"];
          //     _speak();
          //   },
          // ),
          title: Text('Notification 3'),
          subtitle: Text('This is yet another notification'),
        ),
      ],
    ),
  );
}