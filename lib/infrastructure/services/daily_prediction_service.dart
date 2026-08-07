import 'dart:math';

import 'package:nutriplato/fitness/smart/smart_exercise.data.dart';
import 'package:nutriplato/fitness/smart/smart_exercise.model.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/services/nutrition_calculator_service.dart';
import 'package:nutriplato/infrastructure/services/smart_nutrition_service.dart';

/// Predicción diaria: qué comer, qué entrenar y qué leer hoy.
///
/// El algoritmo es **determinista**: para el mismo (usuario, fecha) devuelve
/// siempre el mismo resultado (semilla estable), pero cambia cada día y
/// personaliza con el perfil (meta, actividad, condiciones, alergias) y con el
/// historial (comidas recientes y ejercicios recientes) para evitar repetir.
class DailyPredictionService {
  /// Fracción de calorías por comida (25/35/25/15).
  static const mealPlanFraction = {
    'Desayuno': 0.25,
    'Almuerzo': 0.35,
    'Cena': 0.25,
    'Snack': 0.15,
  };

  /// Predice el día para un usuario.
  static DailyPrediction predict({
    required String userId,
    required DateTime date,
    required UserProfile profile,
    List<HealthCondition> conditions = const [],
    List<String> recentFoodNames = const [],
    List<String> recentExerciseIds = const [],
    List<Article> articles = const [],
    int energyLevel = 3,
  }) {
    // Semilla estable por (usuario, fecha) → determinista en el día.
    final rng = Random(
      _stableHash('$userId|${date.year}-${date.month}-${date.day}'),
    );

    final weight = profile.weightKg ?? 70;
    final height = profile.heightCm ?? 165;
    final age = profile.age ?? 30;

    final bmr = NutritionCalculatorService.calculateBMR(
      weightKg: weight,
      heightCm: height,
      age: age,
      gender: profile.gender,
    );
    final tdee = NutritionCalculatorService.calculateTDEE(
      bmr: bmr,
      activityLevel: profile.activityLevel,
    );
    final targetCalories = NutritionCalculatorService.calculateTargetCalories(
      tdee: tdee,
      goal: profile.nutritionGoal,
    );

    final meals = _predictMeals(
      rng: rng,
      profile: profile,
      conditions: conditions,
      recentFoodNames: recentFoodNames,
      targetCalories: targetCalories,
    );
    final workout = _predictWorkout(
      rng: rng,
      profile: profile,
      energyLevel: energyLevel,
      recentExerciseIds: recentExerciseIds,
    );
    final read = _predictRead(
      rng: rng,
      profile: profile,
      conditions: conditions,
      articles: articles,
    );

    return DailyPrediction(
      date: date,
      meals: meals,
      workout: workout,
      read: read,
      motivation: _motivations[rng.nextInt(_motivations.length)],
    );
  }

  // ── Comida ────────────────────────────────────────────────────────────────
  static List<PredictedMeal> _predictMeals({
    required Random rng,
    required UserProfile profile,
    required List<HealthCondition> conditions,
    required List<String> recentFoodNames,
    required double targetCalories,
  }) {
    final allFoods = SmartNutritionService.getAllFoods();
    final recent = recentFoodNames.map(_normalize).toSet();
    final forbidden = _forbiddenTerms(conditions, profile.allergies);
    final used = <String>{};

    final mealSpecs = [
      ('Desayuno', ['cereal', 'fruta']),
      ('Almuerzo', ['animal', 'leguminosa', 'verdura']),
      ('Cena', ['verdura', 'animal', 'leguminosa']),
      ('Snack', ['fruta', 'verdura']),
    ];

    final meals = <PredictedMeal>[];
    for (final spec in mealSpecs) {
      final mealCalories = targetCalories * (mealPlanFraction[spec.$1] ?? 0.25);
      var pool = allFoods
          .where(
            (f) =>
                !_isForbidden(f, forbidden) &&
                spec.$2.contains(f.category) &&
                !used.contains(_normalize(f.name)),
          )
          .toList();
      if (pool.isEmpty) {
        pool = allFoods
            .where(
              (f) =>
                  !_isForbidden(f, forbidden) &&
                  !used.contains(_normalize(f.name)),
            )
            .toList();
      }

      // Priorizar alimentos frescos (no consumidos en los últimos días).
      final fresh =
          pool.where((f) => !recent.contains(_normalize(f.name))).toList()
            ..shuffle(rng);
      final stale =
          pool.where((f) => recent.contains(_normalize(f.name))).toList()
            ..shuffle(rng);
      final ordered = [...fresh, ...stale];

      final foods = <PredictedFood>[];
      var current = 0.0;
      for (final food in ordered) {
        if (current >= mealCalories || foods.length >= 3) break;
        final kcal = double.tryParse(food.energia) ?? 0;
        if (kcal <= 0) continue;
        final portions = ((mealCalories - current) / kcal).clamp(0.5, 2.0);
        foods.add(
          PredictedFood(
            name: food.name,
            category: food.category,
            portions: portions,
            calories: kcal * portions,
            reason: _foodReason(food, profile.nutritionGoal, conditions),
          ),
        );
        used.add(_normalize(food.name));
        current += kcal * portions;
      }

      meals.add(PredictedMeal(type: spec.$1, foods: foods, calories: current));
    }

    return meals;
  }

