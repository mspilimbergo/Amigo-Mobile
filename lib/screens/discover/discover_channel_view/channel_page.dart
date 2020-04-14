import 'package:amigo_mobile/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:amigo_mobile/util/colors.dart';

final storage = FlutterSecureStorage();
final SERVER_URL = "http://10.0.0.66:3000";


class ChannelPage extends StatefulWidget {
  final String channelId;
  final String name;
  final String description;
  final int memberCount;
  final String photo;
  String createdOn;

  ChannelPage({Key key, @required this.channelId, this.name, this.description, this.memberCount, this.photo, this.createdOn }) : super(key: key);

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  final storage = FlutterSecureStorage();
  final SERVER_URL = "https://amigo-269801.appspot.com";
  String userId;
  String displayName;
  final months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  String convertDate() {
    var joined = DateTime.parse(widget.createdOn);
    String str = months[joined.month - 1] + " " + joined.day.toString() + ", " + joined.year.toString();
    return str;
  }

  void addUserToChannel(String channelId) async {
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
    else {
      return null;
    }
  }

  Future<String> getUser() async {
    var key = await storage.read(key: "jwt");
    var res = await http.get(
    "$SERVER_URL/api/user",
      headers: { "x-access-token": key },
    );
    if(res.statusCode == 200) return res.body;
    return res.body.toString();
  }

  initUser() async {
    String jsonSnap = await getUser();
    var map = json.decode(jsonSnap);
    print(map);
    displayName = map["display_name"];
    userId = map["user_id"];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    initUser();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Channel Details', style: TextStyle(color: amigoRed)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: amigoRed)
      ,),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height / 6,      
                margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 7.0, // has the effect of softening the shadow
                      spreadRadius: 1.0, // has the effect of extending the shadow
                      offset: Offset(
                        2.0, // horizontal, move right 10
                        3.0, // vertical, move down 10
                      ),
                    )
                  ]
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: CircleAvatar(
                      // backgroundImage: user["photo"] != null ? NetworkImage(user["photo"]+ "?v=${Random().nextInt(10000000).toString()}") : AssetImage('assets/profile-placeholder.jpg'),
                      backgroundImage: AssetImage('assets/profile-placeholder.jpg'),
                      radius: MediaQuery.of(context).size.height / 20,
                      ),
                  ),
                  Container(
                      child: Flexible(
                            child: new Text(widget.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
                           ),
                        ),
                  )                             
                  ],)
              ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                // height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,                    
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 7.0, // has the effect of softening the shadow
                      spreadRadius: 1.0, // has the effect of extending the shadow
                      offset: Offset(
                        2.0, // horizontal, move right 10
                        3.0, // vertical, move down 10
                      ),
                    )
                  ]
                  ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.school,
                                  color: Colors.black54,
                                  size: 35.0,
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: 
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("School", style: TextStyle(fontSize: 12.0, color: Colors.black54)),                                  
                                    Text('University of Central Florida', style: TextStyle(fontSize: 16.0, color: Colors.black))
                                  ],
                                )
                              )
                            ])),
                    Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.access_time,
                                  color: Colors.black54,
                                  size: 35.0,
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: 
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Created On", style: TextStyle(fontSize: 12.0, color: Colors.black54)),                                  
                                    Text(convertDate(), style: TextStyle(fontSize: 16.0, color: Colors.black))
                                  ],
                                )
                              )
                            ])),
                                                Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.people_outline,
                                  color: Colors.black54,
                                  size: 35.0,
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20.0, bottom: 10),
                                child: 
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Member Count", style: TextStyle(fontSize: 12.0, color: Colors.black54)),                                  
                                    Text(widget.memberCount.toString(), style: TextStyle(fontSize: 16.0, color: Colors.black))
                                  ],
                                )
                              )
                            ])),   
                                                           
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(height: 1.0, thickness: 1.0, color: Colors.grey[300], indent: 25, endIndent: 25,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
                      // child: Text('Lorem Ipsum  Lorem Ipsum  Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum '),
                      child: Text(widget.description),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 20, 10),
                        child: RaisedButton(                         
                          color: amigoRed,
                          onPressed: () {
                            addUserToChannel(widget.channelId);
                            Navigator.pushAndRemoveUntil(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => ChatPage(name: widget.name, id: widget.channelId, display: displayName, sender: userId, direct: false)
                                ), 
                              ModalRoute.withName("ChannelView")
                            );                     
                          },
                          child: Text('Join Channel', style: TextStyle(color: Colors.white),), ),
                      ),
                    ),


                ],)
              ),
            ),            
          ],
        ),
      )
      );
  }
}