import 'package:flutter/material.dart';

class SizingConfig {
  static double screenHeight = 1;
  static double screenWidth = 1;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
  }

  static double height(double value) => screenHeight * value;
  static double width(double value) => screenWidth * value;
}
