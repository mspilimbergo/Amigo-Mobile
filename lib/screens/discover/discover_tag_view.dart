import 'package:flutter/material.dart';
import '../discover/discover_channel_view/discover_channel_view.dart';

class TagButton extends StatelessWidget {
  final int tagID;

  TagButton(this.tagID);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
class DiscoverTagView extends StatefulWidget {
  @override
  _DiscoverTagViewState createState() => _DiscoverTagViewState();
}

class _DiscoverTagViewState extends State<DiscoverTagView> {
  String searchTag;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text("What are your interests?",
                    style: TextStyle(color: Colors.red, fontSize: 22))),
            Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                  ),
                )),
              Container(
                child: Center(
                child: RaisedButton(
                child: Text('Navigate to Channel View'),
                  onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiscoverChannelView(tagSelected: 'Sports',))
            );
          },
        )
      )
              )
          ]),
    );
  }
}
