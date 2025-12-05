import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/infrastructure/services/nutrition_calculator_service.dart';

/// Provider mejorado para el perfil completo del usuario
class UserProfileProvider extends ChangeNotifier {
  UserProfile _profile = UserProfile.create();
  List<HealthCondition> _healthConditions = [];
  List<HealthMetric> _healthMetrics = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  UserProfile get profile => _profile;
  List<HealthCondition> get healthConditions => _healthConditions;
  List<HealthMetric> get healthMetrics => _healthMetrics;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isOnboardingComplete => _profile.onboardingCompleted;
  bool get hasCompleteProfile => _profile.isProfileComplete;

  /// Carga el perfil desde almacenamiento local
  Future<void> loadProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();

      // Cargar perfil
      final profileJson = prefs.getString('user_profile');
      if (profileJson != null) {
        final profileMap = jsonDecode(profileJson);
        _profile = UserProfile.fromJson(profileMap);
      }

      // Cargar condiciones de salud del usuario
      final conditionsJson = prefs.getStringList('user_health_conditions');
      if (conditionsJson != null) {
        _healthConditions = conditionsJson.map((json) {
          final map = jsonDecode(json);
          return HealthCondition.fromJson(map);
        }).toList();
      }

      // Cargar métricas de salud
      final metricsJson = prefs.getStringList('user_health_metrics');
      if (metricsJson != null) {
        _healthMetrics = metricsJson.map((json) {
          final map = jsonDecode(json);
          return HealthMetric.fromJson(map);
        }).toList();
      }

      // Actualizar streak si es necesario
      await _updateStreak();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Error al cargar el perfil: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Guarda el perfil en almacenamiento local
  Future<void> saveProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Actualizar fecha de modificación
      _profile = _profile.copyWith(updatedAt: DateTime.now());

      // Guardar perfil
      final profileJson = jsonEncode(_profile.toJson());
      await prefs.setString('user_profile', profileJson);

      // Guardar condiciones de salud
      final conditionsJson =
          _healthConditions.map((c) => jsonEncode(c.toJson())).toList();
      await prefs.setStringList('user_health_conditions', conditionsJson);

      // Guardar métricas
      final metricsJson =
          _healthMetrics.map((m) => jsonEncode(m.toJson())).toList();
      await prefs.setStringList('user_health_metrics', metricsJson);

