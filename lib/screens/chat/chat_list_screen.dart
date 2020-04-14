import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:amigo_mobile/screens/chat/chat_screen.dart';
import 'package:amigo_mobile/screens/chat/user_search_delegate.dart';
import 'package:amigo_mobile/util/colors.dart';

final storage = FlutterSecureStorage();
final SERVER_URL = "http://10.0.2.2:3000";

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage>
  with SingleTickerProviderStateMixin {
  String displayName;
  String userId;
  String searchQuery;
  List<Object> channels;
  TabController _tabController;
  ScrollController _scrollController;
  TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    initUser();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
    _searchController = new TextEditingController();
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
      });
    });
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
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 180,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                            child: Text(
                              'Chats',
                              style: TextStyle(fontSize: 30.0, color: amigoRed, fontWeight: FontWeight.bold)
                            )
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 20.0, bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                showSearch(
                                  context: context,
                                  delegate: UserSearchDelegate(display: displayName, sender: userId)
                                );
                              },
                              child: Icon(
                                Icons.add_box,
                                size: 26.0,
                                color: amigoRed,
                              ),
                            )
                          )
                        ]
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Theme(
                          child: Container(
                            height: 40,
                              child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: 'Search for your chats',
                                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.0),
                                contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          data: Theme.of(context)
                                  .copyWith(primaryColor: Colors.grey,),
                        )
                      )
                    ]
                  )
                ),
                pinned: true,
                floating: true,
                forceElevated: boxIsScrolled,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                bottom: new TabBar(
                  controller: _tabController,
                  indicatorColor: amigoRed,
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
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data != null) {
                      var jsonSnap = json.decode(snapshot.data);
                      if (jsonSnap["channels"].length == 0) {
                        children = <Widget>[
                          new Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "You haven't joined any channels yet! Head over to the discover page to join some!"
                              )
                            )
                          )
                        ];
                      } else {
                        children = <Widget>[
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: jsonSnap["channels"].length,
                            itemBuilder: (context, index) {
                              var listItem;
                              searchQuery == null || jsonSnap["channels"][index]["name"].toLowerCase().contains(searchQuery.toLowerCase()) ?
                                listItem = ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: jsonSnap["channels"][index]["photo"] != null ? NetworkImage(jsonSnap["channels"][index]["photo"] + "?v=${Random().nextInt(10000000).toString()}") : AssetImage('assets/placeholder.png'),
                                  ),
                                  title: Text(jsonSnap["channels"][index]["name"]),
                                  subtitle: Text(jsonSnap["channels"][index]["description"]),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPage(name: jsonSnap["channels"][index]["name"], id: jsonSnap["channels"][index]["channel_id"], display: displayName, sender: userId, direct: false, photo: jsonSnap["channels"][index]["photo"])
                                      ),
                                    );
                                  },
                                )
                              : 
                                listItem = new Container();
                              return listItem;
                            },
                          ),
                        ];
                      }
                    } else if (snapshot.hasError) {
                      children = <Widget>[
                        new Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "There was an error fetching your channels, please check your internet connection and try again in a second."
                            )
                          )
                        )
                      ];
                    }
                  } else {
                    return new Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: new AlwaysStoppedAnimation<Color>(amigoRed)
                        )
                      )
                    );
                  }
                  return Container(
                    color: Colors.white,
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
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data != null) {
                      var jsonSnap = json.decode(snapshot.data);
                      if (jsonSnap["users"].length == 0) {
                        children = <Widget>[
                          new Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "You haven't sent any direct messages yet! Use the button above to send some!"
                              )
                            )
                          )
                        ];
                      } else {
                        children = <Widget>[
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: jsonSnap["users"].length,
                            itemBuilder: (context, index) {
                              var listItem;
                              searchQuery == null || jsonSnap["users"][index]["display_name"].toLowerCase().contains(searchQuery.toLowerCase()) ?
                                 listItem = ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: jsonSnap["users"][index]["photo"] != null ? NetworkImage(jsonSnap["users"][index]["photo"] + "?v=${Random().nextInt(10000000).toString()}") : AssetImage('assets/placeholder.png'),
                                  ),
                                  title: Text(jsonSnap["users"][index]["display_name"]),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPage(name: jsonSnap["users"][index]["display_name"], id: jsonSnap["users"][index]["user_id"], display: displayName, sender: userId, direct: true, photo: jsonSnap["users"][index]["photo"])
                                      ),
                                    );
                                  },
                                )
                              :
                                listItem = new Container();
                              return listItem;
                            },
                          ),
                        ];
                      }
                    }
                    else if (snapshot.hasError) {
                      children = <Widget>[
                        new Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "There was an error fetching your channels, please check your internet connection and try again in a second."
                            )
                          )
                        )
                      ];
                    }
                  } else {
                    return new Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: new AlwaysStoppedAnimation<Color>(amigoRed)
                        )
                      )
                    );
                  }
                  return Container(
                    color: Colors.white,
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
      )
    );
  }
}