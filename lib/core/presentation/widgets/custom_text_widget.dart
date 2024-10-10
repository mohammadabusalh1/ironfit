import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

// CustomTextWidget is a reusable text widget that allows customization of text style.
class CustomTextWidget extends StatelessWidget {
  final String text; // The text to display.
  final Color color; // The color of the text.
  final double fontSize; // The size of the font.
  final FontWeight fontWeight; // The weight of the font (boldness).

  const CustomTextWidget({
    super.key,
    required this.text,
    this.color = Palette.white, // Default color is white.
    this.fontSize = 14.0, // Default font size is 14.0.
    this.fontWeight = FontWeight.normal, // Default font weight is normal.
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart, // Align text to the start.
      child: Text(
        text,
        style: TextStyle(
          color: color, // Set the text color.
          fontSize: fontSize, // Set the font size.
          fontWeight: fontWeight, // Set the font weight.
        ),
      ),
    );
  }
}
