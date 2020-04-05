import 'package:flutter/material.dart';

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
      painter: BackgroundPainter(),
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
                              builder: (context) => EditProfilePage()
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
          ],
        )
      )
    );
  }
}