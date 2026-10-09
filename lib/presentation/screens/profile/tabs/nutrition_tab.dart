import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';
import 'package:nutriplato/presentation/screens/profile/tabs/achievements_tab.dart';
import 'package:nutriplato/presentation/screens/profile/widgets/nutrition_cards.dart';

/// Pestaña con los requerimientos nutricionales calculados.
class NutritionTab extends StatelessWidget {
  final UserProfile profile;
  final NutritionCalculation? calculation;

  const NutritionTab({
    super.key,
    required this.profile,
    required this.calculation,
  });

  @override
  Widget build(BuildContext context) {
    final calc = calculation;
    if (calc == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 64,
                color: Colors.orange.shade300,
              ),
              const SizedBox(height: 16),
              Text(
                'Completa tu perfil',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Necesitamos tu altura, peso, edad y género para calcular tus requerimientos nutricionales.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calorías diarias
          CalorieCard(calculation: calc),

          const SizedBox(height: 16),

          // Macronutrientes
          const ProfileSectionTitle(title: 'Macronutrientes Diarios'),
          MacroCard(macros: calc.macros),
          const SizedBox(height: 16),

          // Agua
          const ProfileSectionTitle(title: 'Hidratación'),
          WaterCard(water: calc.waterRequirement),
          const SizedBox(height: 16),

          // Peso ideal
          const ProfileSectionTitle(title: 'Peso Ideal'),
          IdealWeightCard(idealWeight: calc.idealWeight, profile: profile),
          const SizedBox(height: 16),

          // Proyección de peso
          if (calc.weightProjection != null) ...[
            const ProfileSectionTitle(title: 'Proyección'),
            ProjectionCard(projection: calc.weightProjection!),
          ],
        ],
      ),
    );
  }
}
