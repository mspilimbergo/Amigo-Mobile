import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:amigo_mobile/screens/home/home_screen.dart';
import 'package:amigo_mobile/screens/discover/discover_tag_view/discover_tag_view.dart';
import 'package:amigo_mobile/util/colors.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  final widgetOptions = [
    new HomePage(),
    new DiscoverTagView(),
    Text('Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: amigoRed,
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), title: Text('Chats')),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('Discover')),
            BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity), title: Text('Profile')),
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
      )
    );
  }

  void onItemTapped(int index) {
    setState(() { 
      selectedIndex = index;
    });
  }
}