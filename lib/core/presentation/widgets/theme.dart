import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

final ThemeData customThemeData = ThemeData.dark().copyWith(
  dialogBackgroundColor: Colors.grey[900],
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Palette.white, fontSize: 16),
    bodyMedium: TextStyle(color: Palette.white, fontSize: 14),
    headlineLarge: TextStyle(
        color: Palette.white, fontWeight: FontWeight.bold, fontSize: 24),
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
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Palette.secondaryColor,
    labelStyle: TextStyle(color: Palette.white, fontSize: 14),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.yellow, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    hintStyle: TextStyle(color: Palette.gray, fontSize: 14),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Palette.white,
    ),
  ),
);
