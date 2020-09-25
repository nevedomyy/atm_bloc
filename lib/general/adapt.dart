import 'package:flutter/material.dart';

class Adapt {
  static MediaQueryData _mediaQuery;
  static double _height;
  static double _width;

  static initContext(BuildContext context) {
    if (_mediaQuery == null) {
      _mediaQuery = MediaQuery.of(context);
      _height = _mediaQuery.size.height;
      _width = _mediaQuery.size.width;
    }
  }

  static px(number) => (_width > _height ? _width : _height)*number/812;

  static get height => _width > _height ? _width : _height;
}