import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color.fromRGBO(251, 99, 64, 1),
  colorScheme: const ColorScheme.light(
      background: Color.fromRGBO(251, 99, 64, 1),
      secondary: Color.fromRGBO(255, 255, 255, 1)),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Color.fromRGBO(52, 71, 103, 1),
      fontSize: 48,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(103, 116, 142, 1),
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Color.fromRGBO(251, 99, 64, 1),
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Color.fromRGBO(52, 71, 103, 1),
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Color.fromRGBO(103, 116, 142, 1),
    ),
    displaySmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Color.fromRGBO(52, 71, 103, 1)),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 17,
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromRGBO(251, 99, 64, 1),
  colorScheme: const ColorScheme.dark(
      background: Color.fromRGBO(251, 99, 64, 1),
      secondary: Color.fromRGBO(5, 17, 57, 1)),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Color.fromRGBO(52, 71, 103, 1),
      fontSize: 48,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(103, 116, 142, 1),
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Color.fromRGBO(251, 99, 64, 1),
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Color.fromRGBO(52, 71, 103, 1),
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Color.fromRGBO(103, 116, 142, 1),
    ),
    displaySmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Color.fromRGBO(52, 71, 103, 1)),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 17,
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
  ),
  // Define other dark theme properties here
);
