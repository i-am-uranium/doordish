import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'font_family.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme => _buildTheme();

  static ThemeData _buildTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      accentColor: AppColors.primaryColor,
      primaryColor: AppColors.primaryColor,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: AppColors.primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: AppColors.primaryColor,
        ),
        hintStyle: TextStyle(
          color: AppColors.secondaryText,
          fontSize: 12,
        ),
      ),
      errorColor: AppColors.error,
      cursorColor: AppColors.primaryColor,
      textTheme: _buildTextTheme(base.textTheme),
      iconTheme: base.iconTheme.copyWith(
        color: AppColors.primaryColor,
      ),
      primaryIconTheme: base.primaryIconTheme.copyWith(
        color: AppColors.primaryColor,
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.apply(
      fontFamily: FontFamily.helvetica,
      displayColor: AppColors.black,
      bodyColor: AppColors.black,
    );
  }
}
