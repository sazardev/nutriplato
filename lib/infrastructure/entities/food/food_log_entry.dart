import 'package:nutriplato/infrastructure/entities/food/food.dart';

class FoodLogEntry {
  final Food food;
  final double quantity;
  final DateTime timestamp;
  final String mealType; // Desayuno, Almuerzo, Cena, Snack

  FoodLogEntry({
    required this.food,
    required this.quantity,
    required this.timestamp,
    required this.mealType,
  });

  // Cálculo de nutrientes considerando la cantidad consumida
  double get calories => double.parse(food.energia) * quantity;
  double get protein => double.parse(food.proteina) * quantity;
  double get carbs => double.parse(food.hidratosDeCarbono) * quantity;
  double get fat => double.parse(food.lipidos) * quantity;
}

class DailyFoodLog {
  final DateTime date;
  final List<FoodLogEntry> entries;

  DailyFoodLog({
    required this.date,
    required this.entries,
  });

  // Cálculo de nutrientes totales del día
  double get totalCalories =>
      entries.fold(0, (sum, entry) => sum + entry.calories);
  double get totalProtein =>
      entries.fold(0, (sum, entry) => sum + entry.protein);
  double get totalCarbs => entries.fold(0, (sum, entry) => sum + entry.carbs);
  double get totalFat => entries.fold(0, (sum, entry) => sum + entry.fat);
}
