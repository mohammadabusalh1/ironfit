import 'package:get/get.dart';
import 'package:ironfit/core/routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed(Routes.preLoginScreens);
  }
}
