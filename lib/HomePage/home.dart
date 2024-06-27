import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idioms_and_phrases/util/widgets/CardHome.dart';


class HomeScreen  extends StatefulWidget {
  const HomeScreen ({super.key});

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
      appBar: AppBar(
        title: Text('Idioms and Phrases'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/parrot.gif',
              width: 25,
              height: 25,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
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
        CardsHome(title: "title", onTap: () async {} ),


    /// Notifications page
         Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: numbers.length,
            prototypeItem: Card(
              child: ListTile(
                leading: Icon(Icons.volume_up,),
                // leading:  SoundButton(onTap: () async {
                //   _newVoiceText = i["idiom"];
                //   _speak();
                // },),
                title: Text('Notification 1'),
                subtitle: Text('This is a notification'),
                trailing: Icon(Icons.favorite, color: Colors.red,),
              ),
            ),
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.volume_up,),
                  // leading:  SoundButton(onTap: () async {
                  //   _newVoiceText = i["idiom"];
                  //   _speak();
                  // },),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                  trailing: Icon(Icons.favorite, color: Colors.red,),
                ),
              );
            },
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}
