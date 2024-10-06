import 'package:get/get.dart';
import 'package:ironfit/core/routes/routes.dart';
import 'package:ironfit/features/MyPlans/screens/my_plans_screen.dart';
import 'package:ironfit/features/Trainees/screens/Trainees_screen.dart';
import 'package:ironfit/features/dashboard/screens/coach_dashboard.dart';
import 'package:ironfit/features/coachProfile/screens/coach_profile_screen.dart';
import 'package:ironfit/features/userStatistics/screens/user_statistics_screen.dart';

class NavController extends GetxController {
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
        Get.toNamed(Routes.myPlans);
        break;
      case 4:
        Get.toNamed(Routes.profile);
        break;
    }
  }
}
