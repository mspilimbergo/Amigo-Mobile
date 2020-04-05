import 'package:flutter/material.dart';
import 'package:amigo_mobile/util/colors.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                    onSelected: null,
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
                      backgroundImage: NetworkImage("https://picsum.photos/seed/picsum/200"),
                      radius: MediaQuery.of(context).size.height / 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Full Name", style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900)),
                        Text("Member Since: December 5th, 2020", style: new TextStyle(fontSize: 15.0))
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
                              Text("Display Name", style: TextStyle(fontSize: 18.0, color: Colors.black))
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
                              Text("Email", style: TextStyle(fontSize: 18.0, color: Colors.black))
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
                              Text("School", style: TextStyle(fontSize: 18.0, color: Colors.black))
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
                              Text("Chat Count", style: TextStyle(fontSize: 12.0, color: Colors.black54)),
                              Text("7", style: TextStyle(fontSize: 18.0, color: Colors.black))
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
                            Icons.chat_bubble_outline,
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
                              Text("Message Count", style: TextStyle(fontSize: 12.0, color: Colors.black54)),
                              Text("1000", style: TextStyle(fontSize: 18.0, color: Colors.black))
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
                            Text("February 6th, 2000", style: TextStyle(fontSize: 18.0, color: Colors.black))
                          ],
                        )
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0.0, 0.0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path profileBackground = Path();
    profileBackground.addRect(Rect.fromLTRB(0.0, 0.0, width, height / 4));
    paint.color = amigoRed;
    canvas.drawPath(profileBackground, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}