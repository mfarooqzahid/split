import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setStatusBarColor(BuildContext context, ThemeMode themeMode) {
  // final brightness = MediaQuery.of(context).platformBrightness;
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
