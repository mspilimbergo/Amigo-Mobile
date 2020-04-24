import 'package:flutter/material.dart';
import '../discover_channel_view/discover_channel_view.dart';

class TagButton extends StatelessWidget {
  final int screen; // 0 - DiscoverTagView  1 - Channel Create
  final String tagID;
  final String name;
  final String photo;
  final String createdOn;

  TagButton({this.screen, this.tagID, this.name, this.photo, this.createdOn});

  void mainTagButtonFunc(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: "ChannelView"),
            builder: (context) => DiscoverChannelView(
                  tagSelected: tagID,
                )));
  }

  void channelTagButtonFunc(BuildContext context) {
    var retval = {
      "name": name,
      "tagID": tagID,
    };
    Navigator.pop(context, retval);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Container(
          height: 117,
          width: 125,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: photo != null ? NetworkImage(photo) : AssetImage('assets/placeholder.png'), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(12),
          ),
          child: FlatButton(
              onPressed: () {
                print("Screen $screen");
                (screen == 0)
                    ? mainTagButtonFunc(context)
                    : channelTagButtonFunc(context);
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
