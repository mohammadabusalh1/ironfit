import 'package:get/get.dart';
import 'package:ironfit/features/dashboard/screens/trainer_dashboard.dart';
import 'package:ironfit/features/profile/screens/profile_screen.dart';


class NavController extends GetxController {
  var selectedIndex = 0.obs;


  void updateIndex(int index) {
    selectedIndex.value = index;

    switch (index) {
      case 0:
      // Navigate to the Dashboard screen
        Get.to(() => TrainerDashboard());
        break;
      case 3:
      // Navigate to the Profile screen
        Get.to(() => ProfileScreen());
        break;
      default:
      // Do nothing for other indices
        break;
    }
  }
}
