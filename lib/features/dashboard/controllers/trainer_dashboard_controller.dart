import 'package:get/get.dart';
import 'package:ironfit/features/my_gym/screens/my_gym_screen.dart';

class TrainerDashboardController extends GetxController {

  void onTap() {
    Get.to(() => MyGymScreen());
    Get.toNamed('/gymScreen');
  }

  void back () {
    Get.back();
  }
}
