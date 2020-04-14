import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:amigo_mobile/util/colors.dart';
import 'package:amigo_mobile/util/profile_background.dart';
import 'package:amigo_mobile/screens/auth/login_screen.dart';
import 'package:amigo_mobile/screens/profile/profile_edit_screen.dart';

final storage = FlutterSecureStorage();
// final SERVER_URL = "http://10.0.0.66:3000";
final SERVER_URL = "https://amigo-269801.appspot.com";


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map user;
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

  @override
  initState() {
    super.initState();
  }

  String getJoined() {
    var joined = DateTime.parse(user["created_on"]);
    String str = months[joined.month - 1] + " " + joined.day.toString() + ", " + joined.year.toString();
    return str;
  }

  String getLoggedIn() {
    var loggedIn = DateTime.parse(user["last_logged_in"]);
    String str = months[loggedIn.month - 1] + " " + loggedIn.day.toString() + ", " + loggedIn.year.toString();
    return str;
  }

  Future<String> getUser() async {
    print("Getting the user now");
    var key = await storage.read(key: "jwt");
    var res = await http.get(
    "$SERVER_URL/api/user",
      headers: { "x-access-token": key },
    );
    print("done");
    if(res.statusCode == 200) {
      print(res.body);
      var map = json.decode(res.body);
      user = map;
      return res.body;
    }
    print(res.body.toString());
    return res.body.toString();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ProfileBackgroundPainter(),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                  PopupMenuButton<String>(
                    onSelected: (String choice) {
                      switch (choice) {
                        case "Logout":
                          storage.delete(key: "jwt");
                          return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage()
                            ),
                          );
                        case "Edit Profile":
                          return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(user: user, school: null)
                            ),
                          );
                        default:
                      }
                    },
                    icon: Icon(Icons.more_vert, color: Colors.white, size: 30.0),
                    itemBuilder: (BuildContext context) {
                      return ["Edit Profile", "Logout"].map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ]
              )
            ),
            FutureBuilder<String>(
                future: getUser(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data != null) {
                      String joined = getJoined();
                      String loggedIn = getLoggedIn();
                      return Column(
                        children: <Widget>[
                          Container(
                            height:  MediaQuery.of(context).size.height / 4,
                            margin: new EdgeInsets.only(bottom: 10.0),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 20.0, // has the effect of softening the shadow
                                  spreadRadius: 2.0, // has the effect of extending the shadow
                                  offset: Offset(
                                    10.0, // horizontal, move right 10
                                    10.0, // vertical, move down 10
                                  ),
                                )
                              ],
                              borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget> [
                                Padding(
                                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                  child: CircleAvatar(
                                    backgroundImage: user["photo"] != null ? NetworkImage(user["photo"]+ "?v=${Random().nextInt(10000000).toString()}") : AssetImage('assets/profile-placeholder.jpg'),
                                    radius: MediaQuery.of(context).size.height / 16,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(user["first_name"] + " " + user["last_name"] , style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900)),
                                      Text("Member Since: $joined", style: new TextStyle(fontSize: 15.0))
                                    ]
                                  )
                                )
                              ]
                            )
                          ),
                          Container(
                            margin: new EdgeInsets.only(bottom: 10.0, top: 30.0),
                            padding: new EdgeInsets.all(20.0),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 20.0, // has the effect of softening the shadow
                                  spreadRadius: 5.0, // has the effect of extending the shadow
                                  offset: Offset(
                                    10.0, // horizontal, move right 10
                                    10.0, // vertical, move down 10
                                  ),
                                )
                              ],
                              borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.black54,
                                          size: 50.0,
                                        )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: 
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Display Name", style: TextStyle(fontSize: 12.0, color: Colors.black54)),
                                            Text(user["display_name"], style: TextStyle(fontSize: 18.0, color: Colors.black))
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: Icon(
                                          Icons.mail_outline,
                                          color: Colors.black54,
                                          size: 50.0,
                                        )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: 
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Email", style: TextStyle(fontSize: 12.0, color: Colors.black54)),
                                            Text(user["email"], style: TextStyle(fontSize: 18.0, color: Colors.black))
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: Icon(
                                          Icons.school,
                                          color: Colors.black54,
                                          size: 50.0,
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
                                            Text(user["school_name"], style: TextStyle(fontSize: 18.0, color: Colors.black))
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: Icon(
                                          Icons.chat,
                                          color: Colors.black54,
                                          size: 50.0,
                                        )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: 
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Channel Count", style: TextStyle(fontSize: 12.0, color: Colors.black54)),
                                            Text(user["channel_count"], style: TextStyle(fontSize: 18.0, color: Colors.black))
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Icon(
                                        Icons.phone_android,
                                        color: Colors.black54,
                                        size: 50.0,
                                      )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: 
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Last Logged In", style: TextStyle(fontSize: 12.0, color: Colors.black54)),
                                          Text(loggedIn, style: TextStyle(fontSize: 18.0, color: Colors.black))
                                        ],
                                      )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        color: Colors.white,
                        height: (MediaQuery.of(context).size.height / 4) * 3,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            "There was an error fetching your profile, please check your internet connection and try again in a second."
                          )
                        )
                      );
                    }
                  } else {
                    return Container(
                      color: Colors.transparent,
                      height: (MediaQuery.of(context).size.height / 4) * 3,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: new AlwaysStoppedAnimation<Color>(amigoRed)
                        )
                      )
                    );
                }
              }
            )
          ],
        ),
      )
    );
  }
}