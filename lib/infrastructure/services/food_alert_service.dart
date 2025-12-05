import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';

/// Severidad de una alerta
enum AlertSeverity {
  info,
  positive,
  warning,
  danger,
}

/// Item de alerta individual
class AlertItem {
  final AlertSeverity severity;
  final String title;
  final String message;
  final IconData icon;
  final Color color;

  const AlertItem({
    required this.severity,
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
  });
}

/// Resultado de evaluación de alimento
class FoodAlert {
  final Food food;
  final List<AlertItem> alerts;
  final AlertSeverity maxSeverity;
  final bool isRecommended;
  final bool shouldAvoid;

  const FoodAlert({
    required this.food,
    required this.alerts,
    required this.maxSeverity,
    required this.isRecommended,
    required this.shouldAvoid,
  });

  bool get hasAlerts => alerts.isNotEmpty;
  bool get hasDangerAlerts =>
      alerts.any((a) => a.severity == AlertSeverity.danger);
  bool get hasWarningAlerts =>
      alerts.any((a) => a.severity == AlertSeverity.warning);
  bool get hasPositiveAlerts =>
      alerts.any((a) => a.severity == AlertSeverity.positive);
}

/// Servicio para generar alertas de alimentos basadas en condiciones de salud
class FoodAlertService {
  /// Evalúa un alimento contra las condiciones de salud del usuario
  static FoodAlert evaluateFood({
    required Food food,
    required List<HealthCondition> healthConditions,
    List<String>? allergies,
    List<String>? dietaryRestrictions,
  }) {
    final List<AlertItem> alerts = [];
    AlertSeverity maxSeverity = AlertSeverity.info;

    // Evaluar contra cada condición de salud
    for (final condition in healthConditions) {
      // Verificar alimentos a evitar
      for (final avoidFood in condition.avoidFoods) {
        if (_matchesFood(food.name, avoidFood)) {
          alerts.add(AlertItem(
            severity: AlertSeverity.danger,
            title: 'Evitar para ${condition.name}',
            message: '${food.name} está en la lista de alimentos a evitar.',
            icon: Icons.dangerous,
            color: Colors.red,
          ));
          maxSeverity = AlertSeverity.danger;
        }
      }

      // Verificar alimentos a limitar
      for (final limitFood in condition.limitFoods) {
        if (_matchesFood(food.name, limitFood)) {
          alerts.add(AlertItem(
            severity: AlertSeverity.warning,
            title: 'Limitar para ${condition.name}',
            message: '${food.name} debe consumirse con moderación.',
            icon: Icons.warning_amber_rounded,
            color: Colors.orange,
          ));
          if (maxSeverity != AlertSeverity.danger) {
            maxSeverity = AlertSeverity.warning;
          }
        }
      }

      // Verificar alertas específicas por nutrientes
      final nutrientAlerts = _checkNutrientAlerts(food, condition);
      alerts.addAll(nutrientAlerts);

      for (final alert in nutrientAlerts) {
        if (alert.severity == AlertSeverity.danger) {
          maxSeverity = AlertSeverity.danger;
        } else if (alert.severity == AlertSeverity.warning &&
            maxSeverity != AlertSeverity.danger) {
          maxSeverity = AlertSeverity.warning;
        }
      }

      // Verificar si es un alimento recomendado
      for (final recFood in condition.recommendedFoods) {
        if (_matchesFood(food.name, recFood)) {
          alerts.add(AlertItem(
            severity: AlertSeverity.positive,
            title: 'Recomendado para ${condition.name}',
            message: '${food.name} es beneficioso para tu condición.',
            icon: Icons.thumb_up,
            color: Colors.green,
          ));
        }
      }
    }

    // Verificar alergias
    if (allergies != null) {
      for (final allergy in allergies) {
        if (_matchesFood(food.name, allergy) ||
            (food.description?.toLowerCase().contains(allergy.toLowerCase()) ??
                false)) {
          alerts.add(AlertItem(
            severity: AlertSeverity.danger,
            title: '⚠️ ALERGIA DETECTADA',
            message: 'Este alimento puede contener $allergy.',
            icon: Icons.error,
            color: Colors.red.shade800,
          ));
          maxSeverity = AlertSeverity.danger;
        }
      }
    }

    // Verificar restricciones dietéticas
    if (dietaryRestrictions != null) {
      for (final restriction in dietaryRestrictions) {
        final restrictionAlert = _checkDietaryRestriction(food, restriction);
        if (restrictionAlert != null) {
          alerts.add(restrictionAlert);
          if (restrictionAlert.severity == AlertSeverity.danger) {
            maxSeverity = AlertSeverity.danger;
          }
        }
      }
    }

    return FoodAlert(
      food: food,
      alerts: alerts,
      maxSeverity: maxSeverity,
      isRecommended: alerts.any((a) => a.severity == AlertSeverity.positive),
      shouldAvoid: maxSeverity == AlertSeverity.danger,
    );
  }

