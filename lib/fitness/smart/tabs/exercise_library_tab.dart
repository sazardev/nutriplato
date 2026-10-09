import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/fitness/smart/smart_exercise.model.dart';
import 'package:nutriplato/fitness/smart/smart_fitness.controller.dart';

import '../widgets/exercise_card.dart';
import '../widgets/fitness_common.dart';

// ── Tab 2: Biblioteca de ejercicios ──────────────────────────────────────────
class ExerciseLibraryTab extends StatelessWidget {
  final Color primaryColor;
  const ExerciseLibraryTab({super.key, required this.primaryColor});

  SmartFitnessController get _ctrl => Get.find<SmartFitnessController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chips de categoría
        Obx(() {
          final selected = _ctrl.selectedCategory.value;
          return SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                CategoryChip(
                  label: 'Todos',
                  isSelected: selected == null,
                  color: primaryColor,
                  onTap: () => _ctrl.selectedCategory.value = null,
                ),
                ...ExerciseCategory.values.map(
                  (cat) => CategoryChip(
                    label: cat.label,
                    icon: cat.icon,
                    isSelected: selected == cat,
                    color: cat.color,
                    onTap: () => _ctrl.selectedCategory.value = cat,
                  ),
                ),
              ],
            ),
          );
        }),
        // Chips de equipamiento
        Obx(() {
          final selected = _ctrl.selectedEquipment.value;
          return SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              children: [
                EquipmentChip(
                  label: 'Sin filtro',
                  isSelected: selected == null,
                  color: primaryColor,
                  onTap: () => _ctrl.setEquipmentFilter(null),
                ),
                ...Equipment.values.map(
                  (eq) => EquipmentChip(
                    label: eq.label,
                    icon: eq.icon,
                    isSelected: selected == eq,
                    color: primaryColor,
                    onTap: () => _ctrl.setEquipmentFilter(eq),
                  ),
                ),
              ],
            ),
          );
        }),
        Expanded(
          child: Obx(() {
            final exercises = _ctrl.filteredExercises;
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: exercises.length,
              itemBuilder: (ctx, i) => ExerciseCard(
                exercise: exercises[i],
                primaryColor: primaryColor,
              ),
            );
          }),
        ),
      ],
    );
  }
}
