import 'package:shared_preferences/shared_preferences.dart';

Future<String?> fetchCoachId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? coachId = prefs.getString('coachId');

  return coachId;
}
