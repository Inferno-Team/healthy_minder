import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xfffb6340),
  colorScheme: const ColorScheme.light(
    background: Color(0xfffb6340),
    secondary: Color(0xfff8f9fa),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Color.fromRGBO(160, 164, 180, 1),
    ),
    bodyLarge: TextStyle(
      color: Color(0xff344767),
      fontSize: 31,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Color.fromRGBO(52, 71, 103, 1),
    ),
    displaySmall: TextStyle(
      fontSize: 10,
      color: Color.fromRGBO(103, 116, 142, 1),
    ),
    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: Color.fromRGBO(5, 17, 57, 1),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  // Define other dark theme properties here
);
