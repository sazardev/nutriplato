import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/fitness/smart/smart_fitness.controller.dart';

import '../widgets/custom_workout_sheet.dart';
import '../widgets/fitness_common.dart';
import '../widgets/workout_card.dart';
import '../widgets/workout_detail_sheet.dart';

// ── Tab 1: Recomendaciones ────────────────────────────────────────────────────
class RecommendationsTab extends StatefulWidget {
  final Color primaryColor;
  const RecommendationsTab({super.key, required this.primaryColor});

  @override
  State<RecommendationsTab> createState() => _RecommendationsTabState();
}

class _RecommendationsTabState extends State<RecommendationsTab> {
  SmartFitnessController get _ctrl => Get.find<SmartFitnessController>();

  static const _energyEmojis = ['😴', '😐', '🙂', '💪', '🔥'];
  static const _energyLabels = [
    'Agotado',
    'Normal',
    'Bien',
    'Energizado',
    'Al máximo',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Barra de acciones ─────────────────────────────────────────────
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _onRandomTap,
                  icon: const Icon(Icons.shuffle_rounded, size: 16),
                  label: Text(
                    'Aleatorio',
                    style: NutriDesign.font(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: widget.primaryColor,
                    side: BorderSide(color: widget.primaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _showCustomSheet(context),
                  icon: const Icon(Icons.tune_rounded, size: 16),
                  label: Text(
                    'Personalizar',
                    style: NutriDesign.font(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // ── Selector de energía ───────────────────────────────────────────
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 2, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¿Cómo te sientes ahora?',
                style: NutriDesign.font(
                  fontSize: 11,
                  color: NutriDesign.grey600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Obx(() {
                final current = _ctrl.energyLevel.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (i) {
                    final level = i + 1;
                    final selected = current == level;
                    return Semantics(
                      button: true,
                      selected: selected,
                      label: 'Nivel de energía: ${_energyLabels[i]}',
                      excludeSemantics: true,
                      child: GestureDetector(
                        onTap: () => _ctrl.updateEnergyLevel(level),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? widget.primaryColor
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: selected
                                  ? widget.primaryColor
                                  : Colors.transparent,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ExcludeSemantics(
                                child: Text(
                                  _energyEmojis[i],
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Text(
                                _energyLabels[i],
                                style: NutriDesign.font(
                                  fontSize: 9,
                                  color: selected
                                      ? Colors.white
                                      : NutriDesign.grey600,
                                  fontWeight: selected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }),
            ],
          ),
        ),
        const Divider(height: 1),
        // ── Lista de rutinas ──────────────────────────────────────────────
        Expanded(
          child: Obx(() {
            final workouts = _ctrl.recommendedWorkouts;
            if (workouts.isEmpty) {
              return EmptyRecommendations(primaryColor: widget.primaryColor);
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: workouts.length,
              itemBuilder: (ctx, i) => WorkoutCard(
                workout: workouts[i],
                primaryColor: widget.primaryColor,
              ),
            );
          }),
        ),
      ],
    );
  }

  void _onRandomTap() {
    final workout = _ctrl.generateRandomWorkout();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => WorkoutDetailSheet(
        workout: workout,
        primaryColor: widget.primaryColor,
      ),
    );
  }

  void _showCustomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CustomWorkoutSheet(primaryColor: widget.primaryColor),
    );
  }
}
