import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:amigo_mobile/util/profile_background.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:amigo_mobile/util/colors.dart';
import 'package:image_picker/image_picker.dart';

final storage = FlutterSecureStorage();

class EditProfilePage extends StatefulWidget {
  final Map user;

  EditProfilePage({Key key, @required this.user}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState(user: user);
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Map user;
  File _image;

  _EditProfilePageState({Key key, @required this.user});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: ProfileBackgroundPainter(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget> [
                      Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold)
                      ),
                      FlatButton(
                        color: Colors.black54,
                        child: Text("Save", style: TextStyle(fontSize: 16.0, color: Colors.white),),
                        onPressed: () {}
                      )
                    ]
                  )
                ),
                Column(
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
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget> [
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: CircleAvatar(
                              backgroundImage: _image != null
                              ? FileImage(_image)
                              : (user["photo"] != null ? NetworkImage(user["photo"]) : AssetImage('assets/profile-placeholder.jpg')),
                              radius: MediaQuery.of(context).size.height / 16,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                FlatButton(
                                  color: amigoRed,
                                  child: Text("Take a picture", style: TextStyle(fontSize: 16.0, color: Colors.white)),
                                  onPressed: getCameraImage,
                                ),
                                FlatButton(
                                  color: amigoRed,
                                  child: Text("Upload a picture", style: TextStyle(fontSize: 16.0, color: Colors.white)),
                                  onPressed: getLibraryImage,
                                )
                              ]
                            )
                          ),
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
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Icon(
                                    Icons.account_circle,
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
                              mainAxisSize: MainAxisSize.max,
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
                              mainAxisSize: MainAxisSize.max,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          )
        )
      )
    );
  }
}