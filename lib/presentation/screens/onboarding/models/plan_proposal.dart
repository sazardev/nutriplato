import 'package:nutriplato/infrastructure/services/nutrition_calculator_service.dart';
import 'package:nutriplato/infrastructure/services/smart_nutrition_service.dart';

/// Propuesta de plan nutricional calculada con el algoritmo real.
class PlanProposal {
  final double bmr;
  final double tdee;
  final double targetCalories;
  final MacroDistribution macros;
  final IdealWeightResult idealWeight;
  final double bmi;
  final String bmiCategory;
  final WaterRequirement water;
  final WeightGoalProjection? projection;
  final List<String> conditionNames;
  final List<String> adjustments;
  final Map<String, double> nutrientLimits;
  final DailyMealPlan mealPlan;
  final List<FoodSuggestion> recommendedFoods;
  final List<FoodSuggestion> avoidFoods;
  final Map<String, double> mealDistribution;

  const PlanProposal({
    required this.bmr,
    required this.tdee,
    required this.targetCalories,
    required this.macros,
    required this.idealWeight,
    required this.bmi,
    required this.bmiCategory,
    required this.water,
    required this.projection,
    required this.conditionNames,
    required this.adjustments,
    required this.nutrientLimits,
    required this.mealPlan,
    required this.recommendedFoods,
    required this.avoidFoods,
    required this.mealDistribution,
  });
}
