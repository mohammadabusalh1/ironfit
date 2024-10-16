import 'package:get/get.dart';
import 'package:ironfit/core/routes/routes.dart';

class UserNavController extends GetxController {
  var selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index; // Update the selected index

    // Navigate based on the selected index
    switch (index) {
      case 0:
        Get.toNamed(Routes.trainerDashboard);
        break;
      case 1:
        Get.toNamed(Routes.userMyPlan);
        break;
      case 2:
        Get.toNamed(Routes.userProfile);
        break;
    }
  }
}
