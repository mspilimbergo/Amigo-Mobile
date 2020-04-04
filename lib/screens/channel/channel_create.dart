import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();
final SERVER_URL = "http://10.0.2.2:3000";

class ChannelCreate extends StatefulWidget {
  @override
  _ChannelCreateState createState() => _ChannelCreateState();
}

class _ChannelCreateState extends State<ChannelCreate> {
  final double textboxheight = 30;

  String tagname;

  String tagid;

  String title;

  String description;

  String photo;

  void createChannel() async {
    var key = await storage.read(key: "jwt");
    var res = await http.post("$SERVER_URL/api/channels", headers: {
      "x-access-token": key
    }, body: {
      "tag_id": tagid,
      "name": title,
      "description": description,
      "school_id": "1"
    });

    if (res.statusCode == 200) {
      print(res.body.toString());
    } else
      print(res.body.toString());
  }

  void checkTag(String tagname) {
    // Search tag, return tag object.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.red),
          title: Text(
            'Create Channel',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.red,
                fontSize: 30,
                fontWeight: FontWeight.w400),
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          constraints: BoxConstraints.expand(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 200,
                    width: 150,
                    // color: Colors.grey,
                    child: Column(children: <Widget>[
                      Container(
                        width: 135,
                        height: 135,
                        decoration: BoxDecoration(
                            color: Colors.grey[400], shape: BoxShape.circle),
                        child: Icon(Icons.image,
                            size: 70, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 15),
                      Container(
                          height: 30,
                          width: 120,
                          child: OutlineButton(
                              onPressed: () {
                                print("Joining");
                              },
                              child: Text(
                                "Upload",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              borderSide: BorderSide(
                                color: Colors.red,
                                style: BorderStyle.solid,
                                width: 2,
                              )))
                    ])),
                SizedBox(height: 10),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  // color: Colors.blue,
                  child: Column(children: <Widget>[
                    Container(
                      child: Column(children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Tag",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )),
                        SizedBox(height: 5),
                        Container(
                          height: textboxheight,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          // color: Colors.red,
                          child: TextField(
                            maxLength: 5,
                            onChanged: (context) {
                              setState(() {
                                tagname = context;
                              });
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: "1223",
                            ),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(height: 25),
                    Container(
                      child: Column(children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Title",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )),
                        SizedBox(height: 5),
                        Container(
                          height: textboxheight,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          // color: Colors.red,
                          child: TextField(
                            maxLength: 64,
                            onChanged: (context) {
                              setState(() {
                                title = context;
                              });
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: "Enter Title",
                            ),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(height: 25),
                    Container(
                      child: Column(children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )),
                        SizedBox(height: 5),
                        Container(
                          height: textboxheight,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          // color: Colors.red,
                          child: TextField(
                            maxLength: 200,
                            onChanged: (context) {
                              setState(() {
                                description = context;
                              });
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: "Channel Description",
                            ),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(height: 50),
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          Container(
                              height: 40,
                              width: 110,
                              child: OutlineButton(
                                  onPressed: () {
                                    print("Joining");
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.red),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid,
                                    width: 2,
                                  ))),
                          SizedBox(width: 35),
                          Container(
                              height: 40,
                              width: 110,
                              child: OutlineButton(
                                  onPressed: () {
                                    print("Joining");
                                  },
                                  child: Text(
                                    "Create",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.green),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    style: BorderStyle.solid,
                                    width: 2,
                                  )))
                        ]))
                  ]),
                )),
              ]),
        ));
  }
}
