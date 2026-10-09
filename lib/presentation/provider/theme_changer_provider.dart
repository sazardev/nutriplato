import 'dart:developer' as dev;
import 'package:flutter/widgets.dart';
import 'package:nutriplato/infrastructure/repositories/preferences_repository.dart';

const _tag = 'NutriPlato|ThemeChangerProvider';

class ThemeChangerProvider extends ChangeNotifier {
  ThemeChangerProvider(this._preferences) {
    _loadThemePreferences();
  }

  final PreferencesRepository _preferences;

  int _selectedColor = 0;
  bool _isDarkMode = false;

  int get selectedColor => _selectedColor;
  bool get isDarkMode => _isDarkMode;

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
    _selectedColor = _preferences.selectedColor;
    _isDarkMode = _preferences.isDarkMode;
    dev.log(
      '_loadThemePreferences → color=$_selectedColor darkMode=$_isDarkMode',
      name: _tag,
    );
    notifyListeners();
  }

  void _saveThemePreferences() async {
    await _preferences.setSelectedColor(_selectedColor);
    await _preferences.setDarkMode(_isDarkMode);
    dev.log(
      '_saveThemePreferences → color=$_selectedColor darkMode=$_isDarkMode guardado',
      name: _tag,
    );
  }
}
