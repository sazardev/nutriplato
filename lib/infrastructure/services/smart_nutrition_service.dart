import 'package:nutriplato/data/food/animals.dart';
import 'package:nutriplato/data/food/cereales.dart';
import 'package:nutriplato/data/food/frutas.dart';
import 'package:nutriplato/data/food/leguminosas.dart';
import 'package:nutriplato/data/food/verduras.dart';
import 'package:nutriplato/infrastructure/entities/food/cereal.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/infrastructure/entities/food/fruta.dart';
import 'package:nutriplato/infrastructure/entities/food/leguminosa.dart';
import 'package:nutriplato/infrastructure/entities/food/verdura.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/services/smart_nutrition_facts.data.dart';
import 'package:nutriplato/infrastructure/services/smart_nutrition_models.dart';
import 'package:nutriplato/infrastructure/services/smart_nutrition_tips.data.dart';

export 'smart_nutrition_models.dart';

/// Helper para obtener fibra de diferentes tipos de alimentos
double getFibraFromFood(Food food) {
  if (food is Fruta) {
    return double.tryParse(food.fibra) ?? 0;
  } else if (food is Verdura) {
    return double.tryParse(food.fibra) ?? 0;
  } else if (food is Cereal) {
    return double.tryParse(food.fibra) ?? 0;
  } else if (food is Leguminosa) {
    return double.tryParse(food.fibra) ?? 0;
  }
  return 0;
}

/// Servicio inteligente de nutricion
class SmartNutritionService {
  // Cache de todos los alimentos
  static List<Food>? _allFoods;

  /// Obtiene todos los alimentos disponibles
  static List<Food> getAllFoods() {
    if (_allFoods != null) return _allFoods!;

    _allFoods = [
      ...frutas.cast<Food>(),
      ...verduras.cast<Food>(),
      ...cereales.cast<Food>(),
      ...animals.cast<Food>(),
      ...leguminosas.cast<Food>(),
    ];

    return _allFoods!;
  }

  /// Genera datos curiosos sobre alimentos
  static List<FoodFact> getFoodFacts() {
    return buildFoodFacts();
  }

  /// Obtiene tips de nutrición
  static List<NutritionTip> getNutritionTips() {
    return buildNutritionTips();
  }

  /// Obtiene alimentos recomendados basados en el perfil
  static List<FoodSuggestion> getRecommendedFoods({
    required UserProfile profile,
    required List<HealthCondition> conditions,
    int limit = 10,
  }) {
    final allFoods = getAllFoods();
    final suggestions = <FoodSuggestion>[];

    for (final food in allFoods) {
      double score = 50.0; // Base score
      final benefits = <String>[];
      var type = SuggestionType.recommended;

      // Evaluar por condiciones de salud
      for (final condition in conditions) {
        // Verificar si debe evitarse
        if (_matchesAny(food.name, condition.avoidFoods)) {
          score -= 50;
          type = SuggestionType.avoid;
        }

        // Verificar si debe limitarse
        if (_matchesAny(food.name, condition.limitFoods)) {
          score -= 25;
          type = SuggestionType.limitConsumption;
        }

        // Verificar si es recomendado
        if (_matchesAny(food.name, condition.recommendedFoods)) {
          score += 30;
          benefits.add('Recomendado para ${condition.name}');
        }
      }

      // Evaluar por objetivo nutricional
      final calorias = double.tryParse(food.energia) ?? 0;
      final proteinas = double.tryParse(food.proteina) ?? 0;
      final fibra = getFibraFromFood(food);

      switch (profile.nutritionGoal) {
        case NutritionGoal.loseWeight:
        case NutritionGoal.loseWeightFast:
          if (calorias < 80) {
            score += 15;
            benefits.add('Bajo en calorias');
          }
          if (fibra > 3) {
            score += 10;
            benefits.add('Alto en fibra');
          }
          break;

        case NutritionGoal.gainMuscle:
          if (proteinas > 10) {
            score += 20;
            benefits.add('Alto en proteinas');
          }
          break;

        case NutritionGoal.gainWeight:
          if (calorias > 150) {
            score += 15;
            benefits.add('Buena fuente de calorias');
          }
          break;

        case NutritionGoal.maintainWeight:
          // Balance general
          if (calorias >= 50 && calorias <= 150) {
            score += 10;
            benefits.add('Calorias balanceadas');
          }
          break;
      }

      // Bonus por categoria saludable
      if (food.category == 'verdura') {
        score += 10;
        benefits.add('Verdura nutritiva');
      } else if (food.category == 'fruta') {
        score += 8;
        benefits.add('Fruta natural');
      }

      // Verificar alergias
      if (_matchesAny(food.name, profile.allergies)) {
        score = 0;
        type = SuggestionType.avoid;
      }

      if (score > 0) {
        suggestions.add(
          FoodSuggestion(
            food: food,
            reason: _generateReason(food, profile, conditions),
            score: score.clamp(0, 100),
            benefits: benefits,
            type: type,
          ),
        );
      }
    }

    // Ordenar por score y limitar
    suggestions.sort((a, b) => b.score.compareTo(a.score));
    return suggestions.take(limit).toList();
  }

