import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';

class StatisticsCard extends StatefulWidget {
  final String cardSubTitle;
  final String cardTitle;
  final double width;
  final double height;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color cardTextColor;
  final Color iconColor;

  const StatisticsCard({
    super.key,
    required this.cardSubTitle,
    required this.cardTitle,
    required this.width,
    required this.height,
    required this.icon,
    this.backgroundColor = Palette.secondaryColor,
    this.textColor = Palette.mainAppColorWhite,
    this.cardTextColor = Palette.mainAppColor,
    this.iconColor = Palette.mainAppColor,
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
        decoration: _buildBoxDecoration(widget.backgroundColor),
        transform: _isHovered
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.identity(),
        child: _buildCardContent(widget.icon, widget.textColor, widget.cardTextColor),
      ),
    );
  }

  // Builds the decoration for the card, including shadow and hover effect.
  BoxDecoration _buildBoxDecoration(Color backgroundColor) {
    return BoxDecoration(
      color: backgroundColor,
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
  Widget _buildCardContent(IconData icon, Color textColor, Color cardTextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: widget.iconColor),
              const SizedBox(width: 4),
              _buildCardText(widget.cardTitle, 10, FontWeight.normal,
                  textColor),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: _buildCardText(
                widget.cardSubTitle, 14, FontWeight.bold, cardTextColor),
          )
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
      style: AppStyles.textCairo(
        fontSize,
        color,
        fontWeight,
      ),
    );
  }
}
