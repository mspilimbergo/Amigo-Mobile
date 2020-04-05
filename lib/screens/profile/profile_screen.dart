import 'package:flutter/material.dart';
import 'package:amigo_mobile/util/colors.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPainter(),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height:  MediaQuery.of(context).size.height / 6,
                margin: new EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: MediaQuery.of(context).size.height / 7),
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
              ),
              Container(
                height:  MediaQuery.of(context).size.height / 2,
                margin: new EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 30.0),
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
            ],
          ),
        )
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