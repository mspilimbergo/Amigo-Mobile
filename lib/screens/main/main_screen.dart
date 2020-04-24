import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:amigo_mobile/screens/chat/chat_list_screen.dart';
import 'package:amigo_mobile/screens/discover/discover_tag_view/discover_tag_view.dart';
import 'package:amigo_mobile/util/colors.dart';
import 'package:amigo_mobile/screens/profile/profile_screen.dart';


class MainPage extends StatefulWidget {
  final int initialIndex;

  MainPage({Key key, @required this.initialIndex}) : super(key: key);

  @override
  MainPageState createState() => MainPageState(initialIndex: initialIndex);
}

class MainPageState extends State<MainPage> {
  final int initialIndex;
  int selectedIndex;
  final widgetOptions = [
    new ChatListPage(),
    new DiscoverTagView(screen: 0),
    new ProfilePage(),
  ];

  MainPageState({Key key, @required this.initialIndex});

  @override 
  void initState() {
    super.initState();
    selectedIndex = initialIndex;
  }

  final titles = ["Chats", "Discover", "Profile"];

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: (selectedIndex == 1)
        ? AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: new IconThemeData(color: Colors.red),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${titles[selectedIndex]}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                  color: amigoRed, fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
