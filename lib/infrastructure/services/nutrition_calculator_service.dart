import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';

/// Fórmulas para calcular TMB
enum BMRFormula {
  mifflinStJeor,
  harrisBenedict,
  katchMcArdle,
}

/// Nivel de riesgo
enum RiskLevel {
  low,
  moderate,
  high,
}

/// Servicio para calcular requerimientos nutricionales basados en el perfil del usuario
/// y estándares mexicanos de salud (NOM-043-SSA2-2012)
class NutritionCalculatorService {
  /// Calcula la TMB usando diferentes fórmulas según preferencia
  static double calculateBMR({
    required double weightKg,
    required double heightCm,
    required int age,
    required Gender gender,
    BMRFormula formula = BMRFormula.mifflinStJeor,
  }) {
    switch (formula) {
      case BMRFormula.mifflinStJeor:
        // Más precisa para personas con sobrepeso/obesidad
        if (gender == Gender.male) {
          return 10 * weightKg + 6.25 * heightCm - 5 * age + 5;
        } else {
          return 10 * weightKg + 6.25 * heightCm - 5 * age - 161;
        }

      case BMRFormula.harrisBenedict:
        // Fórmula clásica, tiende a sobrestimar
        if (gender == Gender.male) {
          return 88.362 +
              (13.397 * weightKg) +
              (4.799 * heightCm) -
              (5.677 * age);
        } else {
          return 447.593 +
              (9.247 * weightKg) +
              (3.098 * heightCm) -
              (4.330 * age);
        }

      case BMRFormula.katchMcArdle:
        // Requiere porcentaje de grasa corporal, usa Mifflin como fallback
        return calculateBMR(
          weightKg: weightKg,
          heightCm: heightCm,
          age: age,
          gender: gender,
          formula: BMRFormula.mifflinStJeor,
        );
    }
  }

  /// Calcula TMB con Katch-McArdle si se conoce el % de grasa
  static double calculateBMRWithBodyFat({
    required double weightKg,
    required double bodyFatPercentage,
  }) {
    final leanBodyMass = weightKg * (1 - bodyFatPercentage / 100);
    return 370 + (21.6 * leanBodyMass);
  }

  /// Calcula el TDEE (Gasto Energético Total Diario)
  static double calculateTDEE({
    required double bmr,
    required ActivityLevel activityLevel,
    double? exerciseCalories, // Calorías adicionales por ejercicio específico
  }) {
    double tdee = bmr * activityLevel.factor;
    if (exerciseCalories != null) {
      tdee += exerciseCalories;
    }
    return tdee;
  }

  /// Calcula las calorías objetivo según la meta nutricional
  static double calculateTargetCalories({
    required double tdee,
    required NutritionGoal goal,
    double? customAdjustment,
  }) {
    final adjustment = customAdjustment ?? goal.calorieAdjustment.toDouble();
    double target = tdee + adjustment;

    // Mínimos saludables según NOM-043-SSA2-2012
    const minCaloriesFemale = 1200.0;

    // Usar el mínimo más bajo como límite general
    if (target < minCaloriesFemale) {
      target = minCaloriesFemale;
    }

    return target;
  }

  /// Calcula la distribución de macronutrientes
  static MacroDistribution calculateMacros({
    required double targetCalories,
    required NutritionGoal goal,
    required double weightKg,
    List<String>? healthConditions,
  }) {
    double proteinPercent;
    double carbPercent;
    double fatPercent;

    // Ajustar según objetivo
    switch (goal) {
      case NutritionGoal.loseWeight:
        proteinPercent = 0.30;
        carbPercent = 0.40;
        fatPercent = 0.30;
        break;
      case NutritionGoal.loseWeightFast:
        proteinPercent = 0.35;
        carbPercent = 0.35;
        fatPercent = 0.30;
        break;
      case NutritionGoal.gainMuscle:
        proteinPercent = 0.30;
        carbPercent = 0.50;
        fatPercent = 0.20;
        break;
      case NutritionGoal.gainWeight:
        proteinPercent = 0.25;
        carbPercent = 0.50;
        fatPercent = 0.25;
        break;
      case NutritionGoal.maintainWeight:
        proteinPercent = 0.25;
        carbPercent = 0.50;
        fatPercent = 0.25;
    }

    // Ajustes especiales para condiciones de salud
    if (healthConditions != null) {
      if (healthConditions.contains('diabetes_type_2') ||
          healthConditions.contains('prediabetes')) {
        // Reducir carbohidratos para diabéticos
        carbPercent = 0.40;
        proteinPercent = 0.30;
        fatPercent = 0.30;
      }
      if (healthConditions.contains('enfermedad_renal_cronica')) {
        // Reducir proteína para enfermedad renal
        proteinPercent = 0.15;
        carbPercent = 0.55;
        fatPercent = 0.30;
      }
    }

    // Calcular gramos
    final proteinGrams = (targetCalories * proteinPercent) / 4;
    final carbGrams = (targetCalories * carbPercent) / 4;
    final fatGrams = (targetCalories * fatPercent) / 9;

    // Calcular proteína por kg de peso
    final proteinPerKg = proteinGrams / weightKg;

    // Fibra recomendada (14g por cada 1000 kcal según recomendaciones)
    final fiberGrams = (targetCalories / 1000) * 14;

    return MacroDistribution(
      calories: targetCalories,
      proteinGrams: proteinGrams,
      carbGrams: carbGrams,
      fatGrams: fatGrams,
      fiberGrams: fiberGrams.clamp(25, 38),
      proteinPercent: proteinPercent * 100,
      carbPercent: carbPercent * 100,
      fatPercent: fatPercent * 100,
      proteinPerKg: proteinPerKg,
    );
  }

