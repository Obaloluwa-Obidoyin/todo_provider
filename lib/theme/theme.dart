import 'package:flutter/material.dart';
import 'package:todo_provider/utils/utils.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      background: white, primary: lightwhite!, secondary: black),
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: background, primary: lightbg, secondary: white));
