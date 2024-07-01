import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idioms_and_phrases/ExplorePage/ExplorePage.dart';
import 'package:idioms_and_phrases/model/ScreensModes.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuHome extends StatefulWidget {
  const MenuHome({Key? key}) : super(key: key);

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardMenu(context),
        ],
      ),
    );
  }
}

Widget cardMenu(BuildContext context) {
  return Column(
    children: [
      Card(
        color: Colors.white,
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.explore),
              title: Text('Idioms And Phrases'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.share),
              onTap: () {
                //todo: Share App
              },
              title: Text('Share'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.star_rate),
              onTap: () {},
              title: Text('Rate'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              onTap: () {},
              title: Text('Settings'),
            ),
          ],
        ),
      ),

      cardSite()
    ],
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
      title: Text('Powercoders, 2024'),
      subtitle: Text('Visit the website'),
    ),
  );
}

Future<void> _launchUrl() async {
  final _url = Uri.parse("https://powercoders.org/");
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
