import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/custom_text_widget.dart';

class Ticket extends StatelessWidget {
  final String name; // Name of the ticket holder
  final String address; // Address of the ticket holder
  final String imagePath; // Path to the image (if any)
  final String description; // Description of the ticket
  final VoidCallback onTap; // Callback function for tap event

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
      onTap: onTap, // Execute the onTap function when the ticket is tapped
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          _buildBackground(), // Build the background container
          _buildDarkOverlay(), // Add a dark overlay on top of the background
          _buildContent(), // Build the main content (image and text)
        ],
      ),
    );
  }

  Widget _buildBackground() {
    // Builds the background container of the ticket
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Palette.mainAppColor,
          width: 2,
        ),
      ),
    );
  }

  Widget _buildDarkOverlay() {
    // Creates a dark overlay for the ticket
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(0.4),
      ),
    );
  }

  Widget _buildContent() {
    // Builds the content of the ticket, including image and text
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImage(), // Build the image or avatar
          const SizedBox(width: 7),
          _buildTextContent(), // Build the text content
        ],
      ),
    );
  }

  Widget _buildImage() {
    // Builds the image or avatar section
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

  Widget _buildTextContent() {
    // Builds the text content section
    return Expanded(
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
    );
  }
}
