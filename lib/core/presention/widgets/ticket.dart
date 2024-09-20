import 'package:flutter/material.dart';
import 'package:ironfit/core/presention/style/palette.dart';
import 'package:ironfit/core/presention/widgets/custom_text_widget.dart';

class Ticket extends StatelessWidget {
  final String name;
  final String address;
  final String imagePath;
  final String description;
  final VoidCallback onTap;

  const Ticket({
    super.key,
    required this.name,
    required this.address,
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
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Palette.mainAppColor,
                width: 2,
              ),
            ),
          ),
          // Dark overlay
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          // Content with image/avatar and text
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image or Avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imagePath.isNotEmpty
                      ? Image.asset(
                    imagePath,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )
                      : const CircleAvatar(
                    radius: 30,
                    backgroundColor: Palette.mainAppColor,
                    child: Icon(
                      Icons.sports_esports,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextWidget(
                        text: name,
                        color: Palette.mainAppColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 4),
                      CustomTextWidget(
                        text: description,
                        color: Palette.subTitleGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomTextWidget(
                        text: address,
                        color: Palette.subTitleGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
