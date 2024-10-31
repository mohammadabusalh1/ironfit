import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/user_nav_bar_controller.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

class UserNavBar extends StatelessWidget {
  final UserNavController navController =
      Get.put(UserNavController()); // Find the NavController instance.

  UserNavBar({super.key});

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
            _buildNavItem(Icons.pending_actions, 1),
            _buildNavItem(Icons.person_2_outlined, 2),
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
        height: Get.height * 0.09,
        width: Get.width * 0.31,
        child: InkWell(
          onTap: () {
            navController.updateIndex(index);
          },
          child: AnimatedContainer(
            duration:
                const Duration(milliseconds: 300), // Smooth animation duration.
            curve: Curves.easeInOut, // Smooth easing curve.
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: isSelected
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                            style: TextStyle(
                              color: isSelected
                                  ? Palette.black.withOpacity(0.7)
                                  : Palette.mainAppColor.withOpacity(0.6),
                              fontSize: isSelected ? 10 : 10,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            child: Text(_getNavItemLabel(index)),
                          ),
                        ),
                      ],
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        color: isSelected
                            ? Palette.black
                            : Palette.white.withOpacity(0.6),
                        size: 24,
                      ),
                      const SizedBox(width: 4),
                      // Fade effect for text.
                      isSelected
                          ? AnimatedOpacity(
                              opacity: isSelected ? 1.0 : 0.6,
                              duration: const Duration(milliseconds: 300),
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: TextStyle(
                                  color: isSelected
                                      ? Palette.mainAppColor
                                      : Palette.black.withOpacity(0.6),
                                  fontSize: isSelected ? 12 : 10,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                child: Text(_getNavItemLabel(index)),
                              ),
                            )
                          : const SizedBox(),
                    ],
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
        return LocalizationService.translateFromGeneral('program');
      case 2:
        return LocalizationService.translateFromGeneral('profile');
      default:
        return '';
    }
  }
}
