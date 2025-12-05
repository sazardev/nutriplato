import 'package:flutter/foundation.dart';

/// Género del usuario
enum Gender {
  male('Masculino'),
  female('Femenino'),
  other('Otro');

  final String label;
  const Gender(this.label);

  static Gender fromString(String value) {
    return Gender.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Gender.other,
    );
  }
}

/// Nivel de actividad física
enum ActivityLevel {
  sedentary('Sedentario', 'Poco o ningún ejercicio', 1.2),
  lightlyActive(
      'Ligeramente activo', 'Ejercicio ligero 1-3 días/semana', 1.375),
  moderatelyActive(
      'Moderadamente activo', 'Ejercicio moderado 3-5 días/semana', 1.55),
  veryActive('Muy activo', 'Ejercicio intenso 6-7 días/semana', 1.725),
  extraActive('Extra activo', 'Ejercicio muy intenso o trabajo físico', 1.9);

  final String label;
  final String description;
  final double factor;

  const ActivityLevel(this.label, this.description, this.factor);

  static ActivityLevel fromString(String value) {
    return ActivityLevel.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ActivityLevel.sedentary,
    );
  }
}

/// Objetivo nutricional del usuario
enum NutritionGoal {
  loseWeight('Perder peso', 'Déficit calórico controlado', -500),
  loseWeightFast('Perder peso rápido', 'Déficit calórico moderado', -750),
  maintainWeight('Mantener peso', 'Balance calórico', 0),
  gainMuscle('Ganar músculo', 'Superávit moderado con proteína', 300),
  gainWeight('Ganar peso', 'Superávit calórico', 500);

  final String label;
  final String description;
  final int calorieAdjustment;

  const NutritionGoal(this.label, this.description, this.calorieAdjustment);

  static NutritionGoal fromString(String value) {
    return NutritionGoal.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NutritionGoal.maintainWeight,
    );
  }
}

/// Modelo completo del perfil de usuario
@immutable
class UserProfile {
  // Información básica
  final String id;
  final String username;
  final String? email;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Información física
  final DateTime? birthDate;
  final Gender gender;
  final double? heightCm; // Altura en centímetros
  final double? weightKg; // Peso actual en kg
  final double? targetWeightKg; // Peso objetivo en kg

  // Medidas corporales (opcionales)
  final double? waistCm; // Cintura en cm
  final double? hipCm; // Cadera en cm
  final double? neckCm; // Cuello en cm
  final double? chestCm; // Pecho en cm

  // Estilo de vida
  final ActivityLevel activityLevel;
  final NutritionGoal nutritionGoal;
  final int? sleepHoursPerDay;
  final int? waterGlassesPerDay; // Vasos de agua diarios objetivo

  // Preferencias alimentarias
  final List<String>
      dietaryRestrictions; // vegetariano, vegano, sin gluten, etc.
  final List<String> allergies; // Alergias alimentarias
  final List<String> dislikedFoods; // Alimentos que no le gustan
  final List<String> favoriteFoods; // Alimentos favoritos

  // Condiciones médicas (referencia a HealthConditions)
  final List<String> healthConditionIds;

  // Estadísticas de uso
  final int articlesRead;
  final int exercisesCompleted;
  final int foodsViewed;
  final int daysLogged;
  final int currentStreak; // Días consecutivos usando la app
  final int longestStreak;

  // Configuración de notificaciones
  final bool notifyMeals;
  final bool notifyWater;
  final bool notifyExercise;
  final bool notifyArticles;

  // Estado del onboarding
  final bool onboardingCompleted;
  final int onboardingStep;

  const UserProfile({
    required this.id,
    this.username = 'Usuario',
    this.email,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
    this.birthDate,
    this.gender = Gender.other,
    this.heightCm,
    this.weightKg,
    this.targetWeightKg,
    this.waistCm,
    this.hipCm,
    this.neckCm,
    this.chestCm,
    this.activityLevel = ActivityLevel.sedentary,
    this.nutritionGoal = NutritionGoal.maintainWeight,
    this.sleepHoursPerDay,
    this.waterGlassesPerDay = 8,
    this.dietaryRestrictions = const [],
    this.allergies = const [],
    this.dislikedFoods = const [],
    this.favoriteFoods = const [],
    this.healthConditionIds = const [],
    this.articlesRead = 0,
    this.exercisesCompleted = 0,
    this.foodsViewed = 0,
    this.daysLogged = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.notifyMeals = true,
    this.notifyWater = true,
    this.notifyExercise = true,
    this.notifyArticles = true,
    this.onboardingCompleted = false,
    this.onboardingStep = 0,
  });

  /// Calcula la edad del usuario
  int? get age {
    if (birthDate == null) return null;
    final now = DateTime.now();
    int age = now.year - birthDate!.year;
    if (now.month < birthDate!.month ||
        (now.month == birthDate!.month && now.day < birthDate!.day)) {
      age--;
    }
    return age;
  }

  /// Calcula el IMC (Índice de Masa Corporal)
  double? get bmi {
    if (heightCm == null || weightKg == null) return null;
    final heightM = heightCm! / 100;
    return weightKg! / (heightM * heightM);
  }

