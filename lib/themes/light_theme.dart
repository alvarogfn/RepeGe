import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: Colors.black87,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: Colors.black87,
        secondary: Colors.black,
        background: Colors.black,
      ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    errorMaxLines: 3,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      ),
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w700,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      height: 1.3,
      wordSpacing: 0.25,
    ),
  ),
);