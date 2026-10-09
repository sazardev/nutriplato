import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/presentation/screens/onboarding/widgets/onboarding_shared.dart';

/// Paso 4 del onboarding: nivel de actividad fisica.
class ActivityStep extends StatelessWidget {
  const ActivityStep({
    super.key,
    required this.activityLevel,
    required this.onChanged,
  });

  final ActivityLevel activityLevel;
  final ValueChanged<ActivityLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingPageHeader(
            icon: Icons.directions_run,
            title: 'Tu actividad fisica',
            subtitle: 'Que tan activo eres en el dia a dia?',
          ),
          const SizedBox(height: 24),
          ...ActivityLevel.values.map((level) {
            final isSelected = activityLevel == level;
            return Semantics(
              button: true,
              selected: isSelected,
              child: GestureDetector(
                onTap: () => onChanged(level),
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
                          _getActivityIcon(level),
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
                              level.label,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: isSelected
                                    ? Colors.green.shade700
                                    : Colors.black87,
                              ),
                            ),
                            Text(
                              level.description,
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

IconData _getActivityIcon(ActivityLevel level) {
  switch (level) {
    case ActivityLevel.sedentary:
      return Icons.weekend;
    case ActivityLevel.lightlyActive:
      return Icons.directions_walk;
    case ActivityLevel.moderatelyActive:
      return Icons.directions_run;
    case ActivityLevel.veryActive:
      return Icons.fitness_center;
    case ActivityLevel.extraActive:
      return Icons.sports_martial_arts;
  }
}
