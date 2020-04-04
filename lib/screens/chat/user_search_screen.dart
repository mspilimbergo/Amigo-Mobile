import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json, base64, ascii;
import 'package:http/http.dart' as http;
import './chat_screen.dart';

class UserSearchDelegate extends SearchDelegate {
  final String display;
  final String sender;
  final storage = FlutterSecureStorage();
  final SERVER_URL = "http://10.0.2.2:3000";
// "https://amigo-269801.appspot.com"
  UserSearchDelegate({Key key, @required this.display, @required this.sender });

  Future<String> searchUsers(String query) async {
    var key = await storage.read(key: "jwt");
    var res = await http.get(
      "$SERVER_URL/api/user/search?query=$query",
      headers: { "x-access-token": key },
    );
    print(res.body);
    print(res.statusCode);
    if(res.statusCode == 200) return res.body;
    return res.body;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    return FutureBuilder<String>(
      future: searchUsers(query),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            var jsonSnap = json.decode(snapshot.data);
            print(jsonSnap);
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
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage("https://picsum.photos/seed/picsum/200"),
                      ),
                      title: Text(jsonSnap["users"][index]["display_name"]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(name: jsonSnap["users"][index]["display_name"], id: jsonSnap["users"][index]["user_id"], display: display, sender: sender, direct: true)
                          ),
                        );
                      },
                    );
                  },
                ),
              ];
            }
          }
          else if (snapshot.hasError) {
            return new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "There was an error fetching uses please try again!",
                  ),
                )
              ],
            );
          }
        } else {
          return new Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[200])
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
  );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes. 
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return FutureBuilder<String>(
      future: searchUsers(query),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            var jsonSnap = json.decode(snapshot.data);
            print(jsonSnap);
            if (jsonSnap["users"].length == 0) {
              return new Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    "No users match that search query."
                  )
                )
              );
            } else {
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
                            builder: (context) => ChatPage(name: jsonSnap["users"][index]["display_name"], id: jsonSnap["users"][index]["user_id"], display: display, sender: sender, direct: true)
                          ),
                        );
                      },
                    );
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
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[200])
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
  );
  }
}