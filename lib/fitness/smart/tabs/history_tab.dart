import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/fitness/smart/smart_fitness.controller.dart';

// ── Tab 3: Historial ──────────────────────────────────────────────────────────
class HistoryTab extends StatelessWidget {
  final Color primaryColor;
  const HistoryTab({super.key, required this.primaryColor});

  SmartFitnessController get _ctrl => Get.find<SmartFitnessController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final history = _ctrl.workoutHistory;
      if (history.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.clockRotateLeft.data,
                size: 48,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 12),
              Text(
                'Sin historial aún',
                style: NutriDesign.font(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: NutriDesign.grey700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Completa un entrenamiento para verlo aquí',
                style: NutriDesign.font(
                  fontSize: 12,
                  color: NutriDesign.grey600,
                ),
              ),
            ],
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (ctx, i) {
          final entry = history[i];
          final date = entry.completedAt;
          final dateStr =
              '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
          return Container(
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    FontAwesomeIcons.fire.data,
                    size: 18,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dateStr,
                        style: NutriDesign.font(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: NutriDesign.grey900,
                        ),
                      ),
                      Text(
                        '${entry.caloriesBurned.toStringAsFixed(0)} kcal · ${(entry.durationSeconds ~/ 60)} min',
                        style: NutriDesign.font(
                          fontSize: 11,
                          color: NutriDesign.grey600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: NutriDesign.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Completado',
                    style: NutriDesign.font(
                      fontSize: 10,
                      color: NutriDesign.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