  /// Categoría del IMC según la OMS
  String? get bmiCategory {
    final imc = bmi;
    if (imc == null) return null;
    if (imc < 18.5) return 'Bajo peso';
    if (imc < 25) return 'Peso normal';
    if (imc < 30) return 'Sobrepeso';
    if (imc < 35) return 'Obesidad grado I';
    if (imc < 40) return 'Obesidad grado II';
    return 'Obesidad grado III';
  }

  /// Calcula el peso ideal usando la fórmula de Devine
  double? get idealWeight {
    if (heightCm == null) return null;
    final heightInches = heightCm! / 2.54;
    if (gender == Gender.male) {
      return 50 + 2.3 * (heightInches - 60);
    } else {
      return 45.5 + 2.3 * (heightInches - 60);
    }
  }

  /// Calcula el porcentaje de grasa corporal estimado (fórmula de la Marina de EE.UU.)
  double? get estimatedBodyFatPercentage {
    if (waistCm == null || neckCm == null || heightCm == null) return null;

    if (gender == Gender.male) {
      return 86.010 * _log10(waistCm! - neckCm!) -
          70.041 * _log10(heightCm!) +
          36.76;
    } else if (hipCm != null) {
      return 163.205 * _log10(waistCm! + hipCm! - neckCm!) -
          97.684 * _log10(heightCm!) -
          78.387;
    }
    return null;
  }

  double _log10(double x) => 0.4342944819 * _ln(x);
  double _ln(double x) {
    if (x <= 0) return 0;
    double result = 0;
    while (x >= 2) {
      result += 0.693147;
      x /= 2;
    }
    x -= 1;
    double term = x;
    for (int i = 1; i <= 20; i++) {
      result += (i % 2 == 1 ? 1 : -1) * term / i;
      term *= x;
    }
    return result;
  }

  /// Calcula la TMB (Tasa Metabólica Basal) usando Mifflin-St Jeor
  double? get basalMetabolicRate {
    if (weightKg == null || heightCm == null || age == null) return null;

    if (gender == Gender.male) {
      return 10 * weightKg! + 6.25 * heightCm! - 5 * age! + 5;
    } else {
      return 10 * weightKg! + 6.25 * heightCm! - 5 * age! - 161;
    }
  }

  /// Calcula el TDEE (Gasto Energético Total Diario)
  double? get totalDailyEnergyExpenditure {
    final bmr = basalMetabolicRate;
    if (bmr == null) return null;
    return bmr * activityLevel.factor;
  }

  /// Calorías diarias objetivo según la meta
  double? get dailyCalorieTarget {
    final tdee = totalDailyEnergyExpenditure;
    if (tdee == null) return null;
    return tdee + nutritionGoal.calorieAdjustment;
  }

  /// Macronutrientes objetivo (gramos)
  Map<String, double>? get macroTargets {
    final calories = dailyCalorieTarget;
    if (calories == null) return null;

    // Distribución estándar: 40% carbs, 30% proteína, 30% grasas
    // Ajustada según objetivo
    double proteinPercent = 0.30;
    double carbPercent = 0.40;
    double fatPercent = 0.30;

    switch (nutritionGoal) {
      case NutritionGoal.loseWeight:
      case NutritionGoal.loseWeightFast:
        proteinPercent = 0.35;
        carbPercent = 0.35;
        fatPercent = 0.30;
        break;
      case NutritionGoal.gainMuscle:
        proteinPercent = 0.35;
        carbPercent = 0.45;
        fatPercent = 0.20;
        break;
      default:
        break;
    }

    return {
      'protein': (calories * proteinPercent) / 4, // 4 cal/g
      'carbs': (calories * carbPercent) / 4, // 4 cal/g
      'fat': (calories * fatPercent) / 9, // 9 cal/g
      'fiber': 25 + (calories / 1000) * 5, // ~25-35g
    };
  }

  /// Verifica si el perfil está completo para cálculos nutricionales
  bool get isProfileComplete {
    return heightCm != null &&
        weightKg != null &&
        birthDate != null &&
        gender != Gender.other;
  }

