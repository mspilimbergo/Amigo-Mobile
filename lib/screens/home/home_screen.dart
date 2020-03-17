import 'package:flutter/material.dart';
import '../chat/chat_screen.dart';
import '../../classes/tag_class.dart';

class HomePage extends StatelessWidget {
  final List<Tag> tags;
  HomePage({Key key, @required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tags[index].title),
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
    );
  }
}