import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  static const _key = 'app_language';

  String appLanguage = 'en';

  // Called once in main() before runApp
  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString(_key) ?? 'en';
    // No notifyListeners here — called before widget tree exists
  }

  Future<void> changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) return;
    appLanguage = newLanguage;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, newLanguage);
    notifyListeners();
  }
}
