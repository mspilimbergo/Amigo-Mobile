import 'package:flutter/material.dart';
import 'package:amigo_mobile/util/colors.dart';

class ProfileBackgroundPainter extends CustomPainter {
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