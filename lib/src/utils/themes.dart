import 'package:flutter/material.dart';

class NewsAppTheme {
  static TextTheme newsAppTextTheme = Typography.material2018(
    black: const TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    ),
  ).black;
}
