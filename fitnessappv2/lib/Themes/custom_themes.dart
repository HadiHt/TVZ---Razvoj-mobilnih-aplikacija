
import 'package:flutter/material.dart';

class CustomThemes{
   static ThemeData _darkTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 255, 255, 255),
    secondaryHeaderColor: const Color.fromARGB(255, 122, 122, 122),
    scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color.fromARGB(255, 145, 96, 96),
    ),
    primarySwatch: Colors.orange,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(44, 44, 44, 1),
      unselectedItemColor: Color.fromARGB(255, 122, 122, 122),
      selectedItemColor: Color.fromARGB(255, 255, 255, 255),
    ),
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );

  static ThemeData _lightTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 22, 22, 22), // Reversed from dark theme
    secondaryHeaderColor: const Color.fromARGB(255, 153, 153, 153), // Reversed from dark theme
    scaffoldBackgroundColor: const Color.fromARGB(255, 203, 203, 203), // Reversed from dark theme
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color.fromARGB(255, 203, 203, 203), // Reversed from dark theme
    ),
    primarySwatch: Colors.orange,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(255, 203, 203, 203), // Reversed from dark theme
      unselectedItemColor: Color.fromARGB(255, 203, 203, 203), // Reversed from dark theme
      selectedItemColor: Color.fromARGB(255, 203, 203, 203), // Reversed from dark theme
    ),
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: const Color.fromARGB(255, 50, 50, 50), // Darker text color
      displayColor: const Color.fromARGB(255, 50, 50, 50), // Darker text color
    ),
  );
  static ThemeData getDarkTheme(){
    return _darkTheme;
  }
  static ThemeData getLightTheme(){
    return _lightTheme;
  }
}
