import 'package:flutter/material.dart';

TextStyle? getTextStyle(
    {required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required String fontFamily}) {
  return TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily);
}
