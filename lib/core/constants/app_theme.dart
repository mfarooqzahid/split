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
        foregroundColor: kDarkTextColor,
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
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: kSecondaryTextColor,
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: kSecondaryTextColor,
          width: 0.5,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        // borderSide: const BorderSide(
        //   color: Colors.white30,
        //   width: 0.5,
        // ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: kErrorColor,
          width: 0.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: kErrorColor,
          width: 0.5,
        ),
      ),
      hintStyle: const TextStyle(
        color: kSecondaryTextColor,
        fontStyle: FontStyle.italic,
        fontSize: 14,
      ),
    ),
    // bottomSheetTheme: BottomSheetThemeData(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    // ),
    bottomSheetTheme: const BottomSheetThemeData(showDragHandle: true),

    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      enableFeedback: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.transparent,
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
    dividerTheme: DividerThemeData(
      color: kWhiteColor.withAlpha(30),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: kDarkTextColor,
        foregroundColor: kWhiteColor,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: kWhiteColor),
      bodyMedium: TextStyle(color: kSecondaryTextColor),
      titleLarge: TextStyle(color: kPrimaryColor),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: kSecondaryTextColor,
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.white30,
          width: 0.5,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        // borderSide: const BorderSide(
        //   color: Colors.white30,
        //   width: 0.5,
        // ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: kErrorColor,
          width: 0.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: kErrorColor,
          width: 0.5,
        ),
      ),
      hintStyle: const TextStyle(
        color: kSecondaryTextColor,
        fontStyle: FontStyle.italic,
        fontSize: 14,
      ),
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      enableFeedback: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.transparent,
    ),
    bottomSheetTheme: const BottomSheetThemeData(showDragHandle: true),
  );
}

const Color kPrimaryColor = Color(0xFF465EFD);
const Color kBackgroundColor = Color(0xFFF6F6F9);
const Color kErrorColor = Color(0xFFF11001);
const Color kWhiteColor = Color(0xFFFFFFFF);
const Color kDarkTextColor = Color(0xFF1C1C1C);
const Color kSecondaryTextColor = Color(0xFF848484);
