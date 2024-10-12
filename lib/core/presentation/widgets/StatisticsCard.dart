import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

class StatisticsCard extends StatefulWidget {
  final String cardSubTitle;
  final String cardTitle;
  final double width;
  final double height;

  const StatisticsCard({
    super.key,
    required this.cardSubTitle,
    required this.cardTitle,
    required this.width,
    required this.height,
  });

  @override
  _StatisticsCardState createState() => _StatisticsCardState();
}

class _StatisticsCardState extends State<StatisticsCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle card tap interaction (e.g., navigate to details page).
      },
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: widget.width,
        height: widget.height,
        decoration: _buildBoxDecoration(),
        transform: _isHovered
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.identity(),
        child: _buildCardContent(),
      ),
    );
  }

  // Builds the decoration for the card, including shadow and hover effect.
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Palette.secondaryColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(_isHovered ? 0.3 : 0.1),
          blurRadius: _isHovered ? 15 : 8,
          offset: Offset(0, _isHovered ? 10 : 4), // Hover effect depth.
        ),
      ],
    );
  }

  // Builds the content of the card.
  Widget _buildCardContent() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCardText(
              widget.cardSubTitle, 14, FontWeight.w600, Colors.white),
          const SizedBox(height: 4),
          _buildCardText(
              widget.cardTitle, 12, FontWeight.w800, Palette.mainAppColor),
        ],
      ),
    );
  }

  // Creates a styled text widget for the card.
  Widget _buildCardText(
      String text, double fontSize, FontWeight fontWeight, Color color) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: 0.5,
      ),
    );
  }
}