  // ── Ejercicio ─────────────────────────────────────────────────────────────
  static PredictedWorkout _predictWorkout({
    required Random rng,
    required UserProfile profile,
    required int energyLevel,
    required List<String> recentExerciseIds,
  }) {
    final bmi = profile.bmi;
    final weight = profile.weightKg ?? 70;
    final maxIntensity = _maxIntensityFor(
      bmi,
      profile.activityLevel,
      energyLevel,
    );

    final pool = smartExercisesLibrary.where((e) {
      if (bmi != null && !e.isSuitableForBmi(bmi)) return false;
      if (e.intensity.value > maxIntensity) return false;
      return true;
    }).toList();

    const focusOptions = [
      ('Cardio', [ExerciseCategory.cardio]),
      ('Fuerza', [ExerciseCategory.fuerza]),
      ('Core y abdomen', [ExerciseCategory.core, ExerciseCategory.movilidad]),
      (
        'Movilidad',
        [ExerciseCategory.flexibilidad, ExerciseCategory.movilidad],
      ),
      ('HIIT', [ExerciseCategory.hiit, ExerciseCategory.cardio]),
    ];
    final focus = focusOptions[rng.nextInt(focusOptions.length)];
    final recent = recentExerciseIds.toSet();

    final byFocus = pool.where((e) => focus.$2.contains(e.category)).toList();
    final fresh = byFocus.where((e) => !recent.contains(e.id)).toList()
      ..shuffle(rng);
    final selected = <SmartExercise>[...fresh.take(3)];

    final usedIds = selected.map((e) => e.id).toSet();
    final others =
        pool
            .where((e) => !usedIds.contains(e.id) && !recent.contains(e.id))
            .toList()
          ..shuffle(rng);
    selected.addAll(others.take(2));

    double estimate(SmartExercise e) {
      final base = e.metric == ExerciseMetric.seconds
          ? e.adjustedQuantity(bmi ?? 22) / 60
          : e.adjustedQuantity(bmi ?? 22) * 0.05;
      return base.clamp(1.0, 8.0);
    }

    final duration = selected.fold<double>(0, (s, e) => s + estimate(e));
    final calories = selected.fold<double>(
      0,
      (s, e) =>
          s +
          e.calculateCalories(
            weightKg: weight,
            durationSeconds: estimate(e).toInt() * 60,
          ),
    );

    final avg = selected.isEmpty
        ? 3.0
        : selected.map((e) => e.intensity.value).reduce((a, b) => a + b) /
              selected.length;
    final intensity =
        IntensityLevel.values
            .where((i) => i.value == avg.round())
            .map((i) => i.label)
            .firstOrNull ??
        'Moderada';

    final goalParts = <String>[];
    if (bmi != null) {
      goalParts.add(
        bmi >= 30
            ? 'bajo impacto para tu IMC'
            : bmi >= 25
            ? 'intensidad moderada para tu perfil'
            : 'intensidad completa para tu condición',
      );
    }
    goalParts.add('enfocado en ${focus.$1}');

    return PredictedWorkout(
      focus: focus.$1,
      durationMinutes: duration.round(),
      estimatedCalories: calories.round(),
      intensityLabel: intensity,
      exercises: selected.map((e) => e.name).toList(),
      reason: 'Rutina ${goalParts.join(' · ')}.',
    );
  }

  // ── Lectura ───────────────────────────────────────────────────────────────
  static PredictedRead _predictRead({
    required Random rng,
    required UserProfile profile,
    required List<HealthCondition> conditions,
    required List<Article> articles,
  }) {
    final facts = SmartNutritionService.getFoodFacts();
    final fact = facts.isEmpty ? null : facts[rng.nextInt(facts.length)];

    Article? article;
    if (articles.isNotEmpty) {
      final condKeys = conditions.map((c) => _normalize(c.name)).toList();
      final matched = articles
          .where(
            (a) => condKeys.any(
              (k) =>
                  _normalize(a.title).contains(k) ||
                  _normalize(a.description).contains(k),
            ),
          )
          .toList();
      final source = matched.isNotEmpty ? matched : articles;
      article = source[rng.nextInt(source.length)];
    }

    return PredictedRead(
      article: article,
      articleTitle: article?.title ?? 'Nutrición para tu día',
      articleDescription:
          article?.description ??
          'Descubre consejos prácticos de alimentación y bienestar.',
      articleTag: article?.tags.isNotEmpty == true
          ? article!.tags.first
          : 'salud',
      factTitle: fact?.title ?? 'Dato del día',
      factText: fact?.fact ?? '',
      reason: article != null
          ? 'Elegido para ti por tu perfil y tus intereses.'
          : 'Rotación diaria del algoritmo.',
    );
  }