  /// Obtiene alimentos a evitar
  static List<FoodSuggestion> getFoodsToAvoid({
    required UserProfile profile,
    required List<HealthCondition> conditions,
    int limit = 10,
  }) {
    final allFoods = getAllFoods();
    final suggestions = <FoodSuggestion>[];

    for (final food in allFoods) {
      final reasons = <String>[];

      // Verificar condiciones
      for (final condition in conditions) {
        if (_matchesAny(food.name, condition.avoidFoods)) {
          reasons.add('Evitar por ${condition.name}');
        }
      }

      // Verificar alergias
      if (_matchesAny(food.name, profile.allergies)) {
        reasons.add('Contiene alergeno');
      }

      if (reasons.isNotEmpty) {
        suggestions.add(
          FoodSuggestion(
            food: food,
            reason: reasons.join('. '),
            score: 0,
            benefits: [],
            type: SuggestionType.avoid,
          ),
        );
      }
    }

    return suggestions.take(limit).toList();
  }

  /// Sugiere alternativas para un alimento
  static List<FoodSuggestion> suggestAlternatives({
    required Food originalFood,
    required UserProfile profile,
    required List<HealthCondition> conditions,
    int limit = 5,
  }) {
    final allFoods = getAllFoods();
    final alternatives = <FoodSuggestion>[];

    // Buscar alimentos de la misma categoria
    final sameCategory = allFoods
        .where((f) => f.category == originalFood.category)
        .toList();

    final originalCalories = double.tryParse(originalFood.energia) ?? 0;

    for (final food in sameCategory) {
      if (food.name == originalFood.name) continue;

      double score = 50;
      final benefits = <String>[];

      // Similar en calorias
      final calories = double.tryParse(food.energia) ?? 0;
      final calorieDiff = (calories - originalCalories).abs();
      if (calorieDiff < 30) {
        score += 20;
        benefits.add('Similar en calorias');
      }

      // Verificar que no este en la lista de evitar
      bool shouldAvoid = false;
      for (final condition in conditions) {
        if (_matchesAny(food.name, condition.avoidFoods)) {
          shouldAvoid = true;
          break;
        }
        if (_matchesAny(food.name, condition.recommendedFoods)) {
          score += 25;
          benefits.add('Recomendado para tu salud');
        }
      }

      if (!shouldAvoid && !_matchesAny(food.name, profile.allergies)) {
        alternatives.add(
          FoodSuggestion(
            food: food,
            reason: 'Alternativa a ${originalFood.name}',
            score: score,
            benefits: benefits,
            type: SuggestionType.alternative,
          ),
        );
      }
    }

    alternatives.sort((a, b) => b.score.compareTo(a.score));
    return alternatives.take(limit).toList();
  }

