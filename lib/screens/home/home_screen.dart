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
            leading: Icon(Icons.map),
            title: Text(tags[index].name),
            subtitle: Text(tags[index].tagId),
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