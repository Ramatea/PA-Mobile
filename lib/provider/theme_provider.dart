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

  Color get backgroundColor =>
      _themeMode == ThemeModeType.light ? Colors.white : Colors.black;

  Color get textColor =>
      _themeMode == ThemeModeType.light ? Colors.black : Colors.white;

  Color get primaryColor {
    if (_themeMode == ThemeModeType.light) {
      Color.fromARGB(255, 82, 109, 130);
      return ThemeData.light().primaryColor;
    } else {
      return _themeData.primaryColor;
    }
  }

  void setThemeMode(ThemeModeType mode) {
    _themeMode = mode;
    _updateTheme();
    notifyListeners();
  }

  void _updateTheme() {
    switch (_themeMode) {
      case ThemeModeType.light:
        _themeData = ThemeData.light().copyWith(
          primaryColor: Color.fromARGB(255, 82, 109, 130),
        );
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
