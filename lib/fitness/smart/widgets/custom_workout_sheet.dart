import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/fitness/smart/smart_fitness.controller.dart';

import 'workout_detail_sheet.dart';

// ── Custom Workout Sheet ──────────────────────────────────────────────────────
class CustomWorkoutSheet extends StatefulWidget {
  final Color primaryColor;
  const CustomWorkoutSheet({super.key, required this.primaryColor});

  @override
  State<CustomWorkoutSheet> createState() => _CustomWorkoutSheetState();
}

class _CustomWorkoutSheetState extends State<CustomWorkoutSheet> {
  SmartFitnessController get _ctrl => Get.find<SmartFitnessController>();

  late int _duration;
  late int _count;
  late double _calories;

  @override
  void initState() {
    super.initState();
    _duration = _ctrl.customDuration.value;
    _count = _ctrl.customExerciseCount.value;
    _calories = _ctrl.customTargetCalories.value;
  }

  String get _durLabel => '$_duration min';
  String get _cntLabel => '$_count ejercicios';
  String get _calLabel => '${_calories.toStringAsFixed(0)} kcal';

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      maxChildSize: 0.9,
      minChildSize: 0.4,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Personalizar rutina',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: ListView(
                controller: scroll,
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  SliderRow(
                    icon: Icons.timer_outlined,
                    label: 'Duración',
                    value: _durLabel,
                    sliderValue: _duration.toDouble(),
                    min: 5,
                    max: 60,
                    divisions: 11,
                    color: widget.primaryColor,
                    onChanged: (v) => setState(() => _duration = v.toInt()),
                  ),
                  const SizedBox(height: 12),
                  SliderRow(
                    icon: Icons.fitness_center,
                    label: 'Ejercicios',
                    value: _cntLabel,
                    sliderValue: _count.toDouble(),
                    min: 3,
                    max: 10,
                    divisions: 7,
                    color: widget.primaryColor,
                    onChanged: (v) => setState(() => _count = v.toInt()),
                  ),
                  const SizedBox(height: 12),
                  SliderRow(
                    icon: Icons.local_fire_department_outlined,
                    label: 'Calorías objetivo',
                    value: _calLabel,
                    sliderValue: _calories,
                    min: 50,
                    max: 600,
                    divisions: 11,
                    color: NutriDesign.error,
                    onChanged: (v) =>
                        setState(() => _calories = (v ~/ 50 * 50).toDouble()),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _generate,
                      child: Text(
                        'Generar rutina',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _generate() {
    _ctrl.customDuration.value = _duration;
    _ctrl.customExerciseCount.value = _count;
    _ctrl.customTargetCalories.value = _calories;
    final workout = _ctrl.generateCustomWorkout(
      durationMinutes: _duration,
      exerciseCount: _count,
      targetCalories: _calories,
    );
    Navigator.pop(context);
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => WorkoutDetailSheet(
        workout: workout,
        primaryColor: widget.primaryColor,
      ),
    );
  }
}

// ── Slider row helper ─────────────────────────────────────────────────────────
class SliderRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double sliderValue;
  final double min;
  final double max;
  final int divisions;
  final Color color;
  final ValueChanged<double> onChanged;

  const SliderRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.sliderValue,
    required this.min,
    required this.max,
    required this.divisions,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: color,
            thumbColor: color,
            inactiveTrackColor: color.withValues(alpha: 0.2),
            overlayColor: color.withValues(alpha: 0.1),
            trackHeight: 3,
          ),
          child: Slider(
            value: sliderValue,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

// ── Mood Tracker Dialog ───────────────────────────────────────────────────────