  /// Calcula el peso ideal usando múltiples fórmulas
  static IdealWeightResult calculateIdealWeight({
    required double heightCm,
    required Gender gender,
  }) {
    final heightM = heightCm / 100;
    final heightInches = heightCm / 2.54;

    // Fórmula de Devine (usada comúnmente en medicina)
    double devine;
    if (gender == Gender.male) {
      devine = 50 + 2.3 * (heightInches - 60);
    } else {
      devine = 45.5 + 2.3 * (heightInches - 60);
    }

    // Fórmula de Robinson
    double robinson;
    if (gender == Gender.male) {
      robinson = 52 + 1.9 * (heightInches - 60);
    } else {
      robinson = 49 + 1.7 * (heightInches - 60);
    }

    // Fórmula de Miller
    double miller;
    if (gender == Gender.male) {
      miller = 56.2 + 1.41 * (heightInches - 60);
    } else {
      miller = 53.1 + 1.36 * (heightInches - 60);
    }

    // IMC ideal (21.75 punto medio del rango saludable)
    final bmiIdeal = 21.75 * heightM * heightM;

    // Rango saludable según OMS (IMC 18.5-24.9)
    final minHealthy = 18.5 * heightM * heightM;
    final maxHealthy = 24.9 * heightM * heightM;

    return IdealWeightResult(
      devine: devine,
      robinson: robinson,
      miller: miller,
      bmiIdeal: bmiIdeal,
      minHealthyWeight: minHealthy,
      maxHealthyWeight: maxHealthy,
      average: (devine + robinson + miller + bmiIdeal) / 4,
    );
  }

  /// Calcula cuánto tiempo tomará alcanzar el peso objetivo
  static WeightGoalProjection calculateWeightGoalProjection({
    required double currentWeight,
    required double targetWeight,
    required double dailyCalorieDeficit,
  }) {
    final weightDifference = currentWeight - targetWeight;

    // 7700 calorías ≈ 1 kg de grasa
    const caloriesPerKg = 7700.0;

    if (dailyCalorieDeficit.abs() < 100) {
      return WeightGoalProjection(
        weeksToGoal: null,
        weeklyWeightChange: 0,
        isRealistic: false,
        message: 'El déficit/superávit calórico es muy pequeño para proyectar.',
      );
    }

    final daysToGoal =
        (weightDifference.abs() * caloriesPerKg) / dailyCalorieDeficit.abs();
    final weeksToGoal = daysToGoal / 7;
    final weeklyChange = (dailyCalorieDeficit * 7) / caloriesPerKg;

    // Verificar si es realista (0.5-1 kg por semana es saludable)
    final isRealistic = weeklyChange.abs() <= 1.0;

    String message;
    if (weightDifference > 0) {
      message =
          'Perderás aproximadamente ${weeklyChange.abs().toStringAsFixed(2)} kg por semana.';
    } else {
      message =
          'Ganarás aproximadamente ${weeklyChange.abs().toStringAsFixed(2)} kg por semana.';
    }

    if (!isRealistic) {
      message +=
          ' ⚠️ La velocidad de cambio es alta. Considera ajustar tu meta.';
    }

    return WeightGoalProjection(
      weeksToGoal: weeksToGoal,
      weeklyWeightChange: weeklyChange,
      isRealistic: isRealistic,
      message: message,
    );
  }

  /// Calcula los requerimientos de agua diarios
  static WaterRequirement calculateWaterRequirement({
    required double weightKg,
    required ActivityLevel activityLevel,
    bool isHotClimate = false,
  }) {
    // Base: 30-35 ml por kg de peso
    double baseWater = weightKg * 33;

    // Ajustar por actividad física
    switch (activityLevel) {
      case ActivityLevel.sedentary:
        break;
      case ActivityLevel.lightlyActive:
        baseWater *= 1.1;
        break;
      case ActivityLevel.moderatelyActive:
        baseWater *= 1.2;
        break;
      case ActivityLevel.veryActive:
        baseWater *= 1.3;
        break;
      case ActivityLevel.extraActive:
        baseWater *= 1.4;
        break;
    }

    // Ajustar por clima
    if (isHotClimate) {
      baseWater *= 1.15;
    }

    final glasses = (baseWater / 250).round(); // Vasos de 250ml
    final liters = baseWater / 1000;

    return WaterRequirement(
      milliliters: baseWater,
      liters: liters,
      glasses: glasses,
    );
  }

