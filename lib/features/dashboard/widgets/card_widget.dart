import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';

class CardWidget extends StatelessWidget {
  final String subtitle;
  final String imagePath;
  final String description;
  final VoidCallback onTap;

  const CardWidget({
    super.key,
    required this.subtitle,
    required this.imagePath,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: const AlignmentDirectional(-1, 1),
        children: [
          // Background image
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark overlay
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          // Text Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max, // Align content to the right
              children: [
                Text(
                  textAlign: TextAlign.start,
                  subtitle,
                  style: AppStyles.textCairo(
                    16,
                    Palette.mainAppColorWhite,
                    FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  textAlign: TextAlign.start,
                  description,
                  style: AppStyles.textCairo(
                    12,
                    Palette.subTitleGrey,
                    FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
