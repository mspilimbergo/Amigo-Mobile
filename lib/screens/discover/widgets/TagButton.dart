import 'package:flutter/material.dart';
import '../discover_channel_view/discover_channel_view.dart';

class TagButton extends StatelessWidget {
  final String tagID;
  final String name;
  final String photo;

  TagButton(this.tagID, this.name, this.photo);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Container(
          height: 125,
          width: 125,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(photo), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(12),
          ),
          child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DiscoverChannelView(
                              tagSelected: tagID,
                            )));
              },
              child: null)),
      Text("Basketball", style: TextStyle(fontSize: 16)),
    ]));
  }
}