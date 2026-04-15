import 'package:flutter/material.dart';

/// Categoría principal del ejercicio
enum ExerciseCategory {
  cardio('Cardio', Icons.favorite, Color(0xFFFF6B6B)),
  fuerza('Fuerza', Icons.fitness_center, Color(0xFF4DABF7)),
  flexibilidad('Flexibilidad', Icons.self_improvement, Color(0xFF51CF66)),
  hiit('HIIT', Icons.bolt, Color(0xFFFF8C00)),
  core('Core', Icons.circle, Color(0xFFFFA726)),
  movilidad('Movilidad', Icons.accessibility_new, Color(0xFF845EC2));

  final String label;
  final IconData icon;
  final Color color;
  const ExerciseCategory(this.label, this.icon, this.color);
}

/// Grupos musculares trabajados
enum MuscleGroup {
  pecho,
  espalda,
  hombros,
  biceps,
  triceps,
  abdomen,
  gluteos,
  cuadriceps,
  isquiotibiales,
  pantorrillas,
  cuerpoCompleto,
}

/// Nivel de intensidad (mapea a rango de BMI y condición física)
enum IntensityLevel {
  muy_baja(1, 'Muy baja', Color(0xFF51CF66)),
  baja(2, 'Baja', Color(0xFF94D82D)),
  moderada(3, 'Moderada', Color(0xFFFFA726)),
  alta(4, 'Alta', Color(0xFFFF6B6B)),
  muy_alta(5, 'Muy alta', Color(0xFFE03131));

  final int value;
  final String label;
  final Color color;
  const IntensityLevel(this.value, this.label, this.color);
}

/// Tipo de medición del ejercicio
enum ExerciseMetric { reps, seconds, distance }

/// Posición corporal para el SVG guide
enum BodyPosition { standing, lying, sitting, kneeling, plank }

/// Un paso del ejercicio con su posición SVG
class ExerciseStep {
  final String instruction;
  final BodyPosition bodyPosition;
  final bool isStartPosition;

  const ExerciseStep({
    required this.instruction,
    required this.bodyPosition,
    this.isStartPosition = false,
  });
}

/// Modelo completo de un ejercicio inteligente
class SmartExercise {
  final String id;
  final String name;
  final String description;
  final ExerciseCategory category;
  final List<MuscleGroup> muscleGroups;
  final IntensityLevel intensity;
  final ExerciseMetric metric;
  final int baseQuantity; // reps o segundos base
  final double metValue; // MET (Metabolic Equivalent) para cálculo de calorías
  final List<ExerciseStep> steps;
  final List<String> tips;
  final List<String> contraindications; // cuándo NO hacerlo
  final double? maxBmiRecommended; // null = sin límite
  final double? minBmiRequired; // null = sin mínimo
  final bool requiresEquipment;
  final String? equipment;

  const SmartExercise({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.muscleGroups,
    required this.intensity,
    required this.metric,
    required this.baseQuantity,
    required this.metValue,
    required this.steps,
    this.tips = const [],
    this.contraindications = const [],
    this.maxBmiRecommended,
    this.minBmiRequired,
    this.requiresEquipment = false,
    this.equipment,
  });

  /// Calcula calorías quemadas (kcal)
  double calculateCalories({
    required double weightKg,
    required int durationSeconds,
  }) {
    // Fórmula: MET × peso_kg × tiempo_horas
    return metValue * weightKg * (durationSeconds / 3600);
  }

  /// Ajusta la cantidad según BMI del usuario
  int adjustedQuantity(double bmi) {
    if (bmi >= 30) return (baseQuantity * 0.6).round().clamp(3, baseQuantity);
    if (bmi >= 25) return (baseQuantity * 0.8).round().clamp(5, baseQuantity);
    if (bmi < 18.5) return (baseQuantity * 0.9).round();
    return baseQuantity;
  }

  bool isSuitableForBmi(double bmi) {
    if (maxBmiRecommended != null && bmi > maxBmiRecommended!) return false;
    if (minBmiRequired != null && bmi < minBmiRequired!) return false;
    return true;
  }
}

/// Sensaciones post-entrenamiento (1–5 cada una)
class WorkoutMood {
  final int energia; // ¿Cómo fue tu nivel de energía?
  final int esfuerzo; // ¿Qué tan intenso fue el esfuerzo?
  final int competencia; // ¿Te sentiste capaz y seguro?
  final int variedad; // ¿Disfrutaste la variedad de ejercicios?
  final int potencia; // ¿Sentiste potencia y fuerza?

  const WorkoutMood({
    this.energia = 3,
    this.esfuerzo = 3,
    this.competencia = 3,
    this.variedad = 3,
    this.potencia = 3,
  });

  double get average =>
      (energia + esfuerzo + competencia + variedad + potencia) / 5.0;

  Map<String, dynamic> toJson() => {
        'energia': energia,
        'esfuerzo': esfuerzo,
        'competencia': competencia,
        'variedad': variedad,
        'potencia': potencia,
      };

  factory WorkoutMood.fromJson(Map<String, dynamic> json) => WorkoutMood(
        energia: (json['energia'] as num? ?? 3).toInt(),
        esfuerzo: (json['esfuerzo'] as num? ?? 3).toInt(),
        competencia: (json['competencia'] as num? ?? 3).toInt(),
        variedad: (json['variedad'] as num? ?? 3).toInt(),
        potencia: (json['potencia'] as num? ?? 3).toInt(),
      );
}

/// Rutina completa generada por el sistema inteligente
class SmartWorkout {
  final String id;
  final String name;
  final String description;
  final List<SmartExercise> exercises;
  final int totalDurationMinutes;
  final double estimatedCalories;
  final IntensityLevel overallIntensity;
  final List<Color> gradients;
  final String reasoning; // Por qué se recomendó esta rutina

  const SmartWorkout({
    required this.id,
    required this.name,
    this.description = '',
    required this.exercises,
    required this.totalDurationMinutes,
    required this.estimatedCalories,
    required this.overallIntensity,
    required this.gradients,
    this.reasoning = '',
  });
}

/// Historial de un ejercicio completado
class WorkoutHistoryEntry {
  final String workoutId;
  final String workoutName;
  final List<String> exerciseIds;
  final DateTime completedAt;
  final double caloriesBurned;
  final int durationSeconds;
  final WorkoutMood? mood;

  const WorkoutHistoryEntry({
    required this.workoutId,
    this.workoutName = '',
    this.exerciseIds = const [],
    required this.completedAt,
    required this.caloriesBurned,
    required this.durationSeconds,
    this.mood,
  });

  Map<String, dynamic> toJson() => {
        'workoutId': workoutId,
        'workoutName': workoutName,
        'exerciseIds': exerciseIds,
        'completedAt': completedAt.toIso8601String(),
        'caloriesBurned': caloriesBurned,
        'durationSeconds': durationSeconds,
        if (mood != null) 'mood': mood!.toJson(),
      };

  factory WorkoutHistoryEntry.fromJson(Map<String, dynamic> json) =>
      WorkoutHistoryEntry(
        workoutId: json['workoutId'],
        workoutName: json['workoutName'] ?? '',
        exerciseIds: (json['exerciseIds'] as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList(),
        completedAt: DateTime.parse(json['completedAt']),
        caloriesBurned: (json['caloriesBurned'] as num).toDouble(),
        durationSeconds: json['durationSeconds'],
        mood: json['mood'] != null
            ? WorkoutMood.fromJson(json['mood'] as Map<String, dynamic>)
            : null,
      );
}
