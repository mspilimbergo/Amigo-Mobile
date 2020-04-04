import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert' show json, base64, ascii;
import '../home/home_screen.dart';
import '../discover/discover_tag_view/discover_tag_view.dart';

class MainPage extends StatefulWidget {
  MainPage(this.jwt, this.payload);
  
  factory MainPage.fromBase64(String jwt) =>
    MainPage(
      jwt,
      json.decode(
        ascii.decode(
          base64.decode(base64.normalize(jwt.split(".")[1]))
        )
      )
    );
  
  final String jwt;
  final Map<String, dynamic> payload;

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

  final titles = [
    "Chats",
    "What are your interests?",
    "Profile"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.red),
          title: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${titles[selectedIndex]}",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              ),
            ],
          )),
        ),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), title: Text('Chats')),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('Discover')),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity), title: Text('Profile')),
        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() { 
      selectedIndex = index;
    });
  }
}