  /// Evalúa el riesgo cardiovascular según cintura
  static CardiovascularRisk evaluateWaistCircumference({
    required double waistCm,
    required Gender gender,
  }) {
    // Criterios según la Federación Internacional de Diabetes
    // para población latinoamericana
    double riskThreshold;
    double highRiskThreshold;

    if (gender == Gender.male) {
      riskThreshold = 90; // cm
      highRiskThreshold = 102;
    } else {
      riskThreshold = 80; // cm
      highRiskThreshold = 88;
    }

    if (waistCm < riskThreshold) {
      return CardiovascularRisk(
        level: RiskLevel.low,
        message: 'Tu circunferencia de cintura está en un rango saludable.',
        recommendation: 'Mantén tus hábitos actuales.',
      );
    } else if (waistCm < highRiskThreshold) {
      return CardiovascularRisk(
        level: RiskLevel.moderate,
        message: 'Tu circunferencia de cintura indica riesgo moderado.',
        recommendation:
            'Considera aumentar tu actividad física y reducir el consumo de azúcares.',
      );
    } else {
      return CardiovascularRisk(
        level: RiskLevel.high,
        message: 'Tu circunferencia de cintura indica riesgo elevado.',
        recommendation:
            'Es importante consultar con un profesional de salud y adoptar cambios en tu alimentación.',
      );
    }
  }

  /// Calcula el índice cintura-cadera
  static WaistHipRatio calculateWaistHipRatio({
    required double waistCm,
    required double hipCm,
    required Gender gender,
  }) {
    final ratio = waistCm / hipCm;

    RiskLevel risk;
    String interpretation;

    if (gender == Gender.male) {
      if (ratio < 0.90) {
        risk = RiskLevel.low;
        interpretation = 'Distribución de grasa saludable';
      } else if (ratio < 1.0) {
        risk = RiskLevel.moderate;
        interpretation = 'Distribución de grasa con riesgo moderado';
      } else {
        risk = RiskLevel.high;
        interpretation = 'Distribución de grasa abdominal (riesgo elevado)';
      }
    } else {
      if (ratio < 0.80) {
        risk = RiskLevel.low;
        interpretation = 'Distribución de grasa saludable';
      } else if (ratio < 0.85) {
        risk = RiskLevel.moderate;
        interpretation = 'Distribución de grasa con riesgo moderado';
      } else {
        risk = RiskLevel.high;
        interpretation = 'Distribución de grasa abdominal (riesgo elevado)';
      }
    }

    return WaistHipRatio(
      ratio: ratio,
      risk: risk,
      interpretation: interpretation,
    );
  }
}

/// Resultado de distribución de macronutrientes
class MacroDistribution {
  final double calories;
  final double proteinGrams;
  final double carbGrams;
  final double fatGrams;
  final double fiberGrams;
  final double proteinPercent;
  final double carbPercent;
  final double fatPercent;
  final double proteinPerKg;

  const MacroDistribution({
    required this.calories,
    required this.proteinGrams,
    required this.carbGrams,
    required this.fatGrams,
    required this.fiberGrams,
    required this.proteinPercent,
    required this.carbPercent,
    required this.fatPercent,
    required this.proteinPerKg,
  });

  Map<String, dynamic> toJson() => {
        'calories': calories,
        'proteinGrams': proteinGrams,
        'carbGrams': carbGrams,
        'fatGrams': fatGrams,
        'fiberGrams': fiberGrams,
        'proteinPercent': proteinPercent,
        'carbPercent': carbPercent,
        'fatPercent': fatPercent,
        'proteinPerKg': proteinPerKg,
      };
}

/// Resultado de peso ideal
class IdealWeightResult {
  final double devine;
  final double robinson;
  final double miller;
  final double bmiIdeal;
  final double minHealthyWeight;
  final double maxHealthyWeight;
  final double average;

  const IdealWeightResult({
    required this.devine,
    required this.robinson,
    required this.miller,
    required this.bmiIdeal,
    required this.minHealthyWeight,
    required this.maxHealthyWeight,
    required this.average,
  });
}

/// Proyección de meta de peso
class WeightGoalProjection {
  final double? weeksToGoal;
  final double weeklyWeightChange;
  final bool isRealistic;
  final String message;

  const WeightGoalProjection({
    required this.weeksToGoal,
    required this.weeklyWeightChange,
    required this.isRealistic,
    required this.message,
  });
}

/// Requerimiento de agua
class WaterRequirement {
  final double milliliters;
  final double liters;
  final int glasses;

  const WaterRequirement({
    required this.milliliters,
    required this.liters,
    required this.glasses,
  });
}

/// Riesgo cardiovascular
class CardiovascularRisk {
  final RiskLevel level;
  final String message;
  final String recommendation;

  const CardiovascularRisk({
    required this.level,
    required this.message,
    required this.recommendation,
  });
}

/// Relación cintura-cadera
class WaistHipRatio {
  final double ratio;
  final RiskLevel risk;
  final String interpretation;

  const WaistHipRatio({
    required this.ratio,
    required this.risk,
    required this.interpretation,
  });
}
