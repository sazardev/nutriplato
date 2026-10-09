import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/fitness/smart/exercise_svg_guide.dart';
import 'package:nutriplato/fitness/smart/smart_exercise.model.dart';
import 'package:nutriplato/fitness/smart/smart_fitness.controller.dart';

import 'mood_tracker_dialog.dart';

// ── Detail Sheet ──────────────────────────────────────────────────────────────
class WorkoutDetailSheet extends StatefulWidget {
  final SmartWorkout workout;
  final Color primaryColor;
  const WorkoutDetailSheet({
    super.key,
    required this.workout,
    required this.primaryColor,
  });

  @override
  State<WorkoutDetailSheet> createState() => _WorkoutDetailSheetState();
}

class _WorkoutDetailSheetState extends State<WorkoutDetailSheet> {
  int _step = 0;
  bool _started = false;

  void _onComplete(BuildContext context) async {
    Navigator.pop(context);
    final mood = await showDialog<WorkoutMood>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => const MoodTrackerDialog(),
    );
    Get.find<SmartFitnessController>().completeWorkout(
      widget.workout,
      1200,
      mood: mood,
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercises = widget.workout.exercises;
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (ctx, scroll) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.workout.name,
                      style: NutriDesign.font(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (!_started)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => setState(() => _started = true),
                      icon: const Icon(Icons.play_arrow, size: 16),
                      label: Text(
                        'Iniciar',
                        style: NutriDesign.font(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  else
                    TextButton(
                      onPressed: () => _onComplete(context),
                      child: Text(
                        'Completar',
                        style: NutriDesign.font(
                          color: NutriDesign.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Ejercicio actual o lista
            Expanded(
              child: _started
                  ? ExerciseStepView(
                      exercises: exercises,
                      step: _step,
                      primaryColor: widget.primaryColor,
                      onNext: () {
                        if (_step < exercises.length - 1) {
                          setState(() => _step++);
                        }
                      },
                      onPrev: () {
                        if (_step > 0) setState(() => _step--);
                      },
                    )
                  : ListView.builder(
                      controller: scroll,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: exercises.length,
                      itemBuilder: (_, i) => ExerciseListTile(
                        exercise: exercises[i],
                        index: i + 1,
                        primaryColor: widget.primaryColor,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Exercise step view (during workout) ──────────────────────────────────────
class ExerciseStepView extends StatelessWidget {
  final List<SmartExercise> exercises;
  final int step;
  final Color primaryColor;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const ExerciseStepView({
    super.key,
    required this.exercises,
    required this.step,
    required this.primaryColor,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    final exercise = exercises[step];
    final currentStep = exercise.steps.isNotEmpty ? exercise.steps.first : null;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Progress
          LinearProgressIndicator(
            value: (step + 1) / exercises.length,
            backgroundColor: Colors.grey.shade200,
            color: primaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 4),
          Text(
            '${step + 1} / ${exercises.length}',
            style: NutriDesign.font(fontSize: 11, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          // SVG Guide
          ExerciseSvgGuide(
            position: currentStep?.bodyPosition ?? BodyPosition.standing,
            activeMuscles: exercise.muscleGroups,
            primaryColor: primaryColor,
            size: 180,
          ),
          const SizedBox(height: 12),
          // Músculoss
          ActivatedMusclesLegend(
            muscles: exercise.muscleGroups,
            activeColor: primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            exercise.name,
            style: NutriDesign.font(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            exercise.description,
            style: NutriDesign.font(fontSize: 12, color: NutriDesign.grey600),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          // Navegación
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                onPressed: step > 0 ? onPrev : null,
                icon: const Icon(Icons.chevron_left),
                label: Text('Anterior', style: NutriDesign.font(fontSize: 13)),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: step < exercises.length - 1 ? onNext : null,
                icon: const Icon(Icons.chevron_right),
                label: Text(
                  step < exercises.length - 1 ? 'Siguiente' : 'Terminar',
                  style: NutriDesign.font(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExerciseListTile extends StatelessWidget {
  final SmartExercise exercise;
  final int index;
  final Color primaryColor;

  const ExerciseListTile({
    super.key,
    required this.exercise,
    required this.index,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: NutriDesign.backgroundLight,
        borderRadius: BorderRadius.circular(NutriDesign.radiusMedium),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: NutriDesign.font(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${exercise.baseQuantity} ${exercise.metric == ExerciseMetric.reps
                      ? "reps"
                      : exercise.metric == ExerciseMetric.seconds
                      ? "seg"
                      : "m"}',
                  style: NutriDesign.font(
                    fontSize: 11,
                    color: NutriDesign.grey600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            exercise.category.icon,
            size: 16,
            color: exercise.category.color,
          ),
        ],
      ),
    );
  }
}
