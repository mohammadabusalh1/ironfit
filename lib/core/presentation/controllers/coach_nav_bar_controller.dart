import 'package:get/get.dart';
import 'package:ironfit/core/routes/routes.dart';

class CoachNavController extends GetxController {
  var selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index; // Update the selected index

    // Navigate based on the selected index
    switch (index) {
      case 0:
        Get.toNamed(Routes.coachDashboard);
        break;
      case 1:
        Get.toNamed(Routes.trainees);
        break;
      case 2:
        Get.toNamed(Routes.myPlans);
        break;
      case 3:
        Get.toNamed(Routes.coachStatistics);
        break;
      case 4:
        Get.toNamed(Routes.coachProfile);
        break;
    }
  }
}
