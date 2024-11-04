import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle textCairo(
      double fontSize, Color color, FontWeight fontWeight) {
    return GoogleFonts.cairo(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.6,
      letterSpacing: 0.5,
    );
  }

  static TextStyle textCairoButton(double fontSize) {
    return GoogleFonts.cairo(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    );
  }
}
