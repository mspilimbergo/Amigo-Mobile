import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:amigo_mobile/screens/chat/chat_list_screen.dart';
import 'package:amigo_mobile/screens/discover/discover_tag_view/discover_tag_view.dart';
import 'package:amigo_mobile/util/colors.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  final widgetOptions = [
    new ChatListPage(),
    new DiscoverTagView(),
    Text('Profile'),
  ];

  final titles = ["Chats", "What are your interests?", "Profile"];

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: selectedIndex != 0
        ? AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: new IconThemeData(color: Colors.red),
            title: Center(
                child: Text(
              "${titles[selectedIndex]}",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.red, fontSize: 30, fontWeight: FontWeight.w400),
            )),
          )
        : null,
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
