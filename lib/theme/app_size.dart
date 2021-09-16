import 'package:flutter/material.dart';

class AppSize {
  static double defaultPadding = 15.0;
  static double defaultStroke = 1.5;
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
