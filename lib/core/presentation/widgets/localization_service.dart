import 'dart:convert';
import 'package:flutter/services.dart';

class LocalizationService {
  static Map<String, dynamic> _localizedStrings = {};

  static Future<void> load(String languageCode) async {
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
}
///   itself if a translation is not found.
