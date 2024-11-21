import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // Method that returns a Future<SharedPreferences>
  Future<SharedPreferences> getPreferences() async {
    // Await the SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<void> setPlan(String userId, String planJson) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('plan_$userId', planJson);
  }

  Future<String?> getPlan(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('plan_$userId');
  }

  Future<void> removePlan(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('plan_$userId');
  }
}
