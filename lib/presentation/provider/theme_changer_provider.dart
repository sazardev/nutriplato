import 'dart:developer' as dev;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _tag = 'NutriPlato|ThemeChangerProvider';

class ThemeChangerProvider extends ChangeNotifier {
  int _selectedColor = 0;
  bool _isDarkMode = false;

  int get selectedColor => _selectedColor;
  bool get isDarkMode => _isDarkMode;

  ThemeChangerProvider() {
    _loadThemePreferences();
  }

  void changeColorIndex(int index) {
    dev.log('changeColorIndex → $index (antes: $_selectedColor)', name: _tag);
    _selectedColor = index;
    _saveThemePreferences();
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    dev.log('toggleDarkMode → isDarkMode=$_isDarkMode', name: _tag);
    _saveThemePreferences();
    notifyListeners();
  }

  void _loadThemePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedColor = prefs.getInt('selectedColor') ?? 0;
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    dev.log(
      '_loadThemePreferences → color=$_selectedColor darkMode=$_isDarkMode',
      name: _tag,
    );
    notifyListeners();
  }

  void _saveThemePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedColor', _selectedColor);
    await prefs.setBool('isDarkMode', _isDarkMode);
    dev.log(
      '_saveThemePreferences → color=$_selectedColor darkMode=$_isDarkMode guardado',
      name: _tag,
    );
  }
}