  /// Copia el perfil con modificaciones
  UserProfile copyWith({
    String? id,
    String? username,
    String? email,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? birthDate,
    Gender? gender,
    double? heightCm,
    double? weightKg,
    double? targetWeightKg,
    double? waistCm,
    double? hipCm,
    double? neckCm,
    double? chestCm,
    ActivityLevel? activityLevel,
    NutritionGoal? nutritionGoal,
    int? sleepHoursPerDay,
    int? waterGlassesPerDay,
    List<String>? dietaryRestrictions,
    List<String>? allergies,
    List<String>? dislikedFoods,
    List<String>? favoriteFoods,
    List<String>? healthConditionIds,
    int? articlesRead,
    int? exercisesCompleted,
    int? foodsViewed,
    int? daysLogged,
    int? currentStreak,
    int? longestStreak,
    bool? notifyMeals,
    bool? notifyWater,
    bool? notifyExercise,
    bool? notifyArticles,
    bool? onboardingCompleted,
    int? onboardingStep,
  }) {
    return UserProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      waistCm: waistCm ?? this.waistCm,
      hipCm: hipCm ?? this.hipCm,
      neckCm: neckCm ?? this.neckCm,
      chestCm: chestCm ?? this.chestCm,
      activityLevel: activityLevel ?? this.activityLevel,
      nutritionGoal: nutritionGoal ?? this.nutritionGoal,
      sleepHoursPerDay: sleepHoursPerDay ?? this.sleepHoursPerDay,
      waterGlassesPerDay: waterGlassesPerDay ?? this.waterGlassesPerDay,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      allergies: allergies ?? this.allergies,
      dislikedFoods: dislikedFoods ?? this.dislikedFoods,
      favoriteFoods: favoriteFoods ?? this.favoriteFoods,
      healthConditionIds: healthConditionIds ?? this.healthConditionIds,
      articlesRead: articlesRead ?? this.articlesRead,
      exercisesCompleted: exercisesCompleted ?? this.exercisesCompleted,
      foodsViewed: foodsViewed ?? this.foodsViewed,
      daysLogged: daysLogged ?? this.daysLogged,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      notifyMeals: notifyMeals ?? this.notifyMeals,
      notifyWater: notifyWater ?? this.notifyWater,
      notifyExercise: notifyExercise ?? this.notifyExercise,
      notifyArticles: notifyArticles ?? this.notifyArticles,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      onboardingStep: onboardingStep ?? this.onboardingStep,
    );
  }

  /// Convierte a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatarUrl': avatarUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'birthDate': birthDate?.toIso8601String(),
      'gender': gender.name,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'targetWeightKg': targetWeightKg,
      'waistCm': waistCm,
      'hipCm': hipCm,
      'neckCm': neckCm,
      'chestCm': chestCm,
      'activityLevel': activityLevel.name,
      'nutritionGoal': nutritionGoal.name,
      'sleepHoursPerDay': sleepHoursPerDay,
      'waterGlassesPerDay': waterGlassesPerDay,
      'dietaryRestrictions': dietaryRestrictions,
      'allergies': allergies,
      'dislikedFoods': dislikedFoods,
      'favoriteFoods': favoriteFoods,
      'healthConditionIds': healthConditionIds,
      'articlesRead': articlesRead,
      'exercisesCompleted': exercisesCompleted,
      'foodsViewed': foodsViewed,
      'daysLogged': daysLogged,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'notifyMeals': notifyMeals,
      'notifyWater': notifyWater,
      'notifyExercise': notifyExercise,
      'notifyArticles': notifyArticles,
      'onboardingCompleted': onboardingCompleted,
      'onboardingStep': onboardingStep,
    };
  }

  /// Crea desde JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      username: json['username'] ?? 'Usuario',
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      gender: Gender.fromString(json['gender'] ?? 'other'),
      heightCm: json['heightCm']?.toDouble(),
      weightKg: json['weightKg']?.toDouble(),
      targetWeightKg: json['targetWeightKg']?.toDouble(),
      waistCm: json['waistCm']?.toDouble(),
      hipCm: json['hipCm']?.toDouble(),
      neckCm: json['neckCm']?.toDouble(),
      chestCm: json['chestCm']?.toDouble(),
      activityLevel:
          ActivityLevel.fromString(json['activityLevel'] ?? 'sedentary'),
      nutritionGoal:
          NutritionGoal.fromString(json['nutritionGoal'] ?? 'maintainWeight'),
      sleepHoursPerDay: json['sleepHoursPerDay'],
      waterGlassesPerDay: json['waterGlassesPerDay'] ?? 8,
      dietaryRestrictions: List<String>.from(json['dietaryRestrictions'] ?? []),
      allergies: List<String>.from(json['allergies'] ?? []),
      dislikedFoods: List<String>.from(json['dislikedFoods'] ?? []),
      favoriteFoods: List<String>.from(json['favoriteFoods'] ?? []),
      healthConditionIds: List<String>.from(json['healthConditionIds'] ?? []),
      articlesRead: json['articlesRead'] ?? 0,
      exercisesCompleted: json['exercisesCompleted'] ?? 0,
      foodsViewed: json['foodsViewed'] ?? 0,
      daysLogged: json['daysLogged'] ?? 0,
      currentStreak: json['currentStreak'] ?? 0,
      longestStreak: json['longestStreak'] ?? 0,
      notifyMeals: json['notifyMeals'] ?? true,
      notifyWater: json['notifyWater'] ?? true,
      notifyExercise: json['notifyExercise'] ?? true,
      notifyArticles: json['notifyArticles'] ?? true,
      onboardingCompleted: json['onboardingCompleted'] ?? false,
      onboardingStep: json['onboardingStep'] ?? 0,
    );
  }

  /// Crea un perfil nuevo
  factory UserProfile.create() {
    final now = DateTime.now();
    return UserProfile(
      id: now.millisecondsSinceEpoch.toString(),
      createdAt: now,
      updatedAt: now,
    );
  }
}
