import 'dart:convert';
import 'package:flutter/services.dart';

class LocalizationService {
  static Map<String, dynamic> _localizedStrings = {};
  static String lang = 'en';

  static Future<void> load(String languageCode) async {
    lang = languageCode;
    String jsonString =
        await rootBundle.loadString('assets/lang/$languageCode.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap;
  }

  static String translateFromPage(String key, String page) {
    return _localizedStrings[page]?[key] ?? key;
  }

  static String translateFromGeneral(String key) {
    return _localizedStrings[key] ?? key;
  }

  static String getDir() {
    if (lang == 'ar') {
      return 'rtl';
    } else if (lang == 'en') {
      return 'ltr';
    } else {
      return 'rtl';
    }
  }
}
///   itself if a translation is not found.
