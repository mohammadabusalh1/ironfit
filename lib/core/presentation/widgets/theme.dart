import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';

final ThemeData customThemeData = ThemeData.dark().copyWith(
  dialogBackgroundColor: Colors.grey[900],
  textTheme: TextTheme(
    bodyLarge:
        AppStyles.textCairo(16, Palette.mainAppColorWhite, FontWeight.w500),
    bodyMedium:
        AppStyles.textCairo(14, Palette.mainAppColorWhite, FontWeight.w500),
    headlineLarge:
        AppStyles.textCairo(24, Palette.mainAppColorWhite, FontWeight.w500),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFFBB02),
      foregroundColor: const Color(0xFF1C1503),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Palette.secondaryColor,
    alignLabelWithHint: true,
    labelStyle: AppStyles.textCairo(14, Palette.gray, FontWeight.w500),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.yellow, width: 2),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    hintStyle: AppStyles.textCairo(14, Palette.gray, FontWeight.w500),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Palette.white,
    ),
  ),
);
