import 'package:atm/general/adapt.dart';
import 'package:atm/general/color.dart';
import 'package:flutter/material.dart';

class AppTextStyle{
  static final TextStyle logo = TextStyle(color: Colors.white, fontSize: Adapt.px(20.0), fontFamily: 'SFProText');
  static final TextStyle textWhite = TextStyle(color: Colors.white, fontSize: Adapt.px(16.0), fontFamily: 'SFProText');
  static final TextStyle textGrey = TextStyle(color: AppColor.grey, fontSize: Adapt.px(13.0), fontFamily: 'SFProText');
  static final TextStyle textBlue = TextStyle(color: AppColor.blue, fontSize: Adapt.px(14.0), fontFamily: 'SFProText');
  static final TextStyle notAllow = TextStyle(color: AppColor.pink, fontSize: Adapt.px(18.0), fontFamily: 'SFProText');
  static final TextStyle input = TextStyle(color: Colors.white, fontSize: Adapt.px(30.0), fontFamily: 'SFProText');
}