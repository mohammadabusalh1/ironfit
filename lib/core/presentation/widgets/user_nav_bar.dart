import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/presentation/controllers/user_nav_bar_controller.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';

class UserNavBar extends StatelessWidget {
  final UserNavController navController = Get.put(UserNavController());

  UserNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 70,
          child: GetBuilder<UserNavController>(
            init: navController,
            builder: (controller) => BottomNavigationBar(
              backgroundColor: Palette.blackBack,
              selectedItemColor: Palette.mainAppColorWhite,
              unselectedItemColor: Palette.gray,
              currentIndex: controller.selectedIndex.value,
              onTap: (index) {
                controller.updateIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: LocalizationService.translateFromGeneral('home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center),
                  label: LocalizationService.translateFromGeneral('exercises'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: LocalizationService.translateFromGeneral('profile'),
                ),
              ],
            ),
          ),
        ));
  }
}
