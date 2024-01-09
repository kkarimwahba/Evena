import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Color.fromARGB(255, 23, 23, 23),
      secondary: Color.fromARGB(255, 23, 23, 23),
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Color.fromARGB(255, 23, 23, 23),
      primary: Colors.white,
      secondary: Colors.white,
    ));
