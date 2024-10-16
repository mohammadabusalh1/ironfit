import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/user_nav_bar_controller.dart';
import 'package:ironfit/core/presentation/style/palette.dart';

class UserNavBar extends StatelessWidget {
  final UserNavController navController =
      Get.put(UserNavController()); // Find the NavController instance.

  UserNavBar({super.key});

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
            _buildNavItem(Icons.pending_actions, 1),
            _buildNavItem(Icons.person, 2),
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
              // Icon with rotation, scale, and color animation.
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: Transform.rotate(
                  angle:
                      isSelected ? 0.1 : 0.0, // Small rotation when selected.
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: isSelected ? 1.2 : 1.0, // Scale animation on tap.
                    child: Icon(
                      icon,
                      color: isSelected ? Palette.mainAppColor : Palette.white,
                      size: isSelected ? 35 : 25,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              // Fade effect for text.
              AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.6,
                duration: const Duration(milliseconds: 300),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    color: isSelected
                        ? Palette.mainAppColor
                        : Palette.white.withOpacity(0.6),
                    fontSize: isSelected ? 12 : 10,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  child: Text(_getNavItemLabel(index)),
                ),
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
        return 'البرامج';
      case 2:
        return 'الحساب';
      default:
        return '';
    }
  }
}
