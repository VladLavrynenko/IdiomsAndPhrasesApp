import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idioms_and_phrases/util/widgets/CardHome.dart';

import '../util/widgets/MenuHome.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  final numbers = <int>[1, 2, 6, 7];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: currentPageIndex == 0
          ? AppBar(
              automaticallyImplyLeading: false,
              title: Text('Idioms And Phrases'),
            )
          : currentPageIndex == 1
              ? AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    systemNavigationBarColor: Colors.purple, // Navigation bar
                    statusBarColor: Colors.purple, // Status bar
                  ),
                  automaticallyImplyLeading: false,
                  title: Text('Favourites'),
                )
              : currentPageIndex == 2
                  ? AppBar(
                      systemOverlayStyle: SystemUiOverlayStyle(
                        systemNavigationBarColor:
                            Colors.purple, // Navigation bar
                        statusBarColor: Colors.purple, // Status bar
                      ),
                      automaticallyImplyLeading: false,
                      title: Text('Menu'),
                    )
                  : null, // Hide the AppBar if no specific condition is met

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Menu',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        CardsHome(title: "title", onTap: () async {}),

        /// Favourites page
        Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: numbers.length,
            prototypeItem: Card(
              child: ListTile(
                leading: Icon(
                  Icons.volume_up,
                ),
                // leading:  SoundButton(onTap: () async {
                //   _newVoiceText = i["idiom"];
                //   _speak();
                // },),
                title: Text('Notification 1'),
                subtitle: Text('This is a notification'),
                trailing: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(
                    Icons.volume_up,
                  ),
                  // leading:  SoundButton(onTap: () async {
                  //   _newVoiceText = i["idiom"];
                  //   _speak();
                  // },),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                  trailing: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              );
            },
          ),
        ),

        /// Menu/Settings page
        MenuHome(),
      ][currentPageIndex],
    );
  }
}
