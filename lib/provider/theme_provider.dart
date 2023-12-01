import 'package:flutter/material.dart';

enum ThemeModeType { light, dark, system }

class ThemeProvider extends ChangeNotifier {
  late ThemeData _themeData;
  late ThemeModeType _themeMode;

  ThemeProvider() {
    _themeMode = ThemeModeType.system;
    _updateTheme();
  }

  ThemeModeType get themeMode => _themeMode;
  ThemeData get themeData => _themeData;

  void setThemeMode(ThemeModeType mode) {
    _themeMode = mode;
    _updateTheme();
    notifyListeners();
  }

  void _updateTheme() {
    switch (_themeMode) {
      case ThemeModeType.light:
        _themeData = ThemeData.light();
        break;
      case ThemeModeType.dark:
        _themeData = ThemeData.dark();
        break;
      case ThemeModeType.system:
        // Use the default system theme
        _themeData = ThemeData();
        break;
    }
  }
}
