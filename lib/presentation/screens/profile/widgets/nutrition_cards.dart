import 'package:flutter/material.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/services/nutrition_calculator_service.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';

/// Tarjeta con las calorías diarias (TMB, TDEE y objetivo).
class CalorieCard extends StatelessWidget {
  final NutritionCalculation calculation;

  const CalorieCard({super.key, required this.calculation});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CalorieColumn(
                  label: 'TMB',
                  value: calculation.bmr.round().toString(),
                  unit: 'kcal',
                  color: Colors.blue,
                ),
                CalorieColumn(
                  label: 'TDEE',
                  value: calculation.tdee.round().toString(),
                  unit: 'kcal',
                  color: Colors.orange,
                ),
                CalorieColumn(
                  label: 'Objetivo',
                  value: calculation.targetCalories.round().toString(),
                  unit: 'kcal',
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'TMB: Tasa Metabólica Basal\nTDEE: Gasto Energético Total Diario',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Columna con una métrica de calorías (etiqueta, valor y unidad).
class CalorieColumn extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;

  const CalorieColumn({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: NutriDesign.font(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(unit, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      ],
    );
  }
}

/// Tarjeta con la distribución de macronutrientes.
class MacroCard extends StatelessWidget {
  final MacroDistribution macros;

  const MacroCard({super.key, required this.macros});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            MacroRow(
              name: 'Proteínas',
              grams: macros.proteinGrams,
              percent: macros.proteinPercent,
              color: Colors.red,
            ),
            const SizedBox(height: 12),
            MacroRow(
              name: 'Carbohidratos',
              grams: macros.carbGrams,
              percent: macros.carbPercent,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            MacroRow(
              name: 'Grasas',
              grams: macros.fatGrams,
              percent: macros.fatPercent,
              color: Colors.yellow.shade700,
            ),
            const SizedBox(height: 12),
            MacroRow(
              name: 'Fibra',
              grams: macros.fiberGrams,
              percent: 0,
              color: Colors.green,
              showPercent: false,
            ),
          ],
        ),
      ),
    );
  }
}

/// Fila de un macronutriente con gramos y porcentaje opcional.
class MacroRow extends StatelessWidget {
  final String name;
  final double grams;
  final double percent;
  final Color color;
  final bool showPercent;

  const MacroRow({
    super.key,
    required this.name,
    required this.grams,
    required this.percent,
    required this.color,
    this.showPercent = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          '${grams.round()}g',
          style: NutriDesign.font(fontWeight: FontWeight.bold),
        ),
        if (showPercent) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${percent.round()}%',
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Tarjeta con el requerimiento diario de agua.
class WaterCard extends StatelessWidget {
  final WaterRequirement water;

  const WaterCard({super.key, required this.water});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.water_drop, color: Colors.blue, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${water.liters.toStringAsFixed(1)} litros',
                    style: NutriDesign.font(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    '${water.glasses} vasos de 250ml',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tarjeta con el rango de peso saludable y el peso ideal promedio.
class IdealWeightCard extends StatelessWidget {
  final IdealWeightResult idealWeight;
  final UserProfile profile;

  const IdealWeightCard({
    super.key,
    required this.idealWeight,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rango saludable'),
                    Text(
                      '${idealWeight.minHealthyWeight.toStringAsFixed(1)} - ${idealWeight.maxHealthyWeight.toStringAsFixed(1)} kg',
                      style: NutriDesign.font(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Peso ideal promedio'),
                    Text(
                      '${idealWeight.average.toStringAsFixed(1)} kg',
                      style: NutriDesign.font(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (profile.weightKg != null) ...[
              const SizedBox(height: 16),
              WeightDifferenceIndicator(
                current: profile.weightKg!,
                ideal: idealWeight.average,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Indicador de diferencia entre el peso actual y el ideal.
class WeightDifferenceIndicator extends StatelessWidget {
  final double current;
  final double ideal;

  const WeightDifferenceIndicator({
    super.key,
    required this.current,
    required this.ideal,
  });

  @override
  Widget build(BuildContext context) {
    final difference = current - ideal;
    final isOver = difference > 0;
    final color = difference.abs() < 2
        ? Colors.green
        : isOver
        ? Colors.orange
        : Colors.blue;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            difference.abs() < 2
                ? Icons.check_circle
                : isOver
                ? Icons.arrow_downward
                : Icons.arrow_upward,
            color: color,
          ),
          const SizedBox(width: 12),
          Text(
            difference.abs() < 2
                ? '¡Estás en tu peso ideal!'
                : isOver
                ? 'Te faltan ${difference.abs().toStringAsFixed(1)} kg para tu peso ideal'
                : 'Te faltan ${difference.abs().toStringAsFixed(1)} kg para tu peso ideal',
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

/// Tarjeta con la proyección de la meta de peso.
class ProjectionCard extends StatelessWidget {
  final WeightGoalProjection projection;

  const ProjectionCard({super.key, required this.projection});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  projection.isRealistic
                      ? Icons.check_circle
                      : Icons.warning_amber,
                  color: projection.isRealistic ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    projection.message,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            if (projection.weeksToGoal != null) ...[
              const SizedBox(height: 12),
              Text(
                'Tiempo estimado: ${projection.weeksToGoal!.round()} semanas',
                style: NutriDesign.font(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
