import 'package:atm/general/color.dart';
import 'package:flutter/material.dart';

class Wave1 extends CustomPainter{
  final bool _top;

  Wave1(this._top);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()..color = AppColor.violet.withOpacity(0.7);
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, _top ? size.height*0.5*0.75 : size.height*0.5);
    path.quadraticBezierTo(size.width*0.6, _top ? size.height*0.6*0.75 : size.height*0.6, size.width*0.4, _top ? size.height*0.4*0.75 : size.height*0.4);
    path.quadraticBezierTo(size.width*0.2, _top ? size.height*0.2*0.75 : size.height*0.2, 0, _top ? size.height*0.24*0.75 : size.height*0.24);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}