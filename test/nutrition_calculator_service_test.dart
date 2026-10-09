import 'package:flutter_test/flutter_test.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/services/nutrition_calculator_service.dart';

void main() {
  group('NutritionCalculatorService.calculateBMR', () {
    test('Mifflin-St Jeor (hombre) aplica la fórmula exacta', () {
      final bmr = NutritionCalculatorService.calculateBMR(
        weightKg: 70,
        heightCm: 175,
        age: 30,
        gender: Gender.male,
      );
      expect(bmr, closeTo(1648.75, 0.001));
    });

    test('Mifflin-St Jeor (mujer) aplica la fórmula exacta', () {
      final bmr = NutritionCalculatorService.calculateBMR(
        weightKg: 60,
        heightCm: 160,
        age: 25,
        gender: Gender.female,
      );
      expect(bmr, closeTo(1314.0, 0.001));
    });

    test('Harris-Benedict (hombre) aplica la fórmula clásica', () {
      final bmr = NutritionCalculatorService.calculateBMR(
        weightKg: 70,
        heightCm: 175,
        age: 30,
        gender: Gender.male,
        formula: BMRFormula.harrisBenedict,
      );
      expect(bmr, closeTo(1695.667, 0.001));
    });

    test('Katch-McArdle sin % de grasa cae a Mifflin-St Jeor', () {
      final bmr = NutritionCalculatorService.calculateBMR(
        weightKg: 70,
        heightCm: 175,
        age: 30,
        gender: Gender.male,
        formula: BMRFormula.katchMcArdle,
      );
      expect(bmr, closeTo(1648.75, 0.001));
    });
  });

  group('NutritionCalculatorService.calculateBMRWithBodyFat', () {
    test('usa masa libre de grasa (Katch-McArdle)', () {
      final bmr = NutritionCalculatorService.calculateBMRWithBodyFat(
        weightKg: 70,
        bodyFatPercentage: 20,
      );
      expect(bmr, closeTo(1579.6, 0.001));
    });
  });

  group('NutritionCalculatorService.calculateTDEE', () {
    test('aplica el factor de actividad', () {
      final tdee = NutritionCalculatorService.calculateTDEE(
        bmr: 1500,
        activityLevel: ActivityLevel.moderatelyActive,
      );
      expect(tdee, closeTo(2325.0, 0.001));
    });

    test('suma calorías de ejercicio adicionales', () {
      final tdee = NutritionCalculatorService.calculateTDEE(
        bmr: 1500,
        activityLevel: ActivityLevel.moderatelyActive,
        exerciseCalories: 200,
      );
      expect(tdee, closeTo(2525.0, 0.001));
    });
  });

  group('NutritionCalculatorService.calculateTargetCalories', () {
    test('aplica el ajuste de la meta (déficit)', () {
      final target = NutritionCalculatorService.calculateTargetCalories(
        tdee: 2000,
        goal: NutritionGoal.loseWeight,
      );
      expect(target, closeTo(1500.0, 0.001));
    });

    test('aplica el ajuste de la meta (superávit)', () {
      final target = NutritionCalculatorService.calculateTargetCalories(
        tdee: 2000,
        goal: NutritionGoal.gainWeight,
      );
      expect(target, closeTo(2500.0, 0.001));
    });

    test('respeta el mínimo saludable de 1200 kcal', () {
      final target = NutritionCalculatorService.calculateTargetCalories(
        tdee: 1000,
        goal: NutritionGoal.loseWeightFast,
      );
      expect(target, closeTo(1200.0, 0.001));
    });

    test('customAdjustment tiene prioridad sobre la meta', () {
      final target = NutritionCalculatorService.calculateTargetCalories(
        tdee: 2000,
        goal: NutritionGoal.maintainWeight,
        customAdjustment: -300,
      );
      expect(target, closeTo(1700.0, 0.001));
    });
  });

  group('NutritionCalculatorService.calculateMacros', () {
    test('perder peso: 30/40/30 y gramos correctos', () {
      final macros = NutritionCalculatorService.calculateMacros(
        targetCalories: 2000,
        goal: NutritionGoal.loseWeight,
        weightKg: 75,
      );
      expect(macros.proteinPercent, closeTo(30, 0.001));
      expect(macros.carbPercent, closeTo(40, 0.001));
      expect(macros.fatPercent, closeTo(30, 0.001));
      expect(macros.proteinGrams, closeTo(150.0, 0.001));
      expect(macros.carbGrams, closeTo(200.0, 0.001));
      expect(macros.fatGrams, closeTo(66.667, 0.001));
      expect(macros.proteinPerKg, closeTo(2.0, 0.001));
      expect(macros.fiberGrams, closeTo(28.0, 0.001));
    });

    test('diabetes tipo 2 reduce carbohidratos a 40%', () {
      final macros = NutritionCalculatorService.calculateMacros(
        targetCalories: 2000,
        goal: NutritionGoal.maintainWeight,
        weightKg: 75,
        healthConditions: ['diabetes_type_2'],
      );
      expect(macros.carbPercent, closeTo(40, 0.001));
      expect(macros.proteinPercent, closeTo(30, 0.001));
      expect(macros.fatPercent, closeTo(30, 0.001));
    });

    test('enfermedad renal crónica reduce proteína a 15%', () {
      final macros = NutritionCalculatorService.calculateMacros(
        targetCalories: 2000,
        goal: NutritionGoal.maintainWeight,
        weightKg: 75,
        healthConditions: ['enfermedad_renal_cronica'],
      );
      expect(macros.proteinPercent, closeTo(15, 0.001));
      expect(macros.carbPercent, closeTo(55, 0.001));
      expect(macros.fatPercent, closeTo(30, 0.001));
    });

    test('fibra se limita al rango 25-38 g', () {
      final low = NutritionCalculatorService.calculateMacros(
        targetCalories: 1000,
        goal: NutritionGoal.maintainWeight,
        weightKg: 75,
      );
      final high = NutritionCalculatorService.calculateMacros(
        targetCalories: 3500,
        goal: NutritionGoal.maintainWeight,
        weightKg: 75,
      );
      expect(low.fiberGrams, closeTo(25, 0.001));
      expect(high.fiberGrams, closeTo(38, 0.001));
    });
  });

  group('NutritionCalculatorService.calculateIdealWeight', () {
    test('mujer 165 cm: fórmulas y rango saludable', () {
      final result = NutritionCalculatorService.calculateIdealWeight(
        heightCm: 165,
        gender: Gender.female,
      );
      expect(result.devine, closeTo(56.909, 0.01));
      expect(result.robinson, closeTo(57.433, 0.01));
      expect(result.miller, closeTo(59.846, 0.01));
      expect(result.bmiIdeal, closeTo(59.214, 0.01));
      expect(result.average, closeTo(58.35, 0.05));
      expect(result.minHealthyWeight, closeTo(50.366, 0.01));
      expect(result.maxHealthyWeight, closeTo(67.79, 0.01));
    });

    test('hombre 180 cm: Devine usa base 50 kg', () {
      final result = NutritionCalculatorService.calculateIdealWeight(
        heightCm: 180,
        gender: Gender.male,
      );
      expect(result.devine, closeTo(74.992, 0.01));
    });
  });

  group('NutritionCalculatorService.calculateWeightGoalProjection', () {
    test('proyecta semanas y cambio semanal para déficit de 500', () {
      final projection =
          NutritionCalculatorService.calculateWeightGoalProjection(
            currentWeight: 80,
            targetWeight: 70,
            dailyCalorieDeficit: 500,
          );
      expect(projection.weeksToGoal, closeTo(22.0, 0.01));
      expect(projection.weeklyWeightChange, closeTo(0.4545, 0.001));
      expect(projection.isRealistic, isTrue);
      expect(projection.message, contains('Perderás'));
    });

    test('marca como no realista un déficit agresivo', () {
      final projection =
          NutritionCalculatorService.calculateWeightGoalProjection(
            currentWeight: 80,
            targetWeight: 70,
            dailyCalorieDeficit: 1200,
          );
      expect(projection.isRealistic, isFalse);
      expect(projection.message, contains('alta'));
    });

    test('déficit insignificante no proyecta', () {
      final projection =
          NutritionCalculatorService.calculateWeightGoalProjection(
            currentWeight: 80,
            targetWeight: 79,
            dailyCalorieDeficit: 50,
          );
      expect(projection.weeksToGoal, isNull);
      expect(projection.weeklyWeightChange, 0);
      expect(projection.isRealistic, isFalse);
    });

    test('meta de ganancia usa mensaje de ganar peso', () {
      final projection =
          NutritionCalculatorService.calculateWeightGoalProjection(
            currentWeight: 60,
            targetWeight: 70,
            dailyCalorieDeficit: 500,
          );
      expect(projection.message, contains('Ganarás'));
    });
  });

  group('NutritionCalculatorService.calculateWaterRequirement', () {
    test('base 33 ml por kg en sedentario', () {
      final water = NutritionCalculatorService.calculateWaterRequirement(
        weightKg: 70,
        activityLevel: ActivityLevel.sedentary,
      );
      expect(water.milliliters, closeTo(2310.0, 0.001));
      expect(water.liters, closeTo(2.31, 0.001));
      expect(water.glasses, 9);
    });

    test('multiplica por actividad moderada', () {
      final water = NutritionCalculatorService.calculateWaterRequirement(
        weightKg: 70,
        activityLevel: ActivityLevel.moderatelyActive,
      );
      expect(water.milliliters, closeTo(2772.0, 0.001));
      expect(water.glasses, 11);
    });

    test('clima cálido añade 15%', () {
      final water = NutritionCalculatorService.calculateWaterRequirement(
        weightKg: 70,
        activityLevel: ActivityLevel.sedentary,
        isHotClimate: true,
      );
      expect(water.milliliters, closeTo(2656.5, 0.001));
      expect(water.glasses, 11);
    });
  });

  group('NutritionCalculatorService.evaluateWaistCircumference', () {
    test('hombre bajo el umbral: riesgo bajo', () {
      final risk = NutritionCalculatorService.evaluateWaistCircumference(
        waistCm: 85,
        gender: Gender.male,
      );
      expect(risk.level, RiskLevel.low);
    });

    test('hombre entre umbrales: riesgo moderado', () {
      final risk = NutritionCalculatorService.evaluateWaistCircumference(
        waistCm: 95,
        gender: Gender.male,
      );
      expect(risk.level, RiskLevel.moderate);
    });

    test('hombre sobre 102 cm: riesgo alto', () {
      final risk = NutritionCalculatorService.evaluateWaistCircumference(
        waistCm: 105,
        gender: Gender.male,
      );
      expect(risk.level, RiskLevel.high);
    });

    test('mujer usa umbrales 80/88 cm', () {
      expect(
        NutritionCalculatorService.evaluateWaistCircumference(
          waistCm: 75,
          gender: Gender.female,
        ).level,
        RiskLevel.low,
      );
      expect(
        NutritionCalculatorService.evaluateWaistCircumference(
          waistCm: 85,
          gender: Gender.female,
        ).level,
        RiskLevel.moderate,
      );
      expect(
        NutritionCalculatorService.evaluateWaistCircumference(
          waistCm: 90,
          gender: Gender.female,
        ).level,
        RiskLevel.high,
      );
    });
  });

  group('NutritionCalculatorService.calculateWaistHipRatio', () {
    test('hombre: umbrales 0.90 / 1.0', () {
      expect(
        NutritionCalculatorService.calculateWaistHipRatio(
          waistCm: 85,
          hipCm: 100,
          gender: Gender.male,
        ).risk,
        RiskLevel.low,
      );
      expect(
        NutritionCalculatorService.calculateWaistHipRatio(
          waistCm: 95,
          hipCm: 100,
          gender: Gender.male,
        ).risk,
        RiskLevel.moderate,
      );
      expect(
        NutritionCalculatorService.calculateWaistHipRatio(
          waistCm: 105,
          hipCm: 100,
          gender: Gender.male,
        ).risk,
        RiskLevel.high,
      );
    });

    test('mujer: umbrales 0.80 / 0.85', () {
      expect(
        NutritionCalculatorService.calculateWaistHipRatio(
          waistCm: 75,
          hipCm: 100,
          gender: Gender.female,
        ).risk,
        RiskLevel.low,
      );
      expect(
        NutritionCalculatorService.calculateWaistHipRatio(
          waistCm: 82,
          hipCm: 100,
          gender: Gender.female,
        ).risk,
        RiskLevel.moderate,
      );
      expect(
        NutritionCalculatorService.calculateWaistHipRatio(
          waistCm: 90,
          hipCm: 100,
          gender: Gender.female,
        ).risk,
        RiskLevel.high,
      );
    });

    test('calcula el ratio exacto', () {
      final result = NutritionCalculatorService.calculateWaistHipRatio(
        waistCm: 80,
        hipCm: 100,
        gender: Gender.female,
      );
      expect(result.ratio, closeTo(0.8, 0.001));
    });
  });
}
