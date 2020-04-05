import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' show json;
import 'package:amigo_mobile/screens/chat/chat_list_screen.dart';
import 'package:amigo_mobile/screens/discover/discover_tag_view/discover_tag_view.dart';
import 'package:amigo_mobile/util/colors.dart';
import 'package:amigo_mobile/screens/profile/profile_screen.dart';

final storage = FlutterSecureStorage();
final SERVER_URL = "https://amigo-269801.appspot.com";

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  Map user;
  int selectedIndex = 0;
  final widgetOptions = [
    new ChatListPage(user: user),
    new DiscoverTagView(),
    new ProfilePage(user: user),
  ];

  final titles = ["Chats", "What are your interests?", "Profile"];

  @override
  void initState() {
    initUser();
    super.initState();
  }

  Future<String> getUser() async {
    var key = await storage.read(key: "jwt");
    var res = await http.get(
    "$SERVER_URL/api/user",
      headers: { "x-access-token": key },
    );
    if(res.statusCode == 200) return res.body;
    return res.body.toString();
  }

  initUser() async {
    String jsonSnap = await getUser();
    Map map = json.decode(jsonSnap);
    user = map;
  }

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
