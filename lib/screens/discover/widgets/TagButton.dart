import 'package:flutter/material.dart';
import '../discover_channel_view/discover_channel_view.dart';

class TagButton extends StatelessWidget {
  final String tagID;
  final String name;
  final String photo;
  final String createdOn;

  TagButton({this.tagID, this.name, this.photo, this.createdOn});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Container(
          height: 125,
          width: 125,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: photo != null ? NetworkImage(photo) : AssetImage('assets/placeholder.png'), fit: BoxFit.cover),
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
      Expanded(
        child: Text(name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
    ]));
  }
}