  /// Localiza el objeto [Food] original en la base de datos por nombre
  /// (para conservar icono, color y nutrientes al agregarlo al registro).
  static Food? sourceFood(String name) {
    final target = _normalize(name);
    for (final food in SmartNutritionService.getAllFoods()) {
      if (_normalize(food.name) == target) return food;
    }
    return null;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  static Set<String> _forbiddenTerms(
    List<HealthCondition> conditions,
    List<String> allergies,
  ) {
    final set = <String>{};
    for (final c in conditions) {
      set.addAll(c.avoidFoods);
    }
    set.addAll(allergies);
    return set;
  }

  static bool _isForbidden(Food food, Set<String> terms) {
    if (terms.isEmpty) return false;
    final name = _normalize(food.name);
    return terms.any((t) => name.contains(_normalize(t)));
  }

  static String _foodReason(
    Food food,
    NutritionGoal goal,
    List<HealthCondition> conditions,
  ) {
    final name = _normalize(food.name);
    for (final c in conditions) {
      if (c.recommendedFoods.any((t) => name.contains(_normalize(t)))) {
        return 'Recomendado para ${c.name}';
      }
    }
    final kcal = double.tryParse(food.energia) ?? 0;
    final protein = double.tryParse(food.proteina) ?? 0;
    switch (goal) {
      case NutritionGoal.loseWeight:
      case NutritionGoal.loseWeightFast:
        if (kcal < 80) return 'Bajo en calorías';
        break;
      case NutritionGoal.gainMuscle:
        if (protein > 10) return 'Alto en proteína';
        break;
      case NutritionGoal.gainWeight:
        if (kcal > 150) return 'Aporta energía';
        break;
      case NutritionGoal.maintainWeight:
        break;
    }
    return 'Fuente de nutrientes';
  }

  static int _maxIntensityFor(
    double? bmi,
    ActivityLevel level,
    int energyLevel,
  ) {
    final bmiCap = bmi == null
        ? 5
        : bmi >= 35
        ? 2
        : bmi >= 30
        ? 3
        : bmi >= 25
        ? 4
        : 5;
    final levelCap = level == ActivityLevel.sedentary
        ? 3
        : level == ActivityLevel.lightlyActive
        ? 4
        : 5;
    final energyCap = energyLevel <= 1
        ? 2
        : energyLevel == 2
        ? 3
        : energyLevel >= 4
        ? 5
        : 4;
    return min(min(bmiCap, levelCap), energyCap);
  }

  /// Hash FNV-1a estable (independiente del run) para semillas deterministas.
  static int _stableHash(String input) {
    var hash = 0x811c9dc5;
    for (final code in input.codeUnits) {
      hash ^= code;
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    return hash;
  }

  static String _normalize(String text) => text
      .toLowerCase()
      .replaceAll('á', 'a')
      .replaceAll('é', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ú', 'u')
      .replaceAll('ñ', 'n');

  static const _motivations = [
    'Pequeños pasos de hoy construyen tu mejor versión.',
    'Tu cuerpo trabaja mejor cuando lo escuchas.',
    'Hoy es el día perfecto para un buen hábito.',
    'Come bien, muévete y descansa: ese es el plan.',
    'Cada elección de hoy es una inversión en tu salud.',
  ];
}

/// Predicción completa de un día.
class DailyPrediction {
  final DateTime date;
  final List<PredictedMeal> meals;
  final PredictedWorkout workout;
  final PredictedRead read;
  final String motivation;

  const DailyPrediction({
    required this.date,
    required this.meals,
    required this.workout,
    required this.read,
    required this.motivation,
  });
}

/// Una comida con sus alimentos predichos.
class PredictedMeal {
  final String type; // Desayuno, Almuerzo, Cena, Snack
  final List<PredictedFood> foods;
  final double calories;

  const PredictedMeal({
    required this.type,
    required this.foods,
    required this.calories,
  });
}

/// Alimento predicho con su porción.
class PredictedFood {
  final String name;
  final String category;
  final double portions;
  final double calories;
  final String reason;

  const PredictedFood({
    required this.name,
    required this.category,
    required this.portions,
    required this.calories,
    required this.reason,
  });
}

/// Ejercicio predicho.
class PredictedWorkout {
  final String focus;
  final int durationMinutes;
  final int estimatedCalories;
  final String intensityLabel;
  final List<String> exercises;
  final String reason;

  const PredictedWorkout({
    required this.focus,
    required this.durationMinutes,
    required this.estimatedCalories,
    required this.intensityLabel,
    required this.exercises,
    required this.reason,
  });
}

/// Lectura predicha (artículo + dato curioso).
class PredictedRead {
  final Article? article;
  final String articleTitle;
  final String articleDescription;
  final String articleTag;
  final String factTitle;
  final String factText;
  final String reason;

  const PredictedRead({
    this.article,
    required this.articleTitle,
    required this.articleDescription,
    required this.articleTag,
    required this.factTitle,
    required this.factText,
    required this.reason,
  });
}
