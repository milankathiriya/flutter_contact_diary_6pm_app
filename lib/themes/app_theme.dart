import 'package:contact_diary_app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static bool isDark = false;

  static ThemeData lightTheme = ThemeData(
    textTheme: const TextTheme(
      headline2: TextStyle(
        color: Colors.red,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryColorLight,
      secondary: AppColors.secondaryColorLight,
      brightness: Brightness.light,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: AppColors.primaryColorDark,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      // primary: AppColors.primaryColorDark,
      secondary: AppColors.secondaryColorDark,
      brightness: Brightness.dark,
    ),
  );
}
