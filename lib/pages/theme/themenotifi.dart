import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Màu chữ cơ bản
          bodyMedium: TextStyle(color: Colors.white),
          displayLarge: TextStyle(color: Colors.white), // Màu chữ tiêu đề
        ),
        primarySwatch: Colors.blue,
      );

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Màu chữ cơ bản
          bodyMedium: TextStyle(color: Colors.black),
          displayLarge: TextStyle(color: Colors.black), // Màu chữ tiêu đề
        ),
        primarySwatch: Colors.blue,
      );
}
