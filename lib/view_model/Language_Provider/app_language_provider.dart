import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  String appLanguage = 'en'; //? that what will locale in the main will take
  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }
}