  /// Genera un plan de comidas personalizado
  static DailyMealPlan generateMealPlan({
    required UserProfile profile,
    required List<HealthCondition> conditions,
    required double targetCalories,
  }) {
    final allFoods = getAllFoods();

    // Distribucion de calorias por comida
    final breakfastCalories = targetCalories * 0.25;
    final lunchCalories = targetCalories * 0.35;
    final dinnerCalories = targetCalories * 0.25;
    final snackCalories = targetCalories * 0.15;

    return DailyMealPlan(
      date: DateTime.now(),
      breakfast: _selectMealFoods(
        allFoods: allFoods,
        targetCalories: breakfastCalories,
        profile: profile,
        conditions: conditions,
        mealType: 'breakfast',
      ),
      lunch: _selectMealFoods(
        allFoods: allFoods,
        targetCalories: lunchCalories,
        profile: profile,
        conditions: conditions,
        mealType: 'lunch',
      ),
      dinner: _selectMealFoods(
        allFoods: allFoods,
        targetCalories: dinnerCalories,
        profile: profile,
        conditions: conditions,
        mealType: 'dinner',
      ),
      snacks: _selectMealFoods(
        allFoods: allFoods,
        targetCalories: snackCalories,
        profile: profile,
        conditions: conditions,
        mealType: 'snack',
      ),
      totalCalories: targetCalories,
      macros: _calculateMacros(targetCalories, profile.nutritionGoal),
    );
  }

  static List<MealSuggestion> _selectMealFoods({
    required List<Food> allFoods,
    required double targetCalories,
    required UserProfile profile,
    required List<HealthCondition> conditions,
    required String mealType,
  }) {
    final suggestions = <MealSuggestion>[];
    double currentCalories = 0;

    // Filtrar alimentos seguros
    final safeFoods = allFoods.where((food) {
      for (final condition in conditions) {
        if (_matchesAny(food.name, condition.avoidFoods)) return false;
      }
      if (_matchesAny(food.name, profile.allergies)) return false;
      return true;
    }).toList();

    // Preferir ciertos tipos segun la comida
    List<String> preferredCategories;
    switch (mealType) {
      case 'breakfast':
        preferredCategories = ['fruta', 'cereal'];
        break;
      case 'lunch':
        preferredCategories = ['animal', 'verdura', 'leguminosa'];
        break;
      case 'dinner':
        preferredCategories = ['verdura', 'animal', 'leguminosa'];
        break;
      default:
        preferredCategories = ['fruta', 'verdura'];
    }

    // Seleccionar alimentos
    final shuffled = List<Food>.from(safeFoods)..shuffle();

    for (final food in shuffled) {
      if (currentCalories >= targetCalories) break;

      final calories = double.tryParse(food.energia) ?? 0;
      if (calories <= 0) continue;

      // Preferir categorias adecuadas
      if (!preferredCategories.contains(food.category)) continue;

      final portions = ((targetCalories - currentCalories) / calories)
          .clamp(0.5, 2.0)
          .toDouble();

      suggestions.add(
        MealSuggestion(
          food: food,
          portions: portions,
          preparationTip: _getPreparationTip(food, mealType),
          calories: calories * portions,
        ),
      );

      currentCalories += calories * portions;

      if (suggestions.length >= 3) break;
    }

    return suggestions;
  }

