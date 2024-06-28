import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idioms_and_phrases/ExplorePage/ExplorePage.dart';
import 'package:idioms_and_phrases/model/ScreensModes.dart';
import 'package:url_launcher/url_launcher.dart';

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
          cardExplore(context),

          Padding(padding: EdgeInsets.only(left: 16.0, top: 16.0), child: Text("Learn" ),),
          cardLearn(),

          Padding(padding: EdgeInsets.only(left: 16.0, top: 16.0), child: Text("Quiz" ),),
          cardQuiz(),

          cardSite()
        ],
      ),
    );
  }
}

Widget cardExplore(BuildContext context) {
  return Card(
    color: Colors.white,
    margin: EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: (){
            Navigator.push(
                context,
                CupertinoPageRoute(
                builder: (context) => SafeArea(child: const ExploreScreen(screenMode: ScreensModes.TOP10)), //Main()
            ));
          },
          leading: Icon(Icons.explore),
          title: Text('Explore Top-10'),
          subtitle: Text('This is a notification'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.explore),
          onTap: (){
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => SafeArea(child: const ExploreScreen(screenMode: ScreensModes.OTHERS)), //Main()
                ));
          },
          title: Text('Explore Others'),
          subtitle: Text('This is another notification'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.explore),
          onTap: (){
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => SafeArea(child: const ExploreScreen(screenMode: ScreensModes.ALL)), //Main()
                ));
          },
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

Widget cardSite() {
  return Card(
    color: Colors.white,
    margin: EdgeInsets.all(8),
    child: ListTile(
      leading: Icon(Icons.web),
      onTap: () {
        _launchUrl();
      },
      title: Text('Visit our website'),
      subtitle: FittedBox(child: Text('https://cerulean-gaufre-10fe12.netlify.app/#', maxLines: 1,)),
    ),
  );
}


Future<void> _launchUrl() async {
  final _url = Uri.parse("https://cerulean-gaufre-10fe12.netlify.app/#");
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}