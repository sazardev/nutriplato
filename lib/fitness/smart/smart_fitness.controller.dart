import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nutriplato/fitness/smart/smart_exercise.model.dart';
import 'package:nutriplato/fitness/smart/smart_exercise.data.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';

const _kHistoryKey = 'smart_workout_history';

class SmartFitnessController extends GetxController {
  // ── Estado reactivo ──────────────────────────────────────────────────────
  final recommendedWorkouts = <SmartWorkout>[].obs;
  final allExercises = <SmartExercise>[].obs;
  final workoutHistory = <WorkoutHistoryEntry>[].obs;
  final selectedCategory = Rxn<ExerciseCategory>();
  final isLoading = false.obs;
  final todayCaloriesBurned = 0.0.obs;

  // ── Filtros personalizados ────────────────────────────────────────────────
  final customDuration = 20.obs; // minutos
  final customExerciseCount = 5.obs; // número de ejercicios
  final customTargetCalories = 200.0.obs;
  // Nivel de energía pre-entrenamiento (1=muy cansado … 5=lleno de energía)
  final energyLevel = 3.obs;

  UserProfile? _profile;

  // ── Ciclo de vida ─────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    allExercises.assignAll(smartExercisesLibrary);
    _loadHistory();
  }

  /// Actualiza el perfil y regenera recomendaciones.
  void refreshWithProfile(UserProfile profile) {
    _profile = profile;
    _generateRecommendations();
    dev.log('Perfil actualizado → recomendaciones regeneradas',
        name: 'NutriPlato|SmartFitness');
  }

  /// Actualiza el nivel de energía y regenera recomendaciones.
  void updateEnergyLevel(int level) {
    energyLevel.value = level.clamp(1, 5);
    _generateRecommendations();
    dev.log('Nivel de energía → ${energyLevel.value}',
        name: 'NutriPlato|SmartFitness');
  }

  // ── Recomendaciones ───────────────────────────────────────────────────────
  void _generateRecommendations() {
    final profile = _profile;
    if (profile == null) {
      dev.log('Sin perfil — usando recomendaciones genéricas',
          name: 'NutriPlato|SmartFitness');
      recommendedWorkouts.assignAll(_genericWorkouts());
      return;
    }

    final bmi = _calcBmi(profile);
    final goal = profile.nutritionGoal;
    final level = profile.activityLevel;

    dev.log(
        'Generando workouts: BMI=${bmi?.toStringAsFixed(1)}, goal=${goal.name}, level=${level.name}',
        name: 'NutriPlato|SmartFitness');

    final lastFive =
        workoutHistory.take(5).expand((e) => e.exerciseIds).toSet();

    final workouts = <SmartWorkout>[
      _buildWorkout(
        id: 'rec_principal',
        bmi: bmi,
        goal: goal,
        level: level,
        recentIds: lastFive,
        variant: _WorkoutVariant.principal,
      ),
      _buildWorkout(
        id: 'rec_cardio',
        bmi: bmi,
        goal: goal,
        level: level,
        recentIds: lastFive,
        variant: _WorkoutVariant.cardioFocus,
      ),
      _buildWorkout(
        id: 'rec_fuerza',
        bmi: bmi,
        goal: goal,
        level: level,
        recentIds: lastFive,
        variant: _WorkoutVariant.fuerzaFocus,
      ),
      _buildWorkout(
        id: 'rec_core',
        bmi: bmi,
        goal: goal,
        level: level,
        recentIds: lastFive,
        variant: _WorkoutVariant.coreFocus,
      ),
      _buildWorkout(
        id: 'rec_flex',
        bmi: bmi,
        goal: goal,
        level: level,
        recentIds: lastFive,
        variant: _WorkoutVariant.flexibilidad,
      ),
      _buildWorkout(
        id: 'rec_hiit',
        bmi: bmi,
        goal: goal,
        level: level,
        recentIds: lastFive,
        variant: _WorkoutVariant.hiitBlast,
      ),
      _buildWorkout(
        id: 'rec_matutino',
        bmi: bmi,
        goal: goal,
        level: level,
        recentIds: lastFive,
        variant: _WorkoutVariant.matutino,
      ),
      _buildWorkout(
        id: 'rec_quema',
        bmi: bmi,
        goal: goal,
        level: level,
        recentIds: lastFive,
        variant: _WorkoutVariant.quemaGrasa,
      ),
    ];

    recommendedWorkouts.assignAll(workouts);
  }

  SmartWorkout _buildWorkout({
    required String id,
    required double? bmi,
    required NutritionGoal goal,
    required ActivityLevel level,
    required Set<String> recentIds,
    required _WorkoutVariant variant,
  }) {
    final maxIntensity = _maxIntensityFor(bmi, level);
    var pool = smartExercisesLibrary.where((e) {
      if (bmi != null && !e.isSuitableForBmi(bmi)) return false;
      if (e.intensity.value > maxIntensity) return false;
      return true;
    }).toList();

    // Separar listas por tipo
    final cardio =
        pool.where((e) => e.category == ExerciseCategory.cardio).toList();
    final fuerza =
        pool.where((e) => e.category == ExerciseCategory.fuerza).toList();
    final hiit = pool
        .where((e) => e.category == ExerciseCategory.hiit && maxIntensity >= 4)
        .toList();
    final core =
        pool.where((e) => e.category == ExerciseCategory.core).toList();
    final flex = pool
        .where((e) =>
            e.category == ExerciseCategory.flexibilidad ||
            e.category == ExerciseCategory.movilidad)
        .toList();

    List<SmartExercise> selected = [];

    switch (variant) {
      case _WorkoutVariant.principal:
        selected = _pickFor(goal, cardio, fuerza, hiit, core, flex, recentIds);
        break;
      case _WorkoutVariant.cardioFocus:
        selected = _pickCardio(cardio, hiit, flex, recentIds);
        break;
      case _WorkoutVariant.fuerzaFocus:
        selected = _pickFuerza(fuerza, core, flex, recentIds);
        break;
      case _WorkoutVariant.coreFocus:
        selected = [
          ..._pickN(core, 4, recentIds),
          ..._pickN(flex, 2, recentIds),
        ];
        break;
      case _WorkoutVariant.flexibilidad:
        selected = [
          ..._pickN(flex, 4, recentIds),
          ..._pickN(core, 2, recentIds),
        ];
        break;
      case _WorkoutVariant.hiitBlast:
        selected = [
          ..._pickN(hiit.isNotEmpty ? hiit : cardio, 3, recentIds),
          ..._pickN(cardio, 2, recentIds),
          ..._pickN(core, 1, recentIds),
        ];
        break;
      case _WorkoutVariant.matutino:
        // Baja-moderada intensidad: activación gentil
        selected = [
          ..._pickN(flex, 2, recentIds),
          ..._pickN(cardio, 2, recentIds),
          ..._pickN(core, 1, recentIds),
          ..._pickN(fuerza, 1, recentIds),
        ];
        break;
      case _WorkoutVariant.quemaGrasa:
        selected = [
          ..._pickN(cardio, 3, recentIds),
          ..._pickN(hiit.isNotEmpty ? hiit : cardio, 2, recentIds),
          ..._pickN(core, 1, recentIds),
        ];
        break;
    }

    selected = selected.take(6).toList();

    final weightKg = _profile?.weightKg ?? 70;
    final duration =
        selected.fold<double>(0, (sum, e) => sum + _estimateDuration(e, bmi));
    final calories = selected.fold<double>(
        0,
        (sum, e) =>
            sum +
            e.calculateCalories(
                weightKg: weightKg,
                durationSeconds: _estimateDuration(e, bmi).toInt() * 60));

    return SmartWorkout(
      id: id,
      name: variant.label,
      exercises: selected,
      totalDurationMinutes: duration.round(),
      estimatedCalories: calories,
      overallIntensity: _calcOverall(selected),
      gradients: variant.gradients,
      reasoning: _buildReasoning(bmi, goal, level, variant),
    );
  }

  List<SmartExercise> _pickFor(
    NutritionGoal goal,
    List<SmartExercise> cardio,
    List<SmartExercise> fuerza,
    List<SmartExercise> hiit,
    List<SmartExercise> core,
    List<SmartExercise> flex,
    Set<String> recentIds,
  ) {
    switch (goal) {
      case NutritionGoal.loseWeight:
      case NutritionGoal.loseWeightFast:
        return [
          ..._pickN(cardio, 2, recentIds),
          ..._pickN(hiit.isNotEmpty ? hiit : cardio, 1, recentIds),
          ..._pickN(core, 1, recentIds),
          ..._pickN(flex, 1, recentIds),
        ];
      case NutritionGoal.gainMuscle:
        return [
          ..._pickN(fuerza, 3, recentIds),
          ..._pickN(core, 2, recentIds),
          ..._pickN(flex, 1, recentIds),
        ];
      case NutritionGoal.gainWeight:
        return [
          ..._pickN(fuerza, 4, recentIds),
          ..._pickN(cardio, 1, recentIds),
          ..._pickN(flex, 1, recentIds),
        ];
      case NutritionGoal.maintainWeight:
        return [
          ..._pickN(cardio, 2, recentIds),
          ..._pickN(fuerza, 2, recentIds),
          ..._pickN(core, 1, recentIds),
          ..._pickN(flex, 1, recentIds),
        ];
    }
  }

  List<SmartExercise> _pickCardio(
    List<SmartExercise> cardio,
    List<SmartExercise> hiit,
    List<SmartExercise> flex,
    Set<String> recentIds,
  ) {
    return [
      ..._pickN(cardio, 3, recentIds),
      ..._pickN(hiit.isNotEmpty ? hiit : cardio, 2, recentIds),
      ..._pickN(flex, 1, recentIds),
    ];
  }

  List<SmartExercise> _pickFuerza(
    List<SmartExercise> fuerza,
    List<SmartExercise> core,
    List<SmartExercise> flex,
    Set<String> recentIds,
  ) {
    return [
      ..._pickN(fuerza, 3, recentIds),
      ..._pickN(core, 2, recentIds),
      ..._pickN(flex, 1, recentIds),
    ];
  }

  List<SmartExercise> _pickN(
      List<SmartExercise> pool, int n, Set<String> recentIds) {
    final preferred = pool.where((e) => !recentIds.contains(e.id)).toList()
      ..shuffle();
    final fallback = pool.where((e) => recentIds.contains(e.id)).toList()
      ..shuffle();
    final merged = [...preferred, ...fallback];
    return merged.take(n).toList();
  }

  IntensityLevel _calcOverall(List<SmartExercise> exercises) {
    if (exercises.isEmpty) return IntensityLevel.baja;
    final avg =
        exercises.map((e) => e.intensity.value).reduce((a, b) => a + b) /
            exercises.length;
    return IntensityLevel.values.firstWhere((i) => i.value == avg.round(),
        orElse: () => IntensityLevel.moderada);
  }

  int _maxIntensityFor(double? bmi, ActivityLevel level) {
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
    // Ajuste por nivel de energía pre-entrenamiento
    final el = energyLevel.value;
    final energyCap = el <= 1
        ? 2
        : el == 2
            ? 3
            : el >= 4
                ? 5
                : 4;
    final baseCap = bmiCap < levelCap ? bmiCap : levelCap;
    return baseCap < energyCap ? baseCap : energyCap;
  }

  double _estimateDuration(SmartExercise e, double? bmi) {
    final base = e.metric == ExerciseMetric.seconds
        ? e.adjustedQuantity(bmi ?? 22) / 60
        : e.adjustedQuantity(bmi ?? 22) * 0.05;
    return base.clamp(1.0, 8.0);
  }

  String _buildReasoning(
    double? bmi,
    NutritionGoal goal,
    ActivityLevel level,
    _WorkoutVariant variant,
  ) {
    final parts = <String>[];
    if (bmi != null) {
      if (bmi >= 30) {
        parts.add('Ejercicios de bajo impacto adaptados a tu IMC.');
      } else if (bmi >= 25) {
        parts.add('Intensidad moderada ajustada a tu perfil.');
      } else {
        parts.add('Ejercicios de intensidad completa para tu condición.');
      }
    }
    parts.add('Orientado a tu objetivo: ${goal.label}.');
    if (level == ActivityLevel.sedentary) {
      parts.add('Ideal para retomar la actividad gradualmente.');
    }
    return parts.join(' ');
  }

  List<SmartWorkout> _genericWorkouts() {
    final all = _WorkoutVariant.values;
    return all.map((v) {
      final pool = smartExercisesLibrary
          .where((e) => e.intensity.value <= 3)
          .toList()
        ..shuffle();
      return SmartWorkout(
        id: 'generic_${v.name}',
        name: v.label,
        exercises: pool.take(5).toList(),
        totalDurationMinutes: 20,
        estimatedCalories: 150.0,
        overallIntensity: IntensityLevel.moderada,
        gradients: v.gradients,
        reasoning: 'Rutina balanceada para comenzar.',
      );
    }).toList();
  }

  // ── Workout aleatorio y personalizado ────────────────────────────────────
  SmartWorkout generateRandomWorkout() {
    final bmi = _profile != null ? _calcBmi(_profile!) : null;
    final allVariants = _WorkoutVariant.values.toList()..shuffle();
    final variant = allVariants.first;
    final goal = _profile?.nutritionGoal ?? NutritionGoal.maintainWeight;
    final level = _profile?.activityLevel ?? ActivityLevel.lightlyActive;
    final recentIds =
        workoutHistory.take(5).expand((e) => e.exerciseIds).toSet();
    final w = _buildWorkout(
      id: 'random_${DateTime.now().millisecondsSinceEpoch}',
      bmi: bmi,
      goal: goal,
      level: level,
      recentIds: recentIds,
      variant: variant,
    );
    dev.log('Workout aleatorio generado: ${w.name}',
        name: 'NutriPlato|SmartFitness');
    return w;
  }

  SmartWorkout generateCustomWorkout({
    required int durationMinutes,
    required int exerciseCount,
    required double targetCalories,
  }) {
    final bmi = _profile != null ? _calcBmi(_profile!) : null;
    final weightKg = _profile?.weightKg ?? 70;
    final maxIntensity = _maxIntensityFor(
        bmi, _profile?.activityLevel ?? ActivityLevel.lightlyActive);

    var pool = smartExercisesLibrary.where((e) {
      if (bmi != null && !e.isSuitableForBmi(bmi)) return false;
      if (e.intensity.value > maxIntensity) return false;
      return true;
    }).toList()
      ..shuffle();

    // Si hay target de calorías, ordenar por densidad calórica
    if (targetCalories > 0) {
      pool.sort((a, b) {
        final calA =
            a.calculateCalories(weightKg: weightKg, durationSeconds: 120);
        final calB =
            b.calculateCalories(weightKg: weightKg, durationSeconds: 120);
        return calB.compareTo(calA);
      });
    }

    final selected = pool.take(exerciseCount).toList();
    final duration =
        selected.fold<double>(0, (s, e) => s + _estimateDuration(e, bmi));
    final calories = selected.fold<double>(
        0,
        (s, e) =>
            s +
            e.calculateCalories(
                weightKg: weightKg,
                durationSeconds: _estimateDuration(e, bmi).toInt() * 60));

    dev.log(
        'Custom workout: ${exerciseCount} ejercicios, ${durationMinutes}min target, '
        '${calories.toStringAsFixed(0)} kcal estimadas',
        name: 'NutriPlato|SmartFitness');

    return SmartWorkout(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Rutina personalizada',
      exercises: selected,
      totalDurationMinutes: duration.round(),
      estimatedCalories: calories,
      overallIntensity: _calcOverall(selected),
      gradients: const [Color(0xFF6C63FF), Color(0xFF48CAE4)],
      reasoning:
          '${exerciseCount} ejercicios · ~${durationMinutes} min · ~${targetCalories.toStringAsFixed(0)} kcal objetivo.',
    );
  }

  // ── Filtro por categoría ──────────────────────────────────────────────────
  List<SmartExercise> get filteredExercises {
    final cat = selectedCategory.value;
    if (cat == null) return allExercises;
    return allExercises.where((e) => e.category == cat).toList();
  }

  List<SmartExercise> exercisesForBmi({double? bmi}) {
    if (bmi == null) return allExercises;
    return allExercises.where((e) => e.isSuitableForBmi(bmi)).toList();
  }

  // ── Historial ─────────────────────────────────────────────────────────────
  Future<void> completeWorkout(SmartWorkout workout, int durationSeconds,
      {WorkoutMood? mood}) async {
    final entry = WorkoutHistoryEntry(
      workoutId: workout.id,
      workoutName: workout.name,
      exerciseIds: workout.exercises.map((e) => e.id).toList(),
      completedAt: DateTime.now(),
      caloriesBurned: workout.estimatedCalories.toDouble(),
      durationSeconds: durationSeconds,
      mood: mood,
    );
    workoutHistory.insert(0, entry);
    todayCaloriesBurned.value += entry.caloriesBurned;
    await _saveHistory();
    _generateRecommendations(); // Evitar repeticiones
    dev.log(
        'Workout completado: ${workout.name} — ${entry.caloriesBurned.toStringAsFixed(0)} kcal'
        '${mood != null ? " | mood avg=${mood.average.toStringAsFixed(1)}" : ""}',
        name: 'NutriPlato|SmartFitness');
  }

  double get weeklyCaloriesBurned {
    final cutoff = DateTime.now().subtract(const Duration(days: 7));
    return workoutHistory
        .where((e) => e.completedAt.isAfter(cutoff))
        .fold(0.0, (sum, e) => sum + e.caloriesBurned);
  }

  int get weeklyWorkoutCount {
    final cutoff = DateTime.now().subtract(const Duration(days: 7));
    return workoutHistory.where((e) => e.completedAt.isAfter(cutoff)).length;
  }

  Future<void> _loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList(_kHistoryKey) ?? [];
      final entries = raw
          .map((s) => WorkoutHistoryEntry.fromJson(
              jsonDecode(s) as Map<String, dynamic>))
          .toList();
      workoutHistory.assignAll(entries);
      _recalcTodayCalories();
      dev.log('Historial cargado: ${entries.length} entradas',
          name: 'NutriPlato|SmartFitness');
    } catch (e) {
      dev.log('Error cargando historial: $e', name: 'NutriPlato|SmartFitness');
    }
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw =
        workoutHistory.take(100).map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_kHistoryKey, raw);
  }

  void _recalcTodayCalories() {
    final today = DateTime.now();
    todayCaloriesBurned.value = workoutHistory
        .where((e) =>
            e.completedAt.year == today.year &&
            e.completedAt.month == today.month &&
            e.completedAt.day == today.day)
        .fold(0.0, (sum, e) => sum + e.caloriesBurned);
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  static double? _calcBmi(UserProfile p) {
    if (p.weightKg == null || p.heightCm == null) return null;
    final h = p.heightCm! / 100;
    return p.weightKg! / (h * h);
  }

  String bmiCategory(double bmi) {
    if (bmi < 18.5) return 'Peso bajo';
    if (bmi < 25.0) return 'Normal';
    if (bmi < 30.0) return 'Sobrepeso';
    if (bmi < 35.0) return 'Obesidad I';
    if (bmi < 40.0) return 'Obesidad II';
    return 'Obesidad III';
  }
}

enum _WorkoutVariant {
  principal('Rutina recomendada', [Color(0xFF6C63FF), Color(0xFF48CAE4)]),
  cardioFocus('Enfoque cardio', [Color(0xFFFF6B6B), Color(0xFFFF8C00)]),
  fuerzaFocus('Enfoque fuerza', [Color(0xFF4DABF7), Color(0xFF845EC2)]),
  coreFocus('Enfoque core & abdomen', [Color(0xFFFFA726), Color(0xFFFF6B6B)]),
  flexibilidad(
      'Relajación y movilidad', [Color(0xFF51CF66), Color(0xFF20C997)]),
  hiitBlast('HIIT explosivo', [Color(0xFFE03131), Color(0xFFFF8C00)]),
  matutino('Activación matutina', [Color(0xFFFFD43B), Color(0xFFFFA726)]),
  quemaGrasa('Quema grasa', [Color(0xFFFF8CC8), Color(0xFF845EC2)]);

  final String label;
  final List<Color> gradients;
  const _WorkoutVariant(this.label, this.gradients);
}