  static String _getPreparationTip(Food food, String mealType) {
    final tips = {
      'fruta': [
        'Consumir fresca para mayor beneficio',
        'Combinar con yogurt natural',
        'Ideal como snack entre comidas',
      ],
      'verdura': [
        'Cocinar al vapor para conservar nutrientes',
        'Agregar un poco de aceite de oliva',
        'Combinar con proteina magra',
      ],
      'animal': [
        'Cocinar a la plancha o al horno',
        'Evitar freir para reducir grasas',
        'Acompanar con verduras frescas',
      ],
      'cereal': [
        'Preferir versiones integrales',
        'Combinar con frutas frescas',
        'Controlar el tamano de la porcion',
      ],
      'leguminosa': [
        'Remojar antes de cocinar',
        'Combinar con cereales para proteina completa',
        'Agregar hierbas para mejor digestion',
      ],
    };

    final categoryTips = tips[food.category] ?? ['Consumir con moderacion'];
    return categoryTips[DateTime.now().millisecond % categoryTips.length];
  }

  static Map<String, double> _calculateMacros(
    double calories,
    NutritionGoal goal,
  ) {
    double proteinPercent, carbPercent, fatPercent;

    switch (goal) {
      case NutritionGoal.loseWeight:
      case NutritionGoal.loseWeightFast:
        proteinPercent = 0.30;
        carbPercent = 0.40;
        fatPercent = 0.30;
        break;
      case NutritionGoal.gainMuscle:
        proteinPercent = 0.35;
        carbPercent = 0.40;
        fatPercent = 0.25;
        break;
      case NutritionGoal.gainWeight:
        proteinPercent = 0.25;
        carbPercent = 0.50;
        fatPercent = 0.25;
        break;
      default:
        proteinPercent = 0.25;
        carbPercent = 0.50;
        fatPercent = 0.25;
    }

    return {
      'protein': (calories * proteinPercent) / 4,
      'carbs': (calories * carbPercent) / 4,
      'fat': (calories * fatPercent) / 9,
    };
  }

  static bool _matchesAny(String foodName, List<String> terms) {
    final normalizedFood = _normalize(foodName);
    for (final term in terms) {
      if (normalizedFood.contains(_normalize(term))) return true;
    }
    return false;
  }

  static String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ñ', 'n');
  }

  static String _generateReason(
    Food food,
    UserProfile profile,
    List<HealthCondition> conditions,
  ) {
    final reasons = <String>[];

    // Por categoria
    switch (food.category) {
      case 'fruta':
        reasons.add('Fuente natural de vitaminas y antioxidantes');
        break;
      case 'verdura':
        reasons.add('Rico en fibra y minerales esenciales');
        break;
      case 'animal':
        reasons.add('Excelente fuente de proteina de alta calidad');
        break;
      case 'cereal':
        reasons.add('Proporciona energia de liberacion lenta');
        break;
      case 'leguminosa':
        reasons.add('Proteina vegetal y fibra en abundancia');
        break;
    }

    // Por objetivo
    switch (profile.nutritionGoal) {
      case NutritionGoal.loseWeight:
      case NutritionGoal.loseWeightFast:
        final cal = double.tryParse(food.energia) ?? 0;
        if (cal < 80) reasons.add('Bajo aporte calorico');
        break;
      case NutritionGoal.gainMuscle:
        final prot = double.tryParse(food.proteina) ?? 0;
        if (prot > 10) reasons.add('Alto contenido proteico');
        break;
      default:
        break;
    }

    return reasons.isNotEmpty ? reasons.first : 'Alimento nutritivo';
  }

  /// Obtiene estadisticas de la base de datos de alimentos
  static Map<String, dynamic> getFoodDatabaseStats() {
    final allFoods = getAllFoods();

    int frutas = 0, verduras = 0, cereales = 0, animales = 0, leguminosas = 0;

    for (final food in allFoods) {
      switch (food.category) {
        case 'fruta':
          frutas++;
          break;
        case 'verdura':
          verduras++;
          break;
        case 'cereal':
          cereales++;
          break;
        case 'animal':
          animales++;
          break;
        case 'leguminosa':
          leguminosas++;
          break;
      }
    }

    return {
      'total': allFoods.length,
      'frutas': frutas,
      'verduras': verduras,
      'cereales': cereales,
      'animales': animales,
      'leguminosas': leguminosas,
    };
  }
}
