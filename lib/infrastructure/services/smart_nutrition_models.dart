import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';

/// Dato curioso sobre un alimento
class FoodFact {
  final String title;
  final String fact;
  final String? source;
  final IconData icon;
  final Color color;

  const FoodFact({
    required this.title,
    required this.fact,
    this.source,
    required this.icon,
    required this.color,
  });
}

/// Sugerencia de alimento
class FoodSuggestion {
  final Food food;
  final String reason;
  final double score; // 0-100
  final List<String> benefits;
  final SuggestionType type;

  const FoodSuggestion({
    required this.food,
    required this.reason,
    required this.score,
    required this.benefits,
    required this.type,
  });
}

enum SuggestionType { recommended, alternative, avoid, limitConsumption }

/// Plan de comidas diario
class DailyMealPlan {
  final DateTime date;
  final List<MealSuggestion> breakfast;
  final List<MealSuggestion> lunch;
  final List<MealSuggestion> dinner;
  final List<MealSuggestion> snacks;
  final double totalCalories;
  final Map<String, double> macros;

  const DailyMealPlan({
    required this.date,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snacks,
    required this.totalCalories,
    required this.macros,
  });
}

class MealSuggestion {
  final Food food;
  final double portions;
  final String preparationTip;
  final double calories;

  const MealSuggestion({
    required this.food,
    required this.portions,
    required this.preparationTip,
    required this.calories,
  });
}

/// Tip de nutrición
class NutritionTip {
  final String title;
  final String description;
  final String category;
  final IconData icon;
  final Color color;

  const NutritionTip({
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
    required this.color,
  });
}
