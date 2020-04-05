import 'package:flutter/material.dart';
import 'package:amigo_mobile/util/profile_background.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:amigo_mobile/util/profile_background.dart';

final storage = FlutterSecureStorage();

class EditProfilePage extends StatefulWidget {
  final Map user;

  EditProfilePage({Key key, @required this.user}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState(user: user);
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Map user;

  _EditProfilePageState({Key key, @required this.user});

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
                  Text("placeholder")
                ]
              )
            ),
          ],
        )
      )
    );
  }
}