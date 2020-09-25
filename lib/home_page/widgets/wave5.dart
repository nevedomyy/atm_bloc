import 'package:atm/general/color.dart';
import 'package:flutter/material.dart';

class Wave5 extends CustomPainter{
  final bool _top;

  Wave5(this._top);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()..color = AppColor.violet.withOpacity(0.2);
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, _top ? size.height*0.6*0.75 : size.height*0.6);
    path.quadraticBezierTo(size.width*0.6, _top ? size.height*0.14*0.75 : size.height*0.14, size.width*0.35, _top ? size.height*0.3*0.75 : size.height*0.3);
    path.quadraticBezierTo(size.width*0.1, _top ? size.height*0.5*0.75 : size.height*0.5, 0, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}