import 'package:shared_preferences/shared_preferences.dart';

/// Claves de persistencia local (fuente única de verdad).
///
/// Ningún archivo fuera de este repositorio debe usar strings de claves
/// directamente.
class PreferencesKeys {
  PreferencesKeys._();

  static const String presentation = 'presentation';
  static const String isDarkMode = 'isDarkMode';
  static const String selectedColor = 'selectedColor';
  static const String username = 'username';
  static const String userProfile = 'user_profile';
  static const String userHealthConditions = 'user_health_conditions';
  static const String userHealthMetrics = 'user_health_metrics';
  static const String foodLogDays = 'food_log_days';
  static const String recentFoods = 'recentFoods';
  static const String lastUseDate = 'last_use_date';
  static const String customFoods = 'custom_foods';
  static const String favoriteFoods = 'favorite_foods';
  static const String smartWorkoutHistory = 'smart_workout_history';

  static String foodLogFor(String dayStr) => 'food_log_$dayStr';
}

/// Repositorio único de persistencia local sobre `SharedPreferences`.
///
/// Centraliza el acceso al almacenamiento: los providers y pantallas
/// dependen de esta API tipada en vez de usar claves y `SharedPreferences`
/// directamente. Los valores de modelos se exponen como JSON crudo para que
/// cada modelo siga siendo responsable de su propia (de)serialización.
class PreferencesRepository {
  PreferencesRepository(this._prefs);

  final SharedPreferences _prefs;

  // ── Onboarding ────────────────────────────────────────────────────────────

  bool get presentation => _prefs.getBool(PreferencesKeys.presentation) ?? true;

  Future<void> setPresentation(bool value) =>
      _prefs.setBool(PreferencesKeys.presentation, value);

  // ── Tema ──────────────────────────────────────────────────────────────────

  bool get isDarkMode => _prefs.getBool(PreferencesKeys.isDarkMode) ?? false;

  Future<void> setDarkMode(bool value) =>
      _prefs.setBool(PreferencesKeys.isDarkMode, value);

  int get selectedColor => _prefs.getInt(PreferencesKeys.selectedColor) ?? 0;

  Future<void> setSelectedColor(int value) =>
      _prefs.setInt(PreferencesKeys.selectedColor, value);

  // ── Usuario ───────────────────────────────────────────────────────────────

  String? get usernameJson => _prefs.getString(PreferencesKeys.username);

  Future<void> setUsernameJson(String json) =>
      _prefs.setString(PreferencesKeys.username, json);

  String? get userProfileJson => _prefs.getString(PreferencesKeys.userProfile);

  Future<void> setUserProfileJson(String json) =>
      _prefs.setString(PreferencesKeys.userProfile, json);

  Future<void> removeUserProfile() =>
      _prefs.remove(PreferencesKeys.userProfile);

  List<String> get healthConditionsJson =>
      _prefs.getStringList(PreferencesKeys.userHealthConditions) ?? const [];

  Future<void> setHealthConditionsJson(List<String> json) =>
      _prefs.setStringList(PreferencesKeys.userHealthConditions, json);

  Future<void> removeHealthConditions() =>
      _prefs.remove(PreferencesKeys.userHealthConditions);

  List<String> get healthMetricsJson =>
      _prefs.getStringList(PreferencesKeys.userHealthMetrics) ?? const [];

  Future<void> setHealthMetricsJson(List<String> json) =>
      _prefs.setStringList(PreferencesKeys.userHealthMetrics, json);

  Future<void> removeHealthMetrics() =>
      _prefs.remove(PreferencesKeys.userHealthMetrics);

  // ── Registro de alimentos ─────────────────────────────────────────────────

  List<String> get foodLogDays =>
      _prefs.getStringList(PreferencesKeys.foodLogDays) ?? const [];

  Future<void> setFoodLogDays(List<String> days) =>
      _prefs.setStringList(PreferencesKeys.foodLogDays, days);

  List<String> getFoodLogEntries(String dayStr) =>
      _prefs.getStringList(PreferencesKeys.foodLogFor(dayStr)) ?? const [];

  Future<void> setFoodLogEntries(String dayStr, List<String> entries) =>
      _prefs.setStringList(PreferencesKeys.foodLogFor(dayStr), entries);

  // ── Búsqueda ──────────────────────────────────────────────────────────────

  List<String> get recentFoods =>
      _prefs.getStringList(PreferencesKeys.recentFoods) ?? const [];

  Future<void> setRecentFoods(List<String> names) =>
      _prefs.setStringList(PreferencesKeys.recentFoods, names);

  // ── Alimentos personalizados, favoritos e historial fitness ───────────────

  List<String> get customFoodsJson =>
      _prefs.getStringList(PreferencesKeys.customFoods) ?? const [];

  Future<void> setCustomFoodsJson(List<String> raw) =>
      _prefs.setStringList(PreferencesKeys.customFoods, raw);

  List<String> get favoriteFoodNames =>
      _prefs.getStringList(PreferencesKeys.favoriteFoods) ?? const [];

  Future<void> setFavoriteFoodNames(List<String> names) =>
      _prefs.setStringList(PreferencesKeys.favoriteFoods, names);

  List<String> get workoutHistoryJson =>
      _prefs.getStringList(PreferencesKeys.smartWorkoutHistory) ?? const [];

  Future<void> setWorkoutHistoryJson(List<String> raw) =>
      _prefs.setStringList(PreferencesKeys.smartWorkoutHistory, raw);

  // ── Último uso ────────────────────────────────────────────────────────────

  String? get lastUseDate => _prefs.getString(PreferencesKeys.lastUseDate);

  Future<void> setLastUseDate(String isoDate) =>
      _prefs.setString(PreferencesKeys.lastUseDate, isoDate);

  Future<void> removeLastUseDate() =>
      _prefs.remove(PreferencesKeys.lastUseDate);

  // ── Backup / restauración ─────────────────────────────────────────────────

  /// Todas las claves persistidas con tipos soportados por el respaldo.
  Map<String, Object> exportAll() {
    final data = <String, Object>{};
    for (final key in _prefs.getKeys()) {
      final value = _prefs.get(key);
      if (value is String ||
          value is bool ||
          value is int ||
          value is double ||
          value is List<String>) {
        data[key] = value!;
      }
    }
    return data;
  }

  /// Restaura una clave desde un valor decodificado de JSON.
  Future<void> restoreValue(String key, Object value) async {
    if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is List) {
      await _prefs.setStringList(key, value.map((e) => e.toString()).toList());
    } else {
      await _prefs.setString(key, value.toString());
    }
  }
}
