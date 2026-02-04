import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode _appTheme = ThemeMode.light;

  ThemeMode get getAppTheme => _appTheme;
  bool get isDark => _appTheme == ThemeMode.dark;

  void changeTheme(ThemeMode newTheme) {
    if (_appTheme == newTheme) {
      return;
    }
    _appTheme = newTheme;
    notifyListeners();
  }
}
