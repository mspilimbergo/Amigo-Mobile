import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class ChannelCard extends StatefulWidget {
    final String channelId;
    final String name;
    final String description;
    final int memberCount;
    final String photo;
    final String createdOn;

    const ChannelCard ({Key key, @required this.channelId, @required this.name, @required this.description, @required this. memberCount, @required this.photo, @required this.createdOn }) : super(key:key);

    @override
    _ChannelCardState createState() => _ChannelCardState();
}

class _ChannelCardState extends State<ChannelCard> {

  final storage = FlutterSecureStorage();
  final SERVER_URL = "https://amigo-269801.appspot.com";

  void addUserToChannel(String channelId) async {
    print('in addUserToChannel');
    var key = await storage.read(key: "jwt");

    var res = await http.post(
      "$SERVER_URL/api/channels/join",
      headers: {"x-access-token": key},
      body: {
        "channel_id": channelId
      }
    );

    var responseMessage = jsonDecode(res.body);
    print(responseMessage);


    if (res.statusCode == 200) {
      print('User was added to channel');
      return jsonDecode(res.body);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 110,
        child: Card(
            // color: Colors.transparent,
            elevation: 1.5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Row(
                children: <Widget>[
                  Container(
                      height: 50,
                      width: 50,
                    child: Image.network(
                      "https://cdn2.iconfinder.com/data/icons/activity-5/50/1F3C0-basketball-512.png",
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10.0),
                      // width: 100,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                child: Text(widget.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                              )),
                                SizedBox(height: 2),
                            Flexible(
                              child: Container(
                                width: 180,
                                child: Text(
                                  widget.description,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(height: 3),
                            Text('Member Count: ' + widget.memberCount.toString(),
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey[500])),
                          ])),
                    //      Padding(
                    //       padding: const EdgeInsets.only(left: 25.0),
                    //       child: Text("Joined "),
                    // ), 
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 60.0),
                  //   child: IconButton(
                  //       onPressed: () => addUserToChannel(widget.channelId),
                  //       icon: Icon(Icons.add)
                  //       // child: Text("Join"),
                  //       // borderSide: BorderSide(
                  //       //   color: Colors.grey[400],
                  //       //   style: BorderStyle.solid,
                  //       //   width: 2,
                  //       // )
                  //       ),
                  // )
                ],
              ),
            )));
    }
  }