import 'package:flutter/material.dart';

class MyTheme {
  static const Color primary = Color.fromRGBO(43, 123, 202, 1);
  static const Color secundary = Colors.white;

  static final ThemeData myTheme = ThemeData(
      primaryColor: primary,
      brightness: Brightness.dark,
      fontFamily: 'roboto',
      scaffoldBackgroundColor: secundary,
      appBarTheme: const AppBarTheme(
          color: primary,
          elevation: 15,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primary)),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: primary));
}
