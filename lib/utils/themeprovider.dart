import 'package:flutter/material.dart';
import 'package:school_management_system/utils/colorconstaints.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = Colorconstaints.lightTheme;
  bool _isDarkMode = false;
  
   ThemeProvider() {
   _themeData = Colorconstaints.lightTheme;
   init();
  }

  Future<void> init() async {
    await _loadThemePreference();
  }
  
  ThemeData get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? Colorconstaints.darkTheme : Colorconstaints.lightTheme;
    _saveThemePreference(_isDarkMode);
    notifyListeners();
  }
   Future<void> _saveThemePreference(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeData = _isDarkMode ? Colorconstaints.darkTheme : Colorconstaints.lightTheme;
    notifyListeners();
  }
}
