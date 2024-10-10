import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

// Reusable StatisticsCard Widget
class StatisticsCard extends StatelessWidget {
  final String cardSubTitle;
  final String cardTitle;
  final double width;
  final double height;

  const StatisticsCard({
    Key? key,
    required this.cardSubTitle,
    required this.cardTitle,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: _buildBoxDecoration(),
      child: _buildCardContent(),
    );
  }

  // Builds the decoration for the card
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Palette.secondaryColor,
      borderRadius: BorderRadius.circular(10),
    );
  }

  // Builds the content of the card
  Widget _buildCardContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCardText(cardSubTitle, 16, FontWeight.w600, Colors.white),
        _buildCardText(cardTitle, 14, FontWeight.w800, Palette.mainAppColor),
      ],
    );
  }

  // Creates a styled text widget for the card
  Widget _buildCardText(
      String text, double fontSize, FontWeight fontWeight, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
