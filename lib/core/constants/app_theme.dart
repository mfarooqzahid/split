import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Inter",
    brightness: Brightness.light,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kBackgroundColor,
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kErrorColor,
      surface: kWhiteColor,
      onPrimary: kWhiteColor,
      onSecondary: kWhiteColor,
      onSurface: kDarkTextColor,
    ),
    cardColor: kWhiteColor,
    dividerTheme: DividerThemeData(
      color: kSecondaryTextColor.withAlpha(30),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: kWhiteColor,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: kDarkTextColor), // Main dark text
      bodyMedium: TextStyle(color: kSecondaryTextColor), // Secondary/grey text
      titleLarge: TextStyle(color: kPrimaryColor), // Highlighted text
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
      fontFamily: "Inter",
      brightness: Brightness.light,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: const ColorScheme.light(
        primary: kPrimaryColor,
        secondary: kErrorColor,
        surface: kDarkTextColor,
        onPrimary: kWhiteColor,
        onSecondary: kWhiteColor,
        onSurface: kWhiteColor,
      ),
      cardColor: kDarkTextColor,
      dividerTheme: DividerThemeData(
        color: kWhiteColor.withAlpha(30),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: kDarkTextColor,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: kWhiteColor), // Main dark text
        bodyMedium: TextStyle(color: Colors.grey), // Secondary/grey text
        titleLarge: TextStyle(color: kPrimaryColor), // Highlighted text
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ));
}

const Color kPrimaryColor = Color(0xFF465EFD);
const Color kBackgroundColor = Color(0xFFF6F6F9);
const Color kErrorColor = Color(0xFFF11001);
const Color kWhiteColor = Color(0xFFFFFFFF);
const Color kDarkTextColor = Color(0xFF1C1C1C);
const Color kSecondaryTextColor = Color(0xFF848484);





// colors
// 0xFFFFFFFF for backgrounds for cards, on the main screen
// 0xFFF6F6F9 for scaffold background color
// 0xFF465EFD || 0xFF2B9D8F primary colors for buttons, highlited text
// 0xFF1C1C1C for dark text
// 0xFF848484 for light text
// ocFFF11001 for warning 