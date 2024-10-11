import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/nav_bar_controller.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

class CoachNavBar extends StatelessWidget {
  final NavController navController =
      Get.find(); // Find the NavController instance.

  CoachNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set text direction to right-to-left.
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Palette.black, // Background color of the nav bar.
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            )
          ],
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

  // Method to build each navigation item with animations and improved visuals.
  Widget _buildNavItem(IconData icon, int index) {
    return Obx(() {
      bool isSelected = navController.selectedIndex.value == index;

      return GestureDetector(
        onTap: () {
          navController.updateIndex(index);
        },
        child: AnimatedContainer(
          duration:
              const Duration(milliseconds: 300), // Smooth animation duration.
          curve: Curves.easeInOut, // Smooth easing curve.
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon with color and size animation.
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  icon,
                  color: isSelected ? Palette.mainAppColor : Palette.white,
                  size: isSelected ? 35 : 25,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: isSelected
                      ? Palette.mainAppColor
                      : Palette.white.withOpacity(0.6),
                  fontSize: isSelected ? 12 : 10,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                child: Text(_getNavItemLabel(index)),
              ),
            ],
          ),
        ),
      );
    });
  }

  // Get label for each navigation item.
  String _getNavItemLabel(int index) {
    switch (index) {
      case 0:
        return 'الرئيسية';
      case 1:
        return 'المتدربين';
      case 2:
        return 'البرامج';
      case 3:
        return 'إحصائيات';
      case 4:
        return 'الحساب';
      default:
        return '';
    }
  }
}
