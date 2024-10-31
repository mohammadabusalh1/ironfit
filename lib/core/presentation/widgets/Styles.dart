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
      shadows: [
        Shadow(
          color: Color(0xFF1B1B1B),
          offset: Offset(4.0, 4.0),
          blurRadius: 4.0,
        ),
      ],
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
