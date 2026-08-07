import 'package:flutter_test/flutter_test.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/services/daily_prediction_service.dart';

UserProfile _profile() => UserProfile(
  id: 'test-user',
  username: 'Test',
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
  birthDate: DateTime(1990, 1, 1),
  gender: Gender.female,
  heightCm: 165,
  weightKg: 70,
  activityLevel: ActivityLevel.moderatelyActive,
  nutritionGoal: NutritionGoal.loseWeight,
);

String _signature(DailyPrediction p) {
  final meals = p.meals.map((m) => '${m.type}:${m.foods.map((f) => f.name).join(',')}').join('|');
  return '$meals :: ${p.workout.focus} :: ${p.read.articleTitle}';
}

void main() {
  group('DailyPredictionService', () {
    test('es determinista: mismo usuario y fecha → misma predicción', () {
      final date = DateTime(2026, 8, 7);
      final a = DailyPredictionService.predict(
        userId: 'u1',
        date: date,
        profile: _profile(),
      );
      final b = DailyPredictionService.predict(
        userId: 'u1',
        date: date,
        profile: _profile(),
      );
      expect(_signature(a), _signature(b));
      expect(a.workout.exercises, b.workout.exercises);
      expect(a.motivation, b.motivation);
    });

    test('cambia entre días distintos', () {
      final signatures = <String>{};
      for (var d = 1; d <= 5; d++) {
        final p = DailyPredictionService.predict(
          userId: 'u1',
          date: DateTime(2026, 8, d),
          profile: _profile(),
        );
        signatures.add(_signature(p));
      }
      expect(signatures.length, greaterThanOrEqualTo(2));
    });

    test('usuarios distintos reciben predicciones independientes', () {
      final date = DateTime(2026, 8, 7);
      final p1 = DailyPredictionService.predict(
        userId: 'u1',
        date: date,
        profile: _profile(),
      );
      final p2 = DailyPredictionService.predict(
        userId: 'u2',
        date: date,
        profile: _profile(),
      );
      expect(p1.workout.exercises, isNot(equals(p2.workout.exercises)));
    });

    test('excluye alergias de la comida predicha', () {
      final profile = _profile().copyWith(allergies: ['Huevo']);
      final date = DateTime(2026, 8, 7);
      final p = DailyPredictionService.predict(
        userId: 'u1',
        date: date,
        profile: profile,
      );
      final names = p.meals
          .expand((m) => m.foods)
          .map((f) => f.name.toLowerCase())
          .toList();
      expect(names.where((n) => n.contains('huevo')), isEmpty);
    });

    test('excluye alimentos a evitar por condición', () {
      const condition = HealthCondition(
        id: 'test_avoid',
        name: 'Evitar pollo',
        description: '',
        type: ConditionType.other,
        avoidFoods: ['Pollo'],
      );
      final profile = _profile();
      final date = DateTime(2026, 8, 7);
      final p = DailyPredictionService.predict(
        userId: 'u1',
        date: date,
        profile: profile,
        conditions: [condition],
      );
      final names = p.meals
          .expand((m) => m.foods)
          .map((f) => f.name.toLowerCase())
          .toList();
      expect(names.where((n) => n.contains('pollo')), isEmpty);
    });

    test('las porciones están dentro del rango saludable (0.5–2.0)', () {
      final p = DailyPredictionService.predict(
        userId: 'u1',
        date: DateTime(2026, 8, 7),
        profile: _profile(),
      );
      for (final meal in p.meals) {
        for (final food in meal.foods) {
          expect(food.portions, inInclusiveRange(0.5, 2.0));
          expect(food.calories, greaterThan(0));
        }
      }
    });

    test('no repite alimentos del historial reciente', () {
      final p = DailyPredictionService.predict(
        userId: 'u1',
        date: DateTime(2026, 8, 7),
        profile: _profile(),
        recentFoodNames: ['Pollo', 'Plátano'],
      );
      final names = p.meals
          .expand((m) => m.foods)
          .map((f) => f.name.toLowerCase())
          .toList();
      expect(names.where((n) => n.contains('pollo')), isEmpty);
      expect(names.where((n) => n.contains('platano')), isEmpty);
    });
  });
}
