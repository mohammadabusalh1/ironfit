import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/coach_nav_bar_controller.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

class CoachNavBar extends StatelessWidget {
  final CoachNavController navController =
      Get.find(); // Find the NavController instance.

  CoachNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set text direction to right-to-left.
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Palette.blackBack, // Background color of the nav bar.
          border: Border(
            top: BorderSide(
              color: Palette.white.withOpacity(
                  0.25), // Set the desired color for the left border
              width: 1.2, // Set the desired width for the left border
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, 0),
            _buildNavItem(Icons.people_outline, 1),
            _buildNavItem(Icons.pending_actions, 2),
            _buildNavItem(Icons.pie_chart_outline, 3),
            _buildNavItem(Icons.person_2_outlined, 4),
          ],
        ),
      ),
    );
  }

  // Method to build each navigation item with animations and improved visuals.
  Widget _buildNavItem(IconData icon, int index) {
    return Obx(() {
      bool isSelected = navController.selectedIndex.value == index;

      return SizedBox(
        width: isSelected ? Get.width * 0.29 : Get.width * 0.16,
        height: Get.height * 0.09,
        child: InkWell(
          onTap: () {
            navController.updateIndex(index);
          },
          child: Container(
            width: isSelected ? Get.width * 0.29 : Get.width * 0.16,
            height: Get.height * 0.09,
            child: AnimatedContainer(
              duration: const Duration(
                  milliseconds: 300), // Smooth animation duration.
              curve: Curves.easeInOut, // Smooth easing curve.
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: isSelected
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Palette.mainAppColorBack,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icon,
                            color: isSelected
                                ? Palette.black.withOpacity(0.7)
                                : Palette.black.withOpacity(0.4),
                            size: 24,
                          ),
                          const SizedBox(width: 4),
                          // Fade effect for text.
                          AnimatedOpacity(
                            opacity: isSelected ? 1.0 : 0.6,
                            duration: const Duration(milliseconds: 300),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: AppStyles.textCairo(
                                10,
                                isSelected
                                    ? Palette.black.withOpacity(0.7)
                                    : Palette.mainAppColor.withOpacity(0.6),
                                isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              child: Text(_getNavItemLabel(index)),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Icon(
                      icon,
                      color: Palette.white.withOpacity(0.6),
                      size: 24,
                    ),
            ),
          ),
        ),
      );
    });
  }

  // Get label for each navigation item.
  String _getNavItemLabel(int index) {
    switch (index) {
      case 0:
        return LocalizationService.translateFromGeneral('home');
      case 1:
        return LocalizationService.translateFromGeneral('trainees');
      case 2:
        return LocalizationService.translateFromGeneral('programs');
      case 3:
        return LocalizationService.translateFromGeneral('statistics');
      case 4:
        return LocalizationService.translateFromGeneral('profile');
      default:
        return '';
    }
  }
}
