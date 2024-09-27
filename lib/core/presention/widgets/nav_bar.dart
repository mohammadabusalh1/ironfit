import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/controllers/nav_bar_controller.dart';
import 'package:ironfit/core/presention/style/palette.dart';

class NavBar extends StatelessWidget {
  final NavController navController = Get.find();

  NavBar({super.key}); // Find the controller

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Palette.black,
        borderRadius: BorderRadius.circular(30), // Make it curved
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, 0),
          _buildNavItem(Icons.pie_chart, 1),
          _buildNavItem(Icons.pending_actions, 2),
          _buildNavItem(Icons.person, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return Obx(() {
      bool isSelected = navController.selectedIndex.value == index;

      return GestureDetector(
        onTap: () {
          navController.updateIndex(index); // Call controller's updateIndex
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Palette.mainAppColor : Palette.white,
              size: isSelected ? 35 : 25, // Highlight selected icon
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Palette.mainAppColor,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      );
    });
  }
}
