import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/presentation/screens/onboarding/widgets/onboarding_shared.dart';

/// Paso 5 del onboarding: objetivo nutricional.
class GoalStep extends StatelessWidget {
  const GoalStep({super.key, required this.goal, required this.onChanged});

  final NutritionGoal goal;
  final ValueChanged<NutritionGoal> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingPageHeader(
            icon: Icons.flag,
            title: 'Tu objetivo',
            subtitle: 'Que quieres lograr?',
          ),
          const SizedBox(height: 24),
          ...NutritionGoal.values.map((option) {
            final isSelected = goal == option;
            return Semantics(
              button: true,
              selected: isSelected,
              child: GestureDetector(
                onTap: () => onChanged(option),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? Colors.green.shade600
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.green.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.green.shade100
                              : Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getGoalIcon(option),
                          color: isSelected
                              ? Colors.green.shade600
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option.label,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: isSelected
                                    ? Colors.green.shade700
                                    : Colors.black87,
                              ),
                            ),
                            Text(
                              option.description,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check_circle, color: Colors.green.shade600),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

IconData _getGoalIcon(NutritionGoal goal) {
  switch (goal) {
    case NutritionGoal.loseWeight:
      return Icons.trending_down;
    case NutritionGoal.loseWeightFast:
      return Icons.speed;
    case NutritionGoal.maintainWeight:
      return Icons.balance;
    case NutritionGoal.gainMuscle:
      return Icons.fitness_center;
    case NutritionGoal.gainWeight:
      return Icons.trending_up;
  }
}
