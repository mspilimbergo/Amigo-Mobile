import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../chat/chat_screen.dart';
import '../../classes/tag_class.dart';

final storage = FlutterSecureStorage();
final SERVER_URL = "https://amigo-web-app.azurewebsites.net/";

class HomePage extends StatefulWidget {
    @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Object> channels;

  @override
  void initState() {
    super.initState();
  }

  Future<String> getChannels() async {
    var key = await storage.read(key: "jwt");
    var res = await http.get(
      "$SERVER_URL/api/channels",
        headers: { "x-access-token": key },
      );
      if(res.statusCode == 200) return res.body;
      return res.body.toString();
  }

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
            FutureBuilder<String>(
              future: getChannels(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                List<Widget> children;

                if (snapshot.hasData && snapshot.data != null) {
                  var jsonSnap = json.decode(snapshot.data);
                  print(channels);
                  children = <Widget>[
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: jsonSnap["channels"].length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage("https://picsum.photos/seed/picsum/200"),
                          ),
                          title: Text(jsonSnap["channels"][index]["name"]),
                          subtitle: Text(jsonSnap["channels"][index]["description"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(),
                                settings: RouteSettings(
                                  arguments: [
                                    jsonSnap["channels"][index]["name"],
                                    jsonSnap["channels"][index]["channel_id"]
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Text('An error occured grabbing your channels')
                  ];
                } else {
                  children = <Widget>[
                    Text(
                      'You don\'t have any channels yet'
                    )
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                );
              }
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