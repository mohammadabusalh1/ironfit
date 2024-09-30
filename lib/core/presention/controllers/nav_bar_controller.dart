import 'package:get/get.dart';
import 'package:ironfit/features/MyPlans/screens/my_plans_screen.dart';
import 'package:ironfit/features/dashboard/screens/coach_dashboard.dart'; // Assuming you have this screen
import 'package:ironfit/features/dashboard/screens/trainer_dashboard.dart';
import 'package:ironfit/features/profile/screens/profile_screen.dart';
import 'package:ironfit/features/userStatistics/screens/user_statistics_screen.dart';

class NavController extends GetxController {
  var selectedIndex = 0.obs;
  bool isCoach = false;

  void navigateAfterSignUp() {
    if (isCoach) {
      Get.offAll(() => CoachDashboard()); // Navigate to CoachDashboard
    } else {
      Get.offAll(() => TrainerDashboard()); // Navigate to TrainerDashboard
    }
  }

  void updateIndex(int index) {
    selectedIndex.value = index; // Update the selected index

    // Navigate based on the selected index
    switch (index) {
      case 0:

        if (isCoach) {
          Get.to(() => CoachDashboard());
        } else {
          Get.to(() => TrainerDashboard());
        }
        break;
      case 1:
        Get.to(() => const UserStatisticsScreen());
        break;
      case 2:
        Get.to(() => const MyPlansScreen());
        break;
      case 3:
        Get.to(() => ProfileScreen());
        break;
      default:
      // Do nothing for other indices
        break;
    }
  }
}
