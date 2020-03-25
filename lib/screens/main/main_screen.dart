import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../home/home_screen.dart';
import '../../classes/tag_class.dart';
import '../discover/discover_tag_view.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key} ) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  final widgetOptions = [
    new HomePage(
      tags: List.generate(
        20,
        (i) => Tag(
          'Tag $i',
          'This is the sample description for tag $i. We\'re leaving it a little long in order to get the best possible idea of how this will look.', null, null, null
        ),
      ),
    ),
    new DiscoverTagView(),
    Text('Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amigo'),
        centerTitle: true,
      ),
      body: Center( 
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('Discover')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile')),
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