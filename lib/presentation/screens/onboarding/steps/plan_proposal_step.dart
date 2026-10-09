import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/services/smart_nutrition_service.dart';
import 'package:nutriplato/presentation/screens/onboarding/models/plan_proposal.dart';
import 'package:nutriplato/presentation/screens/onboarding/widgets/onboarding_shared.dart';

/// Paso 7 del onboarding: resumen del plan personalizado calculado.
class PlanProposalStep extends StatelessWidget {
  const PlanProposalStep({
    super.key,
    required this.proposal,
    required this.goal,
    required this.targetWeight,
    required this.planApplied,
    required this.onApplyPlan,
  });

  final PlanProposal proposal;
  final NutritionGoal goal;
  final double? targetWeight;
  final bool planApplied;
  final Future<void> Function() onApplyPlan;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingPageHeader(
            icon: Icons.auto_awesome,
            title: 'Tu plan personalizado',
            subtitle: 'Calculado con tu perfil y el algoritmo de NutriPlato',
          ),
          const SizedBox(height: 16),
          _buildCalorieHeroCard(proposal),
          const SizedBox(height: 16),
          _buildStatsGrid(proposal),
          const SizedBox(height: 16),
          _buildMacroCard(proposal),
          const SizedBox(height: 16),
          _buildMealDistributionCard(proposal),
          const SizedBox(height: 16),
          _buildMealPlanCard(proposal),
          const SizedBox(height: 16),
          _buildWeightProjectionCard(proposal),
          if (proposal.adjustments.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildAdjustmentsCard(proposal),
          ],
          if (proposal.nutrientLimits.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildNutrientLimitsCard(proposal),
          ],
          const SizedBox(height: 16),
          _buildFoodCards(proposal),
          const SizedBox(height: 16),
          _buildDisclaimerCard(),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: planApplied ? null : onApplyPlan,
              icon: Icon(
                planApplied ? Icons.check_circle : Icons.event_available,
                size: 20,
              ),
              label: Text(
                planApplied
                    ? 'Plan aplicado a tu día'
                    : 'Aplicar plan a mi registro de hoy',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green.shade900,
                disabledBackgroundColor: Colors.white.withValues(alpha: 0.7),
                disabledForegroundColor: Colors.green.shade700,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildCalorieHeroCard(PlanProposal p) {
    return OnboardingWhiteCard(
      padding: 20,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calorías objetivo diarias',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  p.targetCalories.round().toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    'kcal / día',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Tu meta: ${goal.label} · ${goal.description}',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
            if (p.projection != null && p.projection!.weeksToGoal != null) ...[
              const SizedBox(height: 8),
              Text(
                'Proyección: alcanzar tu peso meta en '
                '~${p.projection!.weeksToGoal!.round()} semanas '
                '(${p.projection!.message.replaceFirst('Perderás', 'perdiendo').replaceFirst('Ganarás', 'ganando')})',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(PlanProposal p) {
    Widget stat(IconData icon, String label, String value, Color color) {
      return OnboardingWhiteCard(
        padding: 14,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.green.shade900,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: stat(
                Icons.local_fire_department,
                'TMB',
                '${p.bmr.round()} kcal',
                Colors.orange.shade600,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: stat(
                Icons.bolt,
                'Gasto total (TDEE)',
                '${p.tdee.round()} kcal',
                Colors.amber.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: stat(
                Icons.monitor_weight,
                'IMC · ${p.bmiCategory}',
                p.bmi.toStringAsFixed(1),
                Colors.green.shade600,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: stat(
                Icons.water_drop,
                'Agua (${p.water.liters.toStringAsFixed(1)} L)',
                '${p.water.glasses} vasos',
                Colors.blue.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMacroCard(PlanProposal p) {
    Widget barRow(String label, double percent, double grams, Color color) {
      return Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.green.shade900,
                ),
              ),
              const Spacer(),
              Text(
                '${grams.round()} g · ${percent.round()}%',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 10,
              child: Stack(
                children: [
                  Container(color: Colors.grey.shade200),
                  FractionallySizedBox(
                    widthFactor: (percent / 100).clamp(0.0, 1.0),
                    child: Container(color: color),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      );
    }

    return OnboardingWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnboardingCardTitle(
            text: 'Distribución de macronutrientes',
            icon: Icons.pie_chart,
            color: Colors.green.shade700,
          ),
          const SizedBox(height: 14),
          barRow(
            'Proteína',
            p.macros.proteinPercent,
            p.macros.proteinGrams,
            Colors.green.shade600,
          ),
          barRow(
            'Carbohidratos',
            p.macros.carbPercent,
            p.macros.carbGrams,
            Colors.amber.shade700,
          ),
          barRow(
            'Grasas',
            p.macros.fatPercent,
            p.macros.fatGrams,
            Colors.orange.shade600,
          ),
          Text(
            'Fibra: ${p.macros.fiberGrams.round()} g · '
            'Proteína: ${p.macros.proteinPerKg.toStringAsFixed(1)} g/kg',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealDistributionCard(PlanProposal p) {
    final maxKcal = p.mealDistribution.values.reduce((a, b) => a > b ? a : b);
    return OnboardingWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnboardingCardTitle(
            text: 'Cómo distribuir tus comidas',
            icon: Icons.restaurant,
            color: Colors.green.shade700,
          ),
          const SizedBox(height: 12),
          ...p.mealDistribution.entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 78,
                    child: Text(
                      e.key,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: SizedBox(
                        height: 8,
                        child: Stack(
                          children: [
                            Container(color: Colors.grey.shade200),
                            FractionallySizedBox(
                              widthFactor: (e.value / maxKcal).clamp(0.0, 1.0),
                              child: Container(color: Colors.green.shade500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 56,
                    child: Text(
                      '${e.value.round()} kcal',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMealPlanCard(PlanProposal p) {
    final plan = p.mealPlan;
    final meals = [
      ('Desayuno', plan.breakfast, Icons.wb_sunny, Colors.orange.shade600),
      ('Comida', plan.lunch, Icons.restaurant, Colors.green.shade600),
      ('Cena', plan.dinner, Icons.nights_stay, Colors.indigo.shade400),
      ('Snacks', plan.snacks, Icons.apple, Colors.amber.shade700),
    ];

    return OnboardingWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnboardingCardTitle(
            text: 'Tu plan de comidas de hoy',
            icon: Icons.today,
            color: Colors.green.shade700,
          ),
          const SizedBox(height: 6),
          Text(
            'Generado por el algoritmo con alimentos seguros para tu perfil.',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 14),
          ...meals.map((m) => _buildMealBlock(m.$1, m.$2, m.$3, m.$4)),
        ],
      ),
    );
  }

  Widget _buildMealBlock(
    String title,
    List<MealSuggestion> items,
    IconData icon,
    Color color,
  ) {
    final totalKcal = items.fold<double>(0, (sum, s) => sum + s.calories);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const Spacer(),
              Text(
                '${totalKcal.round()} kcal',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'Sin sugerencias para esta comida.',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            )
          else
            ...items.map(_buildMealItem),
        ],
      ),
    );
  }

  Widget _buildMealItem(MealSuggestion s) {
    final isWhole = s.portions == s.portions.roundToDouble();
    final portions = isWhole
        ? s.portions.toInt().toString()
        : s.portions.toStringAsFixed(1);
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.food.name,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade900,
                  ),
                ),
                Text(
                  '$portions porciones · ${s.calories.round()} kcal',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),
                if (s.preparationTip.isNotEmpty)
                  Text(
                    'Tip: ${s.preparationTip}',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightProjectionCard(PlanProposal p) {
    final ideal = p.idealWeight;
    final proj = p.projection;
    final targetLabel = targetWeight != null
        ? '${targetWeight!.toStringAsFixed(0)} kg'
        : '${ideal.average.toStringAsFixed(0)} kg';

    return OnboardingWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnboardingCardTitle(
            text: 'Tu peso ideal y meta',
            icon: Icons.monitor_weight,
            color: Colors.green.shade700,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildMiniStat(
                'IMC actual',
                p.bmi.toStringAsFixed(1),
                p.bmiCategory,
              ),
              _buildMiniStat(
                'Rango saludable',
                '${ideal.minHealthyWeight.toStringAsFixed(0)}-${ideal.maxHealthyWeight.toStringAsFixed(0)} kg',
                'OMS',
              ),
              _buildMiniStat(
                'Peso meta',
                targetLabel,
                proj != null && proj.weeksToGoal != null
                    ? '~${proj.weeksToGoal!.round()} sem'
                    : 'Mantener',
              ),
            ],
          ),
          if (proj != null) ...[
            const SizedBox(height: 12),
            Text(
              proj.message,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: proj.isRealistic
                    ? Colors.green.shade700
                    : Colors.orange.shade700,
              ),
            ),
            if (!proj.isRealistic)
              Text(
                'Considera ajustar tu meta para un ritmo más saludable.',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
              ),
          ],
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade200, height: 1),
          const SizedBox(height: 12),
          Text(
            'Estimaciones de peso ideal por fórmula',
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildFormulaStat('Devine', ideal.devine),
              _buildFormulaStat('Robinson', ideal.robinson),
              _buildFormulaStat('Miller', ideal.miller),
              _buildFormulaStat('Promedio', ideal.average),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaStat(String label, double value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '${value.toStringAsFixed(0)} kg',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.green.shade900,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, String sub) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.green.shade900,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            sub,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdjustmentsCard(PlanProposal p) {
    return OnboardingWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnboardingCardTitle(
            text: 'Ajustes para tu salud',
            icon: Icons.health_and_safety,
            color: Colors.red.shade600,
          ),
          const SizedBox(height: 12),
          ...p.adjustments.map(
            (adj) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: Colors.green.shade600,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      adj,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientLimitsCard(PlanProposal p) {
    String labelFor(String key) {
      switch (key) {
        case 'sodium':
          return 'Sodio (mg/día)';
        case 'sugar':
          return 'Azúcar (g/día)';
        case 'carbs':
          return 'Carbohidratos (g/día)';
        case 'cholesterol':
          return 'Colesterol (mg/día)';
        case 'saturatedFat':
          return 'Grasa saturada (g/día)';
        case 'protein':
          return 'Proteína (g/kg)';
        case 'potassium':
          return 'Potasio (mg/día)';
        case 'phosphorus':
          return 'Fósforo (mg/día)';
        default:
          return key;
      }
    }

    return OnboardingWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnboardingCardTitle(
            text: 'Límites de nutrientes',
            icon: Icons.speed,
            color: Colors.orange.shade700,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: p.nutrientLimits.entries.map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Text(
                  '${labelFor(e.key)}: máx ${e.value.toStringAsFixed(e.value == e.value.roundToDouble() ? 0 : 1)}',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange.shade900,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCards(PlanProposal p) {
    Widget chips(List<String> items, Color bg, Color text) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: items
            .map(
              (name) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: text,
                  ),
                ),
              ),
            )
            .toList(),
      );
    }

    return Column(
      children: [
        if (p.recommendedFoods.isNotEmpty) ...[
          OnboardingWhiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnboardingCardTitle(
                  text: 'Alimentos recomendados para ti',
                  icon: Icons.thumb_up,
                  color: Colors.green.shade600,
                ),
                const SizedBox(height: 12),
                chips(
                  p.recommendedFoods.take(8).map((s) => s.food.name).toList(),
                  Colors.green.shade50,
                  Colors.green.shade900,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (p.avoidFoods.isNotEmpty)
          OnboardingWhiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnboardingCardTitle(
                  text: 'Alimentos a evitar o limitar',
                  icon: Icons.block,
                  color: Colors.red.shade600,
                ),
                const SizedBox(height: 12),
                chips(
                  p.avoidFoods.take(6).map((s) => s.food.name).toList(),
                  Colors.red.shade50,
                  Colors.red.shade800,
                ),
              ],
            ),
          ),
        if (p.recommendedFoods.isEmpty && p.avoidFoods.isEmpty) ...[
          OnboardingWhiteCard(
            child: Text(
              'Con tu perfil actual no hay restricciones alimentarias '
              'especiales. ¡Disfruta de una alimentación variada!',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDisclaimerCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ExcludeSemantics(
            child: Icon(Icons.info_outline, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Esta propuesta es orientativa y no sustituye la consulta con '
              'un profesional de la salud.',
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
