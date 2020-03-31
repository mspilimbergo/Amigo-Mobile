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
  List<Object> channels;
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
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
                    style: TextStyle(fontSize: 30.0)
                  ),
              ),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: new TabBar(
                controller: _tabController,
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
                                builder: (context) => ChatScreen(name: jsonSnap["channels"][index]["name"], id: jsonSnap["channels"][index]["name"])
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
          Text(
            'Direct'
          )
        ]
      )
    ),
    );
  }
}