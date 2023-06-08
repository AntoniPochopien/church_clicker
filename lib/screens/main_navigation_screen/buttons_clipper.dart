import 'package:flutter/material.dart';

class ButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // path.lineTo(15, 15);
    // path.lineTo(15, 50);
    path.addPolygon([
      Offset(10, 0),
      Offset(0, 10),
      Offset(0, size.height - 10),
      Offset(10, size.height),
      Offset(size.width - 10, size.height),
      Offset(size.width, size.height - 10),
      Offset(size.width, size.height - 10),
      Offset(size.width, 10),
      Offset(size.width - 10, 0),
    ], true);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
