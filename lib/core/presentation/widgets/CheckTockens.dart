import 'package:ironfit/core/presentation/controllers/sharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:ironfit/core/routes/routes.dart';

class TokenService {
  PreferencesService preferencesService = PreferencesService();

  Future<void> checkTokenAndNavigateDashboard() async {
    SharedPreferences prefs = await preferencesService.getPreferences();
    String? token = prefs.getString('token');

    if (token != null) {
      bool isCoach = prefs.getBool('isCoach') ?? false;
      _navigateToDashboard(isCoach);
    }
  }

  void _navigateToDashboard(bool isCoach) {
    final route = isCoach ? Routes.coachDashboard : Routes.trainerDashboard;
    Get.toNamed(route);
  }

  Future<void> checkTokenAndNavigateSingIn() async {
    SharedPreferences prefs = await preferencesService.getPreferences();
    String? token = prefs.getString('token');

    if (token == null) {
      Get.toNamed(Routes.singIn); // Navigate to coach dashboard
    }
  }
}
