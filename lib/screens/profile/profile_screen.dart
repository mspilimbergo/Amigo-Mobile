import 'package:flutter/material.dart';
import 'package:amigo_mobile/util/colors.dart';

class ProfilePage extends StatelessWidget {
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
            Container(
              height:  MediaQuery.of(context).size.height / 4,
              margin: new EdgeInsets.only(bottom: 10.0, top: MediaQuery.of(context).size.height / 7),
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
                    padding: EdgeInsets.only(left: 10.0, right: 20.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("https://picsum.photos/seed/picsum/200"),
                      radius: MediaQuery.of(context).size.height / 16,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Full Name", style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900)),
                      Text("Member Since: December 5th, 2020", style: new TextStyle(fontSize: 15.0))
                    ]
                  )
                ]
              )
            ),
            Container(
              height:  MediaQuery.of(context).size.height / 2,
              margin: new EdgeInsets.only(bottom: 10.0, top: 30.0),
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
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 14.0,
                child: new FlatButton(
                  color: amigoRed,
                  textColor: Colors.white,
                  onPressed: () {},
                  child: Text("Edit", style: TextStyle(fontSize: 16.0))
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 14.0,
                child: new FlatButton(
                  color: amigoRed,
                  textColor: Colors.white,
                  onPressed: () {},
                  child: Text("Edit", style: TextStyle(fontSize: 16.0))
                )
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