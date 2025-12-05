import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/infrastructure/services/food_alert_service.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';

/// Widget que muestra alertas de salud para un alimento
class FoodHealthAlertWidget extends StatelessWidget {
  final Food food;
  final Color baseColor;

  const FoodHealthAlertWidget({
    super.key,
    required this.food,
    required this.baseColor,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, provider, _) {
        final conditions = provider.healthConditions;
        final profile = provider.profile;

        // Si no hay condiciones de salud, no mostrar nada
        if (conditions.isEmpty &&
            profile.allergies.isEmpty &&
            profile.dietaryRestrictions.isEmpty) {
          return const SizedBox.shrink();
        }

        // Evaluar alertas para este alimento
        final FoodAlert foodAlert = FoodAlertService.evaluateFood(
          food: food,
          healthConditions: conditions,
          allergies: profile.allergies,
          dietaryRestrictions: profile.dietaryRestrictions,
        );

        if (!foodAlert.hasAlerts) {
          // Mostrar que el alimento es seguro
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade600),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Este alimento es compatible con tu perfil de salud',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Mostrar alertas
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _getAlertBorderColor(foodAlert.maxSeverity),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header de alertas
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getAlertBackgroundColor(foodAlert.maxSeverity),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getAlertIcon(foodAlert.maxSeverity),
                      color: _getAlertIconColor(foodAlert.maxSeverity),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      foodAlert.shouldAvoid
                          ? 'Alimento NO Recomendado'
                          : 'Alertas de Salud',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: _getAlertTextColor(foodAlert.maxSeverity),
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${foodAlert.alerts.length}',
                        style: TextStyle(
                          color: _getAlertIconColor(foodAlert.maxSeverity),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Lista de alertas
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: foodAlert.alerts
                      .map((AlertItem alert) => _buildAlertItem(alert))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAlertItem(AlertItem alert) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: alert.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            alert.icon,
            color: alert.color,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: alert.color,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  alert.message,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getAlertBackgroundColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.danger:
        return Colors.red.shade50;
      case AlertSeverity.warning:
        return Colors.orange.shade50;
      case AlertSeverity.positive:
        return Colors.green.shade50;
      case AlertSeverity.info:
        return Colors.blue.shade50;
    }
  }

  Color _getAlertBorderColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.danger:
        return Colors.red.shade200;
      case AlertSeverity.warning:
        return Colors.orange.shade200;
      case AlertSeverity.positive:
        return Colors.green.shade200;
      case AlertSeverity.info:
        return Colors.blue.shade200;
    }
  }

  Color _getAlertIconColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.danger:
        return Colors.red.shade600;
      case AlertSeverity.warning:
        return Colors.orange.shade600;
      case AlertSeverity.positive:
        return Colors.green.shade600;
      case AlertSeverity.info:
        return Colors.blue.shade600;
    }
  }

  Color _getAlertTextColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.danger:
        return Colors.red.shade800;
      case AlertSeverity.warning:
        return Colors.orange.shade800;
      case AlertSeverity.positive:
        return Colors.green.shade800;
      case AlertSeverity.info:
        return Colors.blue.shade800;
    }
  }

  IconData _getAlertIcon(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.danger:
        return Icons.dangerous;
      case AlertSeverity.warning:
        return Icons.warning_amber_rounded;
      case AlertSeverity.positive:
        return Icons.check_circle;
      case AlertSeverity.info:
        return Icons.info_outline;
    }
  }
}