  /// Verifica si el nombre del alimento coincide
  static bool _matchesFood(String foodName, String searchTerm) {
    final normalizedFood = _normalize(foodName);
    final normalizedSearch = _normalize(searchTerm);

    return normalizedFood.contains(normalizedSearch) ||
        normalizedSearch.contains(normalizedFood);
  }

  /// Normaliza texto para comparación
  static String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ñ', 'n');
  }

  /// Verifica alertas basadas en nutrientes
  static List<AlertItem> _checkNutrientAlerts(
    Food food,
    HealthCondition condition,
  ) {
    final alerts = <AlertItem>[];

    final carbohidratos = double.tryParse(food.hidratosDeCarbono) ?? 0;
    final lipidos = double.tryParse(food.lipidos) ?? 0;

    // Alertas para diabéticos
    if (condition.alertOnHighGlycemicIndex) {
      if (carbohidratos > 25) {
        alerts.add(AlertItem(
          severity: AlertSeverity.warning,
          title: 'Alto en carbohidratos',
          message: 'Contiene ${carbohidratos}g de carbohidratos por porción.',
          icon: Icons.cake,
          color: Colors.orange,
        ));
      }
    }

    if (condition.alertOnHighSugar) {
      if (_isHighSugarFood(food)) {
        alerts.add(AlertItem(
          severity: AlertSeverity.warning,
          title: 'Puede tener azúcar alto',
          message: 'Este alimento puede elevar rápidamente la glucosa.',
          icon: Icons.local_cafe,
          color: Colors.orange,
        ));
      }
    }

    if (condition.alertOnHighSodium) {
      if (_isHighSodiumFood(food)) {
        alerts.add(AlertItem(
          severity: AlertSeverity.warning,
          title: 'Posiblemente alto en sodio',
          message: 'Verifica el contenido de sodio antes de consumir.',
          icon: Icons.water_drop,
          color: Colors.blue,
        ));
      }
    }

    if (condition.alertOnHighFat) {
      if (lipidos > 15) {
        alerts.add(AlertItem(
          severity: AlertSeverity.warning,
          title: 'Alto en grasas',
          message: 'Contiene ${lipidos}g de grasas por porción.',
          icon: Icons.opacity,
          color: Colors.amber,
        ));
      }
    }

    return alerts;
  }

  static bool _isHighSugarFood(Food food) {
    final name = _normalize(food.name);
    final highSugarKeywords = [
      'dulce',
      'azucar',
      'miel',
      'caramelo',
      'chocolate',
      'pastel',
      'galleta',
      'helado',
      'refresco',
      'jugo',
      'mermelada',
      'jarabe',
      'almibar',
      'pan dulce',
    ];
    return highSugarKeywords.any((keyword) => name.contains(keyword));
  }

  static bool _isHighSodiumFood(Food food) {
    final name = _normalize(food.name);
    final highSodiumKeywords = [
      'sal',
      'embutido',
      'jamon',
      'tocino',
      'salchicha',
      'queso',
      'encurtido',
      'sopa instantanea',
      'botana',
      'chicharron',
      'cecina',
      'chorizo',
    ];
    return highSodiumKeywords.any((keyword) => name.contains(keyword));
  }

  static AlertItem? _checkDietaryRestriction(Food food, String restriction) {
    final name = _normalize(food.name);
    final category = _normalize(food.category);

    switch (restriction.toLowerCase()) {
      case 'vegetariano':
        if (category.contains('animal') ||
            _containsAny(name,
                ['carne', 'pollo', 'pescado', 'res', 'cerdo', 'mariscos'])) {
          return AlertItem(
            severity: AlertSeverity.danger,
            title: 'No vegetariano',
            message: 'Este alimento no es apto para vegetarianos.',
            icon: Icons.eco,
            color: Colors.green.shade700,
          );
        }
        break;

      case 'vegano':
        if (category.contains('animal') ||
            _containsAny(name, [
              'carne',
              'pollo',
              'pescado',
              'leche',
              'queso',
              'huevo',
              'miel',
              'mantequilla',
              'crema',
              'yogurt'
            ])) {
          return AlertItem(
            severity: AlertSeverity.danger,
            title: 'No vegano',
            message: 'Este alimento no es apto para veganos.',
            icon: Icons.eco,
            color: Colors.green.shade900,
          );
        }
        break;

      case 'sin gluten':
        if (_containsAny(name, [
          'trigo',
          'pan',
          'pasta',
          'galleta',
          'cereal',
          'avena',
          'cebada',
          'centeno'
        ])) {
          return AlertItem(
            severity: AlertSeverity.danger,
            title: 'Contiene gluten',
            message: 'Este alimento puede contener gluten.',
            icon: Icons.grain,
            color: Colors.brown,
          );
        }
        break;

      case 'sin lactosa':
        if (_containsAny(name,
            ['leche', 'queso', 'yogurt', 'crema', 'mantequilla', 'helado'])) {
          return AlertItem(
            severity: AlertSeverity.danger,
            title: 'Contiene lactosa',
            message: 'Este alimento puede contener lactosa.',
            icon: Icons.local_drink,
            color: Colors.blue.shade300,
          );
        }
        break;

      case 'kosher':
        if (_containsAny(name, ['cerdo', 'mariscos', 'tocino', 'jamon'])) {
          return AlertItem(
            severity: AlertSeverity.danger,
            title: 'No Kosher',
            message: 'Este alimento no cumple con las reglas Kosher.',
            icon: Icons.star_border,
            color: Colors.indigo,
          );
        }
        break;

      case 'halal':
        if (_containsAny(name, ['cerdo', 'tocino', 'jamon', 'alcohol'])) {
          return AlertItem(
            severity: AlertSeverity.danger,
            title: 'No Halal',
            message: 'Este alimento no cumple con las reglas Halal.',
            icon: Icons.star_border,
            color: Colors.teal,
          );
        }
        break;
    }

    return null;
  }

  static bool _containsAny(String text, List<String> keywords) {
    return keywords.any((keyword) => text.contains(keyword));
  }

  /// Genera sugerencias de alimentos alternativos
  static List<String> suggestAlternatives({
    required Food food,
    required List<HealthCondition> healthConditions,
  }) {
    final suggestions = <String>[];
    final foodName = _normalize(food.name);

    if (healthConditions
        .any((c) => c.id == 'diabetes_type_2' || c.id == 'prediabetes')) {
      if (foodName.contains('refresco')) {
        suggestions.add('Agua natural con limón');
        suggestions.add('Agua de jamaica sin azúcar');
      }
      if (foodName.contains('pan blanco')) {
        suggestions.add('Pan integral');
        suggestions.add('Tortilla de maíz');
      }
      if (foodName.contains('arroz blanco')) {
        suggestions.add('Arroz integral');
        suggestions.add('Quinoa');
      }
    }

    if (healthConditions.any((c) => c.id == 'hipertension')) {
      if (_isHighSodiumFood(food)) {
        suggestions.add('Versión baja en sodio');
        suggestions.add('Preparado en casa sin sal');
      }
    }

    if (healthConditions.any((c) => c.id == 'colesterol_alto')) {
      if (foodName.contains('mantequilla')) {
        suggestions.add('Aceite de oliva');
        suggestions.add('Aguacate');
      }
      if (foodName.contains('huevo')) {
        suggestions.add('Claras de huevo');
      }
    }

    return suggestions;
  }
}

