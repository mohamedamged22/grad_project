import 'package:flutter/material.dart';

class ThemeService {
  ThemeService._();

  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  static bool get isDark => themeModeNotifier.value == ThemeMode.dark;

  static void setDarkMode(bool enabled) {
    themeModeNotifier.value = enabled ? ThemeMode.dark : ThemeMode.light;
  }
}
