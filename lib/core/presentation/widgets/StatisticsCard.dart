import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';

class StatisticsCard extends StatefulWidget {
  final String cardSubTitle;
  final String cardTitle;
  final double width;
  final double height;
  final IconData icon;

  const StatisticsCard({
    super.key,
    required this.cardSubTitle,
    required this.cardTitle,
    required this.width,
    required this.height,
    required this.icon,
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
        child: _buildCardContent(widget.icon),
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
  Widget _buildCardContent(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Palette.white.withOpacity(0.7)),
              const SizedBox(width: 4),
              _buildCardText(widget.cardTitle, 10, FontWeight.w800,
                  Palette.white.withOpacity(0.7)),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: _buildCardText(
                widget.cardSubTitle, 14, FontWeight.w600, Palette.mainAppColor),
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
