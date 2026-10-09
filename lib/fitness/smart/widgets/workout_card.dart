import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/fitness/smart/smart_exercise.model.dart';

import 'workout_detail_sheet.dart';

// ── Workout Card ──────────────────────────────────────────────────────────────
class WorkoutCard extends StatelessWidget {
  final SmartWorkout workout;
  final Color primaryColor;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: workout.name,
      child: GestureDetector(
        onTap: () => _showWorkoutDetail(context),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(NutriDesign.radiusLarge),
            gradient: LinearGradient(
              colors: workout.gradients,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: workout.gradients.first.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        workout.name,
                        style: NutriDesign.font(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        workout.overallIntensity.label,
                        style: NutriDesign.font(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                if (workout.reasoning.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    workout.reasoning,
                    style: NutriDesign.font(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    WorkoutStat(
                      icon: FontAwesomeIcons.clock.data,
                      label: '${workout.totalDurationMinutes} min',
                    ),
                    const SizedBox(width: 16),
                    WorkoutStat(
                      icon: FontAwesomeIcons.fire.data,
                      label:
                          '~${workout.estimatedCalories.toStringAsFixed(0)} kcal',
                    ),
                    const SizedBox(width: 16),
                    WorkoutStat(
                      icon: FontAwesomeIcons.layerGroup.data,
                      label: '${workout.exercises.length} ejercicios',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Preview de ejercicios
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: workout.exercises.take(3).map((e) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        e.name,
                        style: NutriDesign.font(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: workout.gradients.first,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _showWorkoutDetail(context),
                    child: Text(
                      'Ver rutina completa',
                      style: NutriDesign.font(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showWorkoutDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          WorkoutDetailSheet(workout: workout, primaryColor: primaryColor),
    );
  }
}

class WorkoutStat extends StatelessWidget {
  final IconData icon;
  final String label;
  const WorkoutStat({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 11, color: Colors.white.withValues(alpha: 0.85)),
        const SizedBox(width: 4),
        Text(
          label,
          style: NutriDesign.font(
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }
}
