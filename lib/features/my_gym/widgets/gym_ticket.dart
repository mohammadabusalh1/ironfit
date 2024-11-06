import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

class GymTicket extends StatelessWidget {
  final String name;
  final String address;
  final String imagePath;
  final String description;
  final VoidCallback onTap;

  const GymTicket({
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
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Palette.mainAppColor, width: 2),
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            _buildOverlay(),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  // Build the dark overlay
  Widget _buildOverlay() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(0.4),
      ),
    );
  }

  // Build the content with image/avatar and text
  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImage(),
          const SizedBox(width: 7),
          _buildTextContent(),
        ],
      ),
    );
  }

  // Build the image or avatar
  Widget _buildImage() {
    return ClipRRect(
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
    );
  }

  // Build the text content
  Widget _buildTextContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
  }
}
