import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';

/// Tarjeta expandible con el detalle de una condición de salud.
class ConditionCard extends StatelessWidget {
  final HealthCondition condition;
  final VoidCallback onRemove;

  const ConditionCard({
    super.key,
    required this.condition,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.medical_services, color: Colors.red),
        ),
        title: Text(
          condition.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          condition.type.label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          tooltip: 'Quitar condición',
          onPressed: onRemove,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  condition.description,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                if (condition.avoidFoods.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const Text(
                    'Evitar:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: condition.avoidFoods
                        .take(5)
                        .map(
                          (f) => Chip(
                            label: Text(
                              f,
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: Colors.red.shade50,
                            visualDensity: VisualDensity.compact,
                          ),
                        )
                        .toList(),
                  ),
                ],
                if (condition.recommendedFoods.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const Text(
                    'Recomendados:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: condition.recommendedFoods
                        .take(5)
                        .map(
                          (f) => Chip(
                            label: Text(
                              f,
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: Colors.green.shade50,
                            visualDensity: VisualDensity.compact,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
