import 'package:flutter/material.dart';

import '../themes.dart';

class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.white),
      ),

      //Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              disabledForegroundColor: AppColors.greYest,
              disabledBackgroundColor: AppColors.greYest,
              // shadowColor: Colors.transparent,
              backgroundColor: AppColors.darkBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              textStyle: getMediumStyle(fontSize: 12, color: AppColors.black),
              foregroundColor: AppColors.black)),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.white,
          filled: true,
          errorStyle: getLightStyle().copyWith(color: AppColors.black),
          labelStyle: getMediumStyle(fontSize: 14.0, color: AppColors.black),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.red)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide:
                  const BorderSide(color: AppColors.darkBlue, width: 2)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide:
                  const BorderSide(color: AppColors.darkBlue, width: 2))),
    );
  }
}
