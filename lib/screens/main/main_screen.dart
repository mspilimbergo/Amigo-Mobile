import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert' show json, base64, ascii;
import '../home/home_screen.dart';
import '../../classes/tag_class.dart';

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
    new HomePage(
      // tags: List.generate(
      //   20,
      //   (i) => Tag(
      //     'Tag $i',
      //     'This is the sample description for tag $i. We\'re leaving it a little long in order to get the best possible idea of how this will look.'
      //   ),
      // ),
    ),
    Text('Discover'),
    Text('Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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