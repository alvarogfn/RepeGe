import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: Colors.black,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: Colors.black,
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
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black87,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.white,
    unselectedLabelColor: Colors.white54,
    indicatorColor: Colors.transparent,
    indicator: BoxDecoration(),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w900,
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    ),
  ),
);
