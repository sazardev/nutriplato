import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/fitness/smart/smart_fitness.controller.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_provider.dart';
import 'package:provider/provider.dart';

/// Balance calórico del día: kcal consumidas − kcal quemadas con ejercicio.
class CalorieBalanceCard extends StatelessWidget {
  const CalorieBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodLogProvider>(
      builder: (context, foodLog, _) {
        final dailyLog = foodLog.getDailyLog(DateTime.now());
        final consumed = dailyLog?.totalCalories ?? 0;

        return Obx(() {
          final burned =
              Get.find<SmartFitnessController>().todayCaloriesBurned.value;
          final net = consumed - burned;

          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.compare_arrows, color: _netColor(net)),
                      const SizedBox(width: 8),
                      Text(
                        'Balance calórico del día',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat(
                        'Consumidas',
                        '${consumed.round()}',
                        'kcal',
                        Icons.restaurant,
                        Colors.red.shade400,
                      ),
                      _buildStat(
                        'Quemadas',
                        '${burned.round()}',
                        'kcal',
                        Icons.directions_run,
                        Colors.green.shade500,
                      ),
                      _buildStat(
                        'Balance neto',
                        net >= 0 ? '+${net.round()}' : '${net.round()}',
                        'kcal',
                        Icons.balance,
                        _netColor(net),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _netColor(net).withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _netMessage(net),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: _netColor(net),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Color _netColor(double net) {
    if (net > 250) return Colors.orange.shade700;
    if (net > 0) return Colors.amber.shade700;
    if (net < -250) return Colors.green.shade700;
    return Colors.green.shade600;
  }

  String _netMessage(double net) {
    if (net > 250) {
      return 'Superaste tu objetivo de gasto. Ajusta tu alimentación o aumenta la actividad.';
    }
    if (net > 0) {
      return 'Vas bien: quemaste más de lo que consumiste hasta ahora.';
    }
    if (net < -250) {
      return 'Has consumido de más hoy. Considera un paseo o una rutina rápida.';
    }
    return 'Excelente balance entre lo que consumes y quemas.';
  }

  Widget _buildStat(
    String label,
    String value,
    String unit,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(unit, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
        ),
      ],
    );
  }
}
