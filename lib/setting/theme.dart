import 'package:flutter/animation.dart';

abstract class ThemeApp {}

class LightTheme extends ThemeApp {
  static const backgroundColor = Color.fromRGBO(255, 255, 251, 1);
  static const backgroundColorItem = Color.fromRGBO(255, 255, 255, 1);
  static const unselectedColorBottomNAV = Color.fromRGBO(210, 210, 190, 1);
  static const selectedColorBottomNAV = Color.fromRGBO(11, 54, 86, 1);
  static const foregroundColor = Color.fromRGBO(31, 45, 97, 1);
  static const foregroundColorTempGrey = Color.fromRGBO(78, 126, 161, 1);
  static const todayColor = Color.fromRGBO(144, 163, 176, 1);
  static const icon3Color = Color.fromRGBO(102, 134, 182, 1);
  static const textSearchColor = Color.fromRGBO(143, 156, 165, 1);
}

class DarkTheme extends ThemeApp {
  static const backgroundColor = Color.fromRGBO(8, 27, 37, 1);
  static const backgroundColorItem = Color.fromRGBO(21, 44, 57, 1);
  static const unselectedColorBottomNAV = Color.fromRGBO(44, 78, 102, 1);
  static const selectedColorBottomNAV = Color.fromRGBO(255, 115, 185, 1);
  static const foregroundColor = Color.fromRGBO(255, 255, 251, 1);
  static const foregroundColorTempGrey = Color.fromRGBO(78, 126, 161, 1);
  static const todayColor = Color.fromRGBO(100, 121, 136, 1);
  static const icon3Color = Color.fromRGBO(102, 134, 182, 1);
  static const textSearchColor = Color.fromRGBO(143, 156, 165, 1);
}
