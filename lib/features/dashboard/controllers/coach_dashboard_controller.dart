import 'package:get/get.dart';


class CoachDashboardController extends GetxController {
  var coaches = <Map<String, String>>[
    {'name': 'John Doe', 'photo': 'https://example.com/john.jpg'},
    {'name': 'Jane Smith', 'photo': 'https://example.com/jane.jpg'},
  ].obs;

  void onCoachTap(Map<String, String> coach) {
    // Get.to(() => CoachDetailScreen(coach: coach));
  }
}
