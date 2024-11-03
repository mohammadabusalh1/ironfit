import 'package:flutter/material.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
// CoachCard is a reusable widget that displays coach information.
class CoachCard extends StatelessWidget {
  final String name; // Name of the coach.
  final String address; // Address of the coach.
  final String imagePath; // Path to the coach's image.
  final String description; // Description of the coach.
  final VoidCallback onTap; // Callback function when the card is tapped.

  // Constructor for CoachCard with required parameters.
  const CoachCard({
    super.key,
    required this.name,
    required this.address,
    required this.imagePath,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger the onTap callback when tapped.
      child: Card(
        color: Palette.mainAppColor, // Background color of the card.
        margin: const EdgeInsets.symmetric(
            vertical: 8.0, horizontal: 16.0), // Card margin.
        elevation: 4.0, // Shadow elevation of the card.
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding inside the card.
          child: Row(
            children: [
              const SizedBox(
                  width: 16.0), // Space on the left side of the content.
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the start.
                  children: [
                    // Coach's name displayed in bold.
                    // CustomTextWidget(
                    //   text: name,
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 20,
                    //   color: Palette.black,
                    // ),
                    // // Coach's address.
                    // CustomTextWidget(
                    //   text: address,
                    //   color: Palette.subTitleBlack,
                    // ),
                    // // Coach's description.
                    // CustomTextWidget(
                    //   text: description,
                    //   color: Palette.subTitleBlack,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
