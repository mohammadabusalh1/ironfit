import 'package:get/get.dart';
import 'package:ironfit/features/MyPlans/screens/my_plans_screen.dart';
import 'package:ironfit/features/dashboard/screens/trainer_dashboard.dart';
import 'package:ironfit/features/profile/screens/profile_screen.dart';
import 'package:ironfit/features/userStatistics/screens/user_statistics_screen.dart';

class NavController extends GetxController {
  var selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;

    switch (index) {
      case 0:
        Get.to(() => TrainerDashboard());
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
