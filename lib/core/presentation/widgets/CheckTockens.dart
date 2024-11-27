import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

    User? user = FirebaseAuth.instance.currentUser;

    if (token == null || user == null) {
      Get.toNamed(Routes.singIn); // Navigate to coach dashboard
    }
  }

  Future<void> isLanguageSelected() async {
    SharedPreferences prefs = await preferencesService.getPreferences();
    String? language = prefs.getString('languageCode');

    if (language == null) {
      Get.toNamed(Routes.selectLanguage);
    } else {
      Get.toNamed(Routes.preLoginScreens);
    }
  }

  Future<bool> checkSubscription() async {
    User? user = FirebaseAuth.instance.currentUser;

    // Fetch the coach's subscription data
    var subscription = await FirebaseFirestore.instance
        .collection('coaches')
        .doc(user!.uid)
        .get();

    return subscription.data()?['subscription'] ?? false;
  }
}
