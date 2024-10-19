import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // Method that returns a Future<SharedPreferences>
  Future<SharedPreferences> getPreferences() async {
    // Await the SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
