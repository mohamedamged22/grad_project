import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  ThemeService._();

  static const String _darkModeKey = 'dark_mode_enabled';

  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  static bool get isDark => themeModeNotifier.value == ThemeMode.dark;

  /// Load the saved theme preference from SharedPreferences.
  /// Call this once during app startup (before runApp or in main).
  static Future<void> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_darkModeKey) ?? false;
    themeModeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  /// Set dark mode and persist the preference.
  static void setDarkMode(bool enabled) {
    themeModeNotifier.value = enabled ? ThemeMode.dark : ThemeMode.light;
    _persistPreference(enabled);
  }

  static void _persistPreference(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, enabled);
  }
}