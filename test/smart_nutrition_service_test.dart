import 'package:flutter_test/flutter_test.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/services/smart_nutrition_service.dart';

UserProfile _profile({
  NutritionGoal goal = NutritionGoal.loseWeight,
  List<String> allergies = const [],
}) => UserProfile(
  id: 'test-user',
  username: 'Test',
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
  birthDate: DateTime(1995),
  gender: Gender.female,
  heightCm: 165,
  weightKg: 65,
  activityLevel: ActivityLevel.moderatelyActive,
  nutritionGoal: goal,
  allergies: allergies,
);

void main() {
  group('SmartNutritionService.getAllFoods', () {
    test('devuelve alimentos y cachea la lista (misma instancia)', () {
      final first = SmartNutritionService.getAllFoods();
      final second = SmartNutritionService.getAllFoods();
      expect(first, isNotEmpty);
      expect(identical(first, second), isTrue);
    });

    test('todas las categorías del Plato del Bien Comer están presentes', () {
      final foods = SmartNutritionService.getAllFoods();
      final categories = foods.map((f) => f.category).toSet();
      expect(categories, containsAll(['fruta', 'verdura', 'cereal']));
    });
  });

  group('SmartNutritionService.getFoodDatabaseStats', () {
    test(
      'el total coincide con getAllFoods y las categorías suman el total',
      () {
        final stats = SmartNutritionService.getFoodDatabaseStats();
        final total = SmartNutritionService.getAllFoods().length;
        expect(stats['total'], total);
        final sum =
            (stats['frutas'] as int) +
            (stats['verduras'] as int) +
            (stats['cereales'] as int) +
            (stats['animales'] as int) +
            (stats['leguminosas'] as int);
        expect(sum, total);
      },
    );
  });

  group('SmartNutritionService.getFoodFacts', () {
    test('devuelve los 45 datos curiosos con contenido no vacío', () {
      final facts = SmartNutritionService.getFoodFacts();
      expect(facts, hasLength(45));
      expect(facts.every((f) => f.title.trim().isNotEmpty), isTrue);
      expect(facts.every((f) => f.fact.trim().isNotEmpty), isTrue);
    });
  });

  group('SmartNutritionService.getNutritionTips', () {
    test('devuelve los 12 tips con contenido no vacío', () {
      final tips = SmartNutritionService.getNutritionTips();
      expect(tips, hasLength(12));
      expect(tips.every((t) => t.title.trim().isNotEmpty), isTrue);
      expect(tips.every((t) => t.description.trim().isNotEmpty), isTrue);
    });
  });

  group('SmartNutritionService.generateMealPlan', () {
    test('genera las 4 comidas con alimentos y calorías positivas', () {
      final plan = SmartNutritionService.generateMealPlan(
        profile: _profile(),
        conditions: const [],
        targetCalories: 2000,
      );
      expect(plan.breakfast, isNotEmpty);
      expect(plan.lunch, isNotEmpty);
      expect(plan.dinner, isNotEmpty);
      expect(plan.snacks, isNotEmpty);
      expect(plan.totalCalories, greaterThan(0));
      expect(plan.macros.keys, containsAll(['protein', 'carbs', 'fat']));
    });

    test('respeta las alergias del perfil al elegir alimentos', () {
      final plan = SmartNutritionService.generateMealPlan(
        profile: _profile(allergies: ['Cacahuate']),
        conditions: const [],
        targetCalories: 2000,
      );
      final allFoods = [
        ...plan.breakfast,
        ...plan.lunch,
        ...plan.dinner,
        ...plan.snacks,
      ].map((m) => m.food.name.toLowerCase());
      expect(allFoods.any((name) => name.contains('cacahuate')), isFalse);
    });

    test('los macros del plan corresponden a las calorías objetivo', () {
      final plan = SmartNutritionService.generateMealPlan(
        profile: _profile(goal: NutritionGoal.gainMuscle),
        conditions: const [],
        targetCalories: 2400,
      );
      expect(plan.macros['protein'], closeTo(210.0, 0.001));
      expect(plan.macros['carbs'], closeTo(240.0, 0.001));
      expect(plan.macros['fat'], closeTo(66.667, 0.001));
    });
  });

  group('SmartNutritionService.getRecommendedFoods', () {
    test('devuelve sugerencias ordenadas por score descendente', () {
      final suggestions = SmartNutritionService.getRecommendedFoods(
        profile: _profile(),
        conditions: const [],
      );
      expect(suggestions, isNotEmpty);
      for (var i = 1; i < suggestions.length; i++) {
        expect(
          suggestions[i - 1].score,
          greaterThanOrEqualTo(suggestions[i].score),
        );
      }
    });
  });

  group('SmartNutritionService.getFoodsToAvoid', () {
    test('sin condiciones ni alergias no hay alimentos a evitar', () {
      final avoid = SmartNutritionService.getFoodsToAvoid(
        profile: _profile(),
        conditions: const [],
      );
      expect(avoid, isEmpty);
    });
  });
}