/// Widget para mostrar alertas de alimentos
class FoodAlertWidget extends StatelessWidget {
  final FoodAlert alert;
  final bool showAllAlerts;

  const FoodAlertWidget({
    super.key,
    required this.alert,
    this.showAllAlerts = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!alert.hasAlerts) return const SizedBox.shrink();

    final displayAlerts = showAllAlerts ? alert.alerts : [alert.alerts.first];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final alertItem in displayAlerts)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: alertItem.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: alertItem.color.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(alertItem.icon, color: alertItem.color, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alertItem.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: alertItem.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        alertItem.message,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Badge de alerta rápida
class FoodAlertBadge extends StatelessWidget {
  final FoodAlert alert;

  const FoodAlertBadge({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    if (!alert.hasAlerts) return const SizedBox.shrink();

    Color badgeColor;
    IconData badgeIcon;

    switch (alert.maxSeverity) {
      case AlertSeverity.danger:
        badgeColor = Colors.red;
        badgeIcon = Icons.dangerous;
      case AlertSeverity.warning:
        badgeColor = Colors.orange;
        badgeIcon = Icons.warning;
      case AlertSeverity.positive:
        badgeColor = Colors.green;
        badgeIcon = Icons.thumb_up;
      case AlertSeverity.info:
        badgeColor = Colors.blue;
        badgeIcon = Icons.info;
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        badgeIcon,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}
