import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChangerProvider extends ChangeNotifier {
  int _selectedColor = 0;
  bool _isDarkMode = false;

  int get selectedColor => _selectedColor;
  bool get isDarkMode => _isDarkMode;

  ThemeChangerProvider() {
    _loadThemePreferences();
  }

  void changeColorIndex(int index) {
    _selectedColor = index;
    _saveThemePreferences();
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _saveThemePreferences();
    notifyListeners();
  }

  void _loadThemePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedColor = prefs.getInt('selectedColor') ?? 0;
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  void _saveThemePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedColor', _selectedColor);
    await prefs.setBool('isDarkMode', _isDarkMode);
  }
}
