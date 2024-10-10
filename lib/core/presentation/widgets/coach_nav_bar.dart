import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/nav_bar_controller.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

// CoachNavBar is a navigation bar widget for the coach interface.
class CoachNavBar extends StatelessWidget {
  final NavController navController =
      Get.find(); // Find the NavController instance.

  CoachNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set text direction to right-to-left.
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: 10), // Vertical padding for the nav bar.
        decoration: const BoxDecoration(
          color: Palette.black, // Background color of the nav bar.
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround, // Space items evenly.
          children: [
            // Build navigation items
            _buildNavItem(Icons.home_filled, 0),
            _buildNavItem(Icons.people, 1),
            _buildNavItem(Icons.pending_actions, 2),
            _buildNavItem(Icons.pie_chart, 3),
            _buildNavItem(Icons.person, 4),
          ],
        ),
      ),
    );
  }

  // Method to build each navigation item.
  Widget _buildNavItem(IconData icon, int index) {
    return Obx(() {
      // Reactive widget that listens for changes in the controller.
      bool isSelected = navController.selectedIndex.value ==
          index; // Check if the item is selected.

      return GestureDetector(
        onTap: () {
          navController.updateIndex(
              index); // Update the selected index in the controller.
        },
        child: Column(
          mainAxisSize: MainAxisSize.min, // Use minimum size for the column.
          children: [
            // Icon for the navigation item
            Icon(
              icon,
              color: isSelected
                  ? Palette.mainAppColor
                  : Palette.white, // Change color based on selection.
              size: isSelected ? 35 : 25, // Change size based on selection.
            ),
            const SizedBox(height: 4), // Space between icon and indicator.
            if (isSelected) // Show indicator if the item is selected.
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Palette.mainAppColor, // Color of the indicator.
                  shape: BoxShape.circle, // Circular shape for the indicator.
                ),
              ),
          ],
        ),
      );
    });
  }
}
