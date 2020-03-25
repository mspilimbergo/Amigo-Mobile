import 'package:flutter/material.dart';

class ChannelCard extends StatelessWidget {
  final String channelId;
  final String name;
  final String description;
  final int memberCount;
  final String photo;

  ChannelCard(this.channelId, this.name, this.description, this.memberCount, this.photo);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: Card(
            elevation: 0,
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Image.network(
                    "https://cdn2.iconfinder.com/data/icons/activity-5/50/1F3C0-basketball-512.png",
                    height: 75,
                    width: 75,
                  ),
                ),
                Container(
                    height: 100,
                    width: 180,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("$name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            "$description",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text("$memberCount members",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11)),
                        ])),
                OutlineButton(
                    onPressed: () {
                      print("Joining");
                    },
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text("Join"),
                    borderSide: BorderSide(
                      color: Colors.red,
                      style: BorderStyle.solid,
                      width: 2,
                    ))
              ],
            )));
  }
}

class TagButton extends StatelessWidget {
  final int tagID;

  TagButton(this.tagID);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
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
            // Container(
            //   child: RichText(text: TextSpan(children: )),
                
            //   )
            // ),
            // Container(
            //     child:
            //     //Add a customscrollview with a horizontal list and a vertical grid list with 2 columns
            //     )
          ]),
    );
  }
}
