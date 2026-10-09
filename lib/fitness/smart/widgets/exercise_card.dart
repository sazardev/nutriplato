import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/fitness/smart/exercise_svg_guide.dart';
import 'package:nutriplato/fitness/smart/smart_exercise.model.dart';

// ── Exercise Card (biblioteca) ─────────────────────────────────────────────────
class ExerciseCard extends StatelessWidget {
  final SmartExercise exercise;
  final Color primaryColor;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: exercise.name,
      child: GestureDetector(
        onTap: () => _showDetail(context),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(NutriDesign.radiusMedium),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: exercise.category.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  exercise.category.icon,
                  color: exercise.category.color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: NutriDesign.grey900,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: exercise.intensity.color.withValues(
                              alpha: 0.12,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            exercise.intensity.label,
                            style: TextStyle(
                              fontSize: 9,
                              color: exercise.intensity.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '${exercise.baseQuantity} ${_metricLabel(exercise.metric)}',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: NutriDesign.grey600,
                          ),
                        ),
                        if (exercise.requiresEquipment) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  exercise.equipment.icon,
                                  size: 9,
                                  color: Colors.blueGrey,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  exercise.equipment.label,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.blueGrey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  static String _metricLabel(ExerciseMetric m) {
    switch (m) {
      case ExerciseMetric.reps:
        return 'reps';
      case ExerciseMetric.seconds:
        return 'seg';
      case ExerciseMetric.distance:
        return 'm';
    }
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          ExerciseDetailSheet(exercise: exercise, primaryColor: primaryColor),
    );
  }
}

// ── Exercise detail sheet ─────────────────────────────────────────────────────
class ExerciseDetailSheet extends StatefulWidget {
  final SmartExercise exercise;
  final Color primaryColor;
  const ExerciseDetailSheet({
    super.key,
    required this.exercise,
    required this.primaryColor,
  });

  @override
  State<ExerciseDetailSheet> createState() => _ExerciseDetailSheetState();
}

class _ExerciseDetailSheetState extends State<ExerciseDetailSheet> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final e = widget.exercise;
    final steps = e.steps;
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (ctx, scroll) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          controller: scroll,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: e.category.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      e.category.icon,
                      color: e.category.color,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.name,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          e.category.label,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: e.category.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // SVG Guide con selector de paso
              if (steps.isNotEmpty) ...[
                Center(
                  child: ExerciseSvgGuide(
                    position: steps[_currentStep].bodyPosition,
                    activeMuscles: e.muscleGroups,
                    primaryColor: widget.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                // Chips de pasos
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: steps.length,
                    itemBuilder: (_, i) => Semantics(
                      button: true,
                      selected: _currentStep == i,
                      child: GestureDetector(
                        onTap: () => setState(() => _currentStep = i),
                        child: Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _currentStep == i
                                ? widget.primaryColor
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Paso ${i + 1}${steps[i].isStartPosition ? " (inicio)" : ""}',
                            style: TextStyle(
                              fontSize: 11,
                              color: _currentStep == i
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  steps[_currentStep].instruction,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: NutriDesign.grey900,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              // Músculos
              ActivatedMusclesLegend(
                muscles: e.muscleGroups,
                activeColor: widget.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Descripción',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                e.description,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: NutriDesign.grey600,
                ),
              ),
              if (e.tips.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Consejos',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ...e.tips.map(
                  (t) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 14,
                          color: widget.primaryColor,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            t,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: NutriDesign.grey600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (e.contraindications.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Precauciones',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: NutriDesign.error,
                  ),
                ),
                const SizedBox(height: 8),
                ...e.contraindications.map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.warning_amber_outlined,
                          size: 14,
                          color: NutriDesign.error,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            c,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: NutriDesign.grey600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
