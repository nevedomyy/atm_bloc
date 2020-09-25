import 'package:flutter/material.dart';

class Wave2 extends CustomClipper<Path>{
  final bool _top;

  Wave2(this._top);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, _top ? size.height*0.62*0.75 : size.height*0.62);
    path.quadraticBezierTo(size.width*0.8, _top ? size.height*0.6*0.75 : size.height*0.6, size.width*0.6, _top ? size.height*0.4*0.75 : size.height*0.4);
    path.quadraticBezierTo(size.width*0.2, -size.height*0.06, 0, _top ? size.height*0.42*0.75 : size.height*0.42);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
