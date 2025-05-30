import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
    colorScheme: ColorScheme(
  brightness: Brightness.light,
  primary: Colors.grey.shade500,
  onPrimary: Colors.white,
  secondary: Colors.grey.shade400,
  onSecondary: Colors.grey.shade100,
  error: Colors.red,
  onError: Colors.red.shade200,
  surface: Colors.grey.shade200,
  onSurface: Colors.black,
));
