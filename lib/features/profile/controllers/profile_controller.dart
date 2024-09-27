import 'package:get/get.dart';
import 'package:ironfit/core/presention/style/assets.dart';
import 'package:ironfit/domain/enteites/profile_user.dart';
import 'package:ironfit/features/regestraion/register/screens/sing_up_screen.dart';

class ProfileController extends GetxController {
  var userProfile = UserProfile(
    userName: 'Qossay',
    email: 'Qossay@odoo.com',
    profileImage: Assets.myTrainerImage,
    height: 1.85,
    weight: 80.0,
    age: 22,
  ).obs;

  var isMetric = true.obs;

  void toggleUnits(bool value) {
    isMetric.value = value;
  }

  String get displayHeight => isMetric.value
      ? userProfile.value.heightMetric
      : userProfile.value.heightImperial;

  String get displayWeight => isMetric.value
      ? userProfile.value.weightMetric
      : userProfile.value.weightImperial;

  double calculateBMI() {
    final weightInKg = userProfile.value.weight;
    final heightInMeters = userProfile.value.height;
    return weightInKg / (heightInMeters * heightInMeters);
  }

  void calculateCalories() {
  }

  void logout() {
    Get.to(() => const SignUpScreen());
  }
}
