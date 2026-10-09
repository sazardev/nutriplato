import 'package:flutter_test/flutter_test.dart';
import 'package:nutriplato/infrastructure/repositories/preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late PreferencesRepository repo;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    repo = PreferencesRepository(await SharedPreferences.getInstance());
  });

  group('PreferencesRepository valores por defecto', () {
    test('presentation por defecto es true (mostrar onboarding)', () {
      expect(repo.presentation, isTrue);
    });

    test('tema por defecto claro y color 0', () {
      expect(repo.isDarkMode, isFalse);
      expect(repo.selectedColor, 0);
    });

    test('listas vacías cuando no hay datos', () {
      expect(repo.foodLogDays, isEmpty);
      expect(repo.recentFoods, isEmpty);
      expect(repo.healthConditionsJson, isEmpty);
      expect(repo.healthMetricsJson, isEmpty);
      expect(repo.customFoodsJson, isEmpty);
      expect(repo.favoriteFoodNames, isEmpty);
      expect(repo.workoutHistoryJson, isEmpty);
      expect(repo.getFoodLogEntries('2026-01-01'), isEmpty);
    });

    test('strings nulos cuando no hay datos', () {
      expect(repo.usernameJson, isNull);
      expect(repo.userProfileJson, isNull);
      expect(repo.lastUseDate, isNull);
    });
  });

  group('PreferencesRepository escritura y lectura', () {
    test('persiste onboarding y tema', () async {
      await repo.setPresentation(false);
      await repo.setDarkMode(true);
      await repo.setSelectedColor(3);
      expect(repo.presentation, isFalse);
      expect(repo.isDarkMode, isTrue);
      expect(repo.selectedColor, 3);
    });

    test('persiste usuario y perfil como JSON', () async {
      await repo.setUsernameJson('{"username":"Ana"}');
      await repo.setUserProfileJson('{"id":"1"}');
      expect(repo.usernameJson, '{"username":"Ana"}');
      expect(repo.userProfileJson, '{"id":"1"}');
      await repo.removeUserProfile();
      expect(repo.userProfileJson, isNull);
    });

    test('persiste condiciones y métricas de salud', () async {
      await repo.setHealthConditionsJson(['["diabetes_type_2"]']);
      await repo.setHealthMetricsJson(['{"weight":65}']);
      expect(repo.healthConditionsJson, hasLength(1));
      expect(repo.healthMetricsJson, hasLength(1));
      await repo.removeHealthConditions();
      await repo.removeHealthMetrics();
      expect(repo.healthConditionsJson, isEmpty);
      expect(repo.healthMetricsJson, isEmpty);
    });

    test('persiste registro de alimentos por día', () async {
      await repo.setFoodLogDays(['2026-01-01T00:00:00.000']);
      await repo.setFoodLogEntries('2026-01-01T00:00:00.000', [
        '{"food":{"name":"Manzana"}}',
      ]);
      expect(repo.foodLogDays, hasLength(1));
      expect(repo.getFoodLogEntries('2026-01-01T00:00:00.000'), hasLength(1));
    });

    test('persiste búsquedas recientes', () async {
      await repo.setRecentFoods(['manzana', 'avena']);
      expect(repo.recentFoods, ['manzana', 'avena']);
    });

    test('persiste último uso y permite borrarlo', () async {
      await repo.setLastUseDate('2026-01-01');
      expect(repo.lastUseDate, '2026-01-01');
      await repo.removeLastUseDate();
      expect(repo.lastUseDate, isNull);
    });
  });

  group('PreferencesRepository backup', () {
    test('exportAll incluye todos los tipos soportados', () async {
      await repo.setPresentation(false);
      await repo.setSelectedColor(2);
      await repo.setUsernameJson('{"u":1}');
      await repo.setRecentFoods(['a']);
      final data = repo.exportAll();
      expect(data[PreferencesKeys.presentation], isFalse);
      expect(data[PreferencesKeys.selectedColor], 2);
      expect(data[PreferencesKeys.username], '{"u":1}');
      expect(data[PreferencesKeys.recentFoods], ['a']);
    });

    test('restoreValue restaura cada tipo', () async {
      await repo.restoreValue(PreferencesKeys.presentation, false);
      await repo.restoreValue(PreferencesKeys.selectedColor, 5);
      await repo.restoreValue(PreferencesKeys.username, '{"u":2}');
      await repo.restoreValue(PreferencesKeys.recentFoods, ['x', 'y']);
      expect(repo.presentation, isFalse);
      expect(repo.selectedColor, 5);
      expect(repo.usernameJson, '{"u":2}');
      expect(repo.recentFoods, ['x', 'y']);
    });
  });
}
