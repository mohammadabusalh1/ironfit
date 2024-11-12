import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/routes/routes.dart';

class CoachNavController extends GetxController {
  var selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index; // Update the selected index

    // Navigate based on the selected index
    switch (index) {
      case 0:
        Navigator.pushNamed(Get.context!, Routes.coachDashboard);
        break;
      case 1:
        Navigator.pushNamed(Get.context!, Routes.trainees);
        break;
      case 2:
        Navigator.pushNamed(Get.context!, Routes.myPlans);
        break;
      case 3:
        Navigator.pushNamed(Get.context!, Routes.coachStatistics);
        break;
      case 4:
        Navigator.pushNamed(Get.context!, Routes.coachProfile);
        break;
    }
  }
}
