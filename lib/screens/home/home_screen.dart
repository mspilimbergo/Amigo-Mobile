import 'package:flutter/material.dart';
import '../chat/chat_screen.dart';
import '../../classes/tag_class.dart';

class HomePage extends StatelessWidget {
  final List<Tag> tags;
  HomePage({Key key, @required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
                'Chats',
                style: TextStyle(fontSize: 30.0)
              ),
          ),
            bottom: new TabBar(
              tabs: <Tab>[
              new Tab(text: "Groups"),
              new Tab(text: "Direct"),
            ]
          )
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: tags.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.map),
                  title: Text(tags[index].title),
                  subtitle: Text(tags[index].subtitle),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(),
                        settings: RouteSettings(
                          arguments: tags[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Text(
              'Direct'
            )
          ],
        ),
      )
    );
  }
}