      notifyListeners();
    } catch (e) {
      _error = 'Error al guardar el perfil: $e';
      notifyListeners();
    }
  }

  /// Actualiza el perfil del usuario
  Future<void> updateProfile(UserProfile newProfile) async {
    _profile = newProfile;
    await saveProfile();
  }

  /// Actualiza campos específicos del perfil
  Future<void> updateProfileFields({
    String? username,
    String? email,
    DateTime? birthDate,
    Gender? gender,
    double? heightCm,
    double? weightKg,
    double? targetWeightKg,
    double? waistCm,
    double? hipCm,
    double? neckCm,
    ActivityLevel? activityLevel,
    NutritionGoal? nutritionGoal,
    List<String>? dietaryRestrictions,
    List<String>? allergies,
    bool? onboardingCompleted,
    int? onboardingStep,
  }) async {
    _profile = _profile.copyWith(
      username: username,
      email: email,
      birthDate: birthDate,
      gender: gender,
      heightCm: heightCm,
      weightKg: weightKg,
      targetWeightKg: targetWeightKg,
      waistCm: waistCm,
      hipCm: hipCm,
      neckCm: neckCm,
      activityLevel: activityLevel,
      nutritionGoal: nutritionGoal,
      dietaryRestrictions: dietaryRestrictions,
      allergies: allergies,
      onboardingCompleted: onboardingCompleted,
      onboardingStep: onboardingStep,
    );
    await saveProfile();
  }

  /// Completa el onboarding
  Future<void> completeOnboarding() async {
    _profile = _profile.copyWith(
      onboardingCompleted: true,
      onboardingStep: -1, // Completado
    );
    await saveProfile();
  }

  /// Actualiza el paso actual del onboarding
  Future<void> setOnboardingStep(int step) async {
    _profile = _profile.copyWith(onboardingStep: step);
    await saveProfile();
  }

  /// Agrega una condición de salud
  Future<void> addHealthCondition(HealthCondition condition) async {
    if (!_healthConditions.any((c) => c.id == condition.id)) {
      _healthConditions.add(condition);
      _profile = _profile.copyWith(
        healthConditionIds: [
          ..._profile.healthConditionIds,
          condition.id,
        ],
      );
      await saveProfile();
    }
  }

  /// Elimina una condición de salud
  Future<void> removeHealthCondition(String conditionId) async {
    _healthConditions.removeWhere((c) => c.id == conditionId);
    _profile = _profile.copyWith(
      healthConditionIds:
          _profile.healthConditionIds.where((id) => id != conditionId).toList(),
    );
    await saveProfile();
  }

  /// Agrega una condición de salud predefinida por ID
  Future<void> addPredefinedCondition(String conditionId) async {
    final condition = MexicanHealthConditions.getById(conditionId);
    if (condition != null) {
      await addHealthCondition(condition);
    }
  }

  /// Registra una métrica de salud
  Future<void> addHealthMetric(HealthMetric metric) async {
    _healthMetrics.add(metric);

    // Si es peso, actualizar el perfil
    if (metric.type == HealthMetricType.weight) {
      _profile = _profile.copyWith(weightKg: metric.value);
    }

    await saveProfile();
  }

  /// Obtiene métricas por tipo
  List<HealthMetric> getMetricsByType(HealthMetricType type) {
    return _healthMetrics.where((m) => m.type == type).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Obtiene la última métrica de un tipo
  HealthMetric? getLatestMetric(HealthMetricType type) {
    final metrics = getMetricsByType(type);
    return metrics.isNotEmpty ? metrics.first : null;
  }

  /// Incrementa contador de artículos leídos
  Future<void> incrementArticlesRead() async {
    _profile = _profile.copyWith(
      articlesRead: _profile.articlesRead + 1,
    );
    await saveProfile();
  }

  /// Incrementa contador de ejercicios completados
  Future<void> incrementExercisesCompleted() async {
    _profile = _profile.copyWith(
      exercisesCompleted: _profile.exercisesCompleted + 1,
    );
    await saveProfile();
  }

  /// Incrementa contador de alimentos vistos
  Future<void> incrementFoodsViewed() async {
    _profile = _profile.copyWith(
      foodsViewed: _profile.foodsViewed + 1,
    );
    await saveProfile();
  }

  /// Registra un día de uso
  Future<void> logDailyUsage() async {
    _profile = _profile.copyWith(
      daysLogged: _profile.daysLogged + 1,
    );
    await _updateStreak();
    await saveProfile();
  }

  /// Actualiza el streak de días consecutivos
  Future<void> _updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUseDateStr = prefs.getString('last_use_date');
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month}-${today.day}';

    if (lastUseDateStr == null) {
      // Primera vez
      _profile = _profile.copyWith(currentStreak: 1, longestStreak: 1);
      await prefs.setString('last_use_date', todayStr);
    } else {
      final parts = lastUseDateStr.split('-');
      final lastUseDate = DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
      final difference = today.difference(lastUseDate).inDays;

      if (difference == 0) {
        // Ya se registró hoy
        return;
      } else if (difference == 1) {
        // Día consecutivo
        final newStreak = _profile.currentStreak + 1;
        final longestStreak = newStreak > _profile.longestStreak
            ? newStreak
            : _profile.longestStreak;
        _profile = _profile.copyWith(
          currentStreak: newStreak,
          longestStreak: longestStreak,
        );
      } else {
        // Se rompió el streak
        _profile = _profile.copyWith(currentStreak: 1);
      }

      await prefs.setString('last_use_date', todayStr);
    }
  }

  /// Obtiene los cálculos nutricionales del usuario
  NutritionCalculation? getNutritionCalculation() {
    if (!_profile.isProfileComplete) return null;

    final bmr = NutritionCalculatorService.calculateBMR(
      weightKg: _profile.weightKg!,
      heightCm: _profile.heightCm!,
      age: _profile.age!,
      gender: _profile.gender,
    );

    final tdee = NutritionCalculatorService.calculateTDEE(
      bmr: bmr,
      activityLevel: _profile.activityLevel,
    );

    final targetCalories = NutritionCalculatorService.calculateTargetCalories(
      tdee: tdee,
      goal: _profile.nutritionGoal,
    );

    final macros = NutritionCalculatorService.calculateMacros(
      targetCalories: targetCalories,
      goal: _profile.nutritionGoal,
      weightKg: _profile.weightKg!,
      healthConditions: _profile.healthConditionIds,
    );

    final idealWeight = NutritionCalculatorService.calculateIdealWeight(
      heightCm: _profile.heightCm!,
      gender: _profile.gender,
    );

    final waterReq = NutritionCalculatorService.calculateWaterRequirement(
      weightKg: _profile.weightKg!,
      activityLevel: _profile.activityLevel,
    );

    WeightGoalProjection? weightProjection;
    if (_profile.targetWeightKg != null) {
      final deficit = tdee - targetCalories;
      weightProjection =
          NutritionCalculatorService.calculateWeightGoalProjection(
        currentWeight: _profile.weightKg!,
        targetWeight: _profile.targetWeightKg!,
        dailyCalorieDeficit: deficit,
      );
    }

    return NutritionCalculation(
      bmr: bmr,
      tdee: tdee,
      targetCalories: targetCalories,
      macros: macros,
      idealWeight: idealWeight,
      waterRequirement: waterReq,
      weightProjection: weightProjection,
      bmi: _profile.bmi,
      bmiCategory: _profile.bmiCategory,
    );
  }

  /// Obtiene el nivel del usuario basado en su actividad
  int getUserLevel() {
    final points = _profile.articlesRead * 10 +
        _profile.exercisesCompleted * 20 +
        _profile.foodsViewed * 5 +
        _profile.daysLogged * 15 +
        _profile.currentStreak * 5;

    if (points < 100) return 1;
    if (points < 300) return 2;
    if (points < 600) return 3;
    if (points < 1000) return 4;
    if (points < 1500) return 5;
    if (points < 2500) return 6;
    if (points < 4000) return 7;
    if (points < 6000) return 8;
    if (points < 9000) return 9;
    return 10;
  }

  /// Obtiene el título del nivel del usuario
  String getUserLevelTitle() {
    final level = getUserLevel();
    const titles = [
      'Novato',
      'Aprendiz',
      'Entusiasta',
      'Comprometido',
      'Experto',
      'Maestro',
      'Gurú',
      'Leyenda',
      'Élite',
      'NutriMaster',
    ];
    return titles[level - 1];
  }

  /// Obtiene el progreso hacia el siguiente nivel (0-100)
  double getLevelProgress() {
    final points = _profile.articlesRead * 10 +
        _profile.exercisesCompleted * 20 +
        _profile.foodsViewed * 5 +
        _profile.daysLogged * 15 +
        _profile.currentStreak * 5;

    final thresholds = [0, 100, 300, 600, 1000, 1500, 2500, 4000, 6000, 9000];
    final level = getUserLevel();

    if (level >= 10) return 100;

    final currentThreshold = thresholds[level - 1];
    final nextThreshold = thresholds[level];
    final progress =
        (points - currentThreshold) / (nextThreshold - currentThreshold);

    return (progress * 100).clamp(0, 100);
  }

  /// Limpia todos los datos del usuario
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_profile');
    await prefs.remove('user_health_conditions');
    await prefs.remove('user_health_metrics');
    await prefs.remove('last_use_date');

    _profile = UserProfile.create();
    _healthConditions = [];
    _healthMetrics = [];

    notifyListeners();
  }
}

/// Resultado completo de cálculos nutricionales
class NutritionCalculation {
  final double bmr;
  final double tdee;
  final double targetCalories;
  final MacroDistribution macros;
  final IdealWeightResult idealWeight;
  final WaterRequirement waterRequirement;
  final WeightGoalProjection? weightProjection;
  final double? bmi;
  final String? bmiCategory;

  const NutritionCalculation({
    required this.bmr,
    required this.tdee,
    required this.targetCalories,
    required this.macros,
    required this.idealWeight,
    required this.waterRequirement,
    this.weightProjection,
    this.bmi,
    this.bmiCategory,
  });
}
