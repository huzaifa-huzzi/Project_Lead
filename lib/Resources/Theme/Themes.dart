import 'package:flutter/material.dart';
import 'package:project_x/Resources/Colors/Colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  colorScheme: ColorScheme.light(
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryColor,
    onSecondary: Colors.white,
    background: AppColors.backgroundColor,
    onBackground: AppColors.textColor,
    surface: AppColors.surfaceColor,
    onSurface: AppColors.textColor,
    error: AppColors.errorColor,
    onError: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: AppColors.textColor),
    bodyMedium: TextStyle(color: AppColors.textColor),
    labelLarge: TextStyle(color: AppColors.primaryColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.lightGrey),
    ),
  ),
);
