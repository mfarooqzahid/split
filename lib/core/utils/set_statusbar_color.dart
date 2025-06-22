import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setStatusBarColor(ThemeMode themeMode) {
  SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,
  ));
}
// void setStatusBarColor(Color? color, [Brightness brightness = Brightness.dark]) {
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: color ?? Colors.transparent,
//     statusBarIconBrightness: brightness,
//   ));
// }
