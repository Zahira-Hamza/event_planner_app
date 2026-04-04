import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  static const _key = 'app_theme';

  ThemeMode _appTheme = ThemeMode.light;

  ThemeMode get getAppTheme => _appTheme;
  bool get isDark => _appTheme == ThemeMode.dark;

  // Called once in main() before runApp
  Future<void> loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    _appTheme = saved == 'dark' ? ThemeMode.dark : ThemeMode.light;
    // No notifyListeners here — called before widget tree exists
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (_appTheme == newTheme) return;
    _appTheme = newTheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, newTheme == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }
}
