import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../discover/discover_tag_view/discover_tag_view.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

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
  File _image;

  var txt = TextEditingController();

  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getLibraryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

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

  void checkTag(String tagname) {}

  void getTagName() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  iconTheme: new IconThemeData(color: Colors.red),
                  title: Center(
                      child: Text(
                    "Search tag",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  )),
                ),
                body: DiscoverTagView(
                  screen: 1,
                ))));
    setState(() {
      tagname = result['name'];
      tagid = result['tagID'];
    });
    txt.text = tagname;
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
                color: Colors.red, fontSize: 30, fontWeight: FontWeight.w400),
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
                    width: 300,
                    // color: Colors.grey,
                    child: Column(children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        backgroundImage: _image != null
                            ? FileImage(_image)
                            : AssetImage('assets/image-placeholder.jpg'),
                        radius: MediaQuery.of(context).size.height / 10,
                      ),
                      SizedBox(height: 15),
                      Container(
                          height: 30,
                          width: 210,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              OutlineButton(
                                  onPressed: () {
                                    getCameraImage();
                                  },
                                  child: Container(
                                    width: 65,
                                    child: Center(
                                      child: Text(
                                        "Camera",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid,
                                    width: 2,
                                  )),
                              OutlineButton(
                                  onPressed: () {
                                    getLibraryImage();
                                  },
                                  child: Container(
                                    width: 65,
                                    child: Center(
                                      child: Text(
                                        "Library",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid,
                                    width: 2,
                                  ))
                            ],
                          ))
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
                            readOnly: true,
                            controller: txt,
                            onTap: () {
                              getTagName();
                            },
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
                    SizedBox(height: 40),
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          Container(
                              height: 40,
                              width: 110,
                              child: OutlineButton(
                                  onPressed: () {
                                    Navigator.pop(context);
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
