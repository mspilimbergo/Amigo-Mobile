import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../chat/chat_screen.dart';

final storage = FlutterSecureStorage();
final SERVER_URL = "https://amigo-269801.appspot.com";

class HomePage extends StatefulWidget {
    @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
  with SingleTickerProviderStateMixin {
  String displayName;
  String userId;
  List<Object> channels;
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    initUser();
    getDirect();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  initUser() async {
    String jsonSnap = await getUser();
    var map = json.decode(jsonSnap);
    print(map);
    displayName = map["display_name"];
    userId = map["user_id"];
  }

  Future<String> getChannels() async {
    var key = await storage.read(key: "jwt");
    var res = await http.get(
      "$SERVER_URL/api/user/channels",
      headers: { "x-access-token": key },
    );
    if(res.statusCode == 200) return res.body;
    return res.body.toString();
  }

  Future<String> getDirect() async {
    var key = await storage.read(key: "jwt");
    var res = await http.get(
      "$SERVER_URL/api/directmessages/receivers",
      headers: { "x-access-token": key },
    );
    if(res.statusCode == 200) return res.body;
    return res.body.toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                    'Chats',
                    style: TextStyle(fontSize: 30.0, color: Colors.red[200])
                  ),
              ),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              backgroundColor: Colors.white,
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.add_box,
                      size: 26.0,
                      color: Colors.red[200],
                    ),
                  )
                )
              ],
              bottom: new TabBar(
                controller: _tabController,
                indicatorColor: Colors.red[200],
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: <Tab>[
                  new Tab(text: "Groups"),
                  new Tab(text: "Direct"),
                ]
              )
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget> [
            FutureBuilder<String>(
              future: getChannels(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                List<Widget> children;
                if (snapshot.hasData && snapshot.data != null) {
                  var jsonSnap = json.decode(snapshot.data);
                  children = <Widget>[
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
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
                                builder: (context) => ChatPage(name: jsonSnap["channels"][index]["name"], id: jsonSnap["channels"][index]["channel_id"], display: displayName, sender: userId, direct: false)
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
                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    )
                  ),
                );
              }
            ),
            FutureBuilder<String>(
              future: getDirect(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                List<Widget> children;
                if (snapshot.hasData && snapshot.data != null) {
                  var jsonSnap = json.decode(snapshot.data);
                  children = <Widget>[
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: jsonSnap["users"].length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage("https://picsum.photos/seed/picsum/200"),
                          ),
                          title: Text(jsonSnap["users"][index]["display_name"]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(name: jsonSnap["users"][index]["display_name"], id: jsonSnap["users"][index]["user_id"], display: displayName, sender: userId, direct: true)
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Text('An error occured grabbing your direct messages')
                  ];
                } else {
                  children = <Widget>[
                    Text(
                      'You don\'t have any direct messages yet.'
                    )
                  ];
                }
                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    )
                  ),
                );
              }
          )
        ]
      )
    ),
    );
  }
}