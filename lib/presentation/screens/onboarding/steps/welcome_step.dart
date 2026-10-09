import 'package:flutter/material.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/presentation/screens/onboarding/widgets/onboarding_shared.dart';

/// Paso 1 del onboarding: bienvenida y caracteristicas de la app.
class WelcomeStep extends StatelessWidget {
  const WelcomeStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo animado
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: MediaQuery.disableAnimationsOf(context)
                ? Duration.zero
                : const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ExcludeSemantics(
                    child: Icon(
                      Icons.restaurant_menu,
                      size: 70,
                      color: Colors.green.shade600,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          Text(
            'Bienvenido a',
            style: NutriDesign.font(fontSize: 20, color: Colors.white),
          ),
          Text(
            'NutriPlato',
            style: NutriDesign.font(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              children: [
                OnboardingFeatureItem(
                  icon: Icons.restaurant,
                  title: 'Nutricion personalizada',
                  subtitle: 'Planes basados en tus necesidades',
                ),
                SizedBox(height: 16),
                OnboardingFeatureItem(
                  icon: Icons.health_and_safety,
                  title: 'Cuida tu salud',
                  subtitle: 'Alertas para condiciones medicas',
                ),
                SizedBox(height: 16),
                OnboardingFeatureItem(
                  icon: Icons.insights,
                  title: 'Aprende cada dia',
                  subtitle: 'Datos curiosos y consejos',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
