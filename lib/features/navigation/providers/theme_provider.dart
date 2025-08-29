import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CustomTheme {
  noctis,
  sublimeGit,
  dark,
  light,
}

class ThemeProvider with ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  
  CustomTheme _currentTheme = CustomTheme.noctis;
  bool _isLoading = false;

  CustomTheme get currentTheme => _currentTheme;
  bool get isLoading => _isLoading;
  bool get isDarkMode => _currentTheme == CustomTheme.dark || _currentTheme == CustomTheme.noctis || _currentTheme == CustomTheme.sublimeGit;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey) ?? CustomTheme.noctis.index;
      _currentTheme = CustomTheme.values[themeIndex];
    } catch (e) {
      debugPrint('Error loading theme: $e');
      _currentTheme = CustomTheme.noctis;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> setTheme(CustomTheme theme) async {
    if (_currentTheme == theme) return;

    _currentTheme = theme;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, theme.index);
    } catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }

  Future<void> cycleTheme() async {
    final themes = CustomTheme.values;
    final currentIndex = themes.indexOf(_currentTheme);
    final nextIndex = (currentIndex + 1) % themes.length;
    await setTheme(themes[nextIndex]);
  }

  String getThemeName() {
    switch (_currentTheme) {
      case CustomTheme.noctis:
        return 'Noctis';
      case CustomTheme.sublimeGit:
        return 'SublimeGit';
      case CustomTheme.dark:
        return 'Dark';
      case CustomTheme.light:
        return 'Light';
    }
  }

  IconData getThemeIcon() {
    switch (_currentTheme) {
      case CustomTheme.noctis:
        return Icons.nightlight_round;
      case CustomTheme.sublimeGit:
        return Icons.code;
      case CustomTheme.dark:
        return Icons.dark_mode;
      case CustomTheme.light:
        return Icons.light_mode;
    }
  }

  // Legacy support for ThemeMode
  ThemeMode get themeMode {
    switch (_currentTheme) {
      case CustomTheme.noctis:
      case CustomTheme.sublimeGit:
      case CustomTheme.dark:
        return ThemeMode.dark;
      case CustomTheme.light:
        return ThemeMode.light;
    }
  }
}
