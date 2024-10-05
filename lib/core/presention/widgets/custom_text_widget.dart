import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/style/palette.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomTextWidget({
    super.key,
    required this.text,
    this.color = Palette.white,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
