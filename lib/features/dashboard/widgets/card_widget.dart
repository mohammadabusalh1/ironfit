import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/core/presention/widgets/custom_text_widget.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String description;
  final VoidCallback onTap;

  const CardWidget({
    super.key,
    required this.title,
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
        alignment: Alignment.topLeft,
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
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                    text: title,
                    color: Palette.mainAppColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 4),
                CustomTextWidget(
                    text: subtitle,
                    color: Palette.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 4),
                CustomTextWidget(
                    text: description,
                    color: Palette.subTitleGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
