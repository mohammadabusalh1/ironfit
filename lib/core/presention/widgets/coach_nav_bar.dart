import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presention/controllers/nav_bar_controller.dart';
import 'package:ironfit/core/presention/style/palette.dart';

class CoachNavBar extends StatelessWidget {
  final NavController navController = Get.find();

  CoachNavBar({super.key}); // Find the controller

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Palette.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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