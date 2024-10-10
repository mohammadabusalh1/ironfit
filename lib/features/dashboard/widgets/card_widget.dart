import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/custom_text_widget.dart';

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
        alignment: AlignmentDirectional(-1, 1),
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
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.max, // Align content to the right
              children: [
                CustomTextWidget(
                    text: subtitle,
                    color: Palette.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 4),
                CustomTextWidget(
                    text: description,
                    color: Palette.suffixColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
