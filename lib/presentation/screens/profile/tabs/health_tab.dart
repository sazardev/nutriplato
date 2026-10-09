import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/presentation/screens/profile/tabs/achievements_tab.dart';
import 'package:nutriplato/presentation/screens/profile/widgets/condition_card.dart';

/// Pestaña con condiciones de salud, alergias y restricciones.
class HealthTab extends StatelessWidget {
  final List<HealthCondition> conditions;
  final UserProfile profile;
  final VoidCallback onAddCondition;
  final ValueChanged<HealthCondition> onRemoveCondition;

  const HealthTab({
    super.key,
    required this.conditions,
    required this.profile,
    required this.onAddCondition,
    required this.onRemoveCondition,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileSectionTitle(title: 'Condiciones de Salud'),
          if (conditions.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.health_and_safety,
                      size: 48,
                      color: Colors.green.shade300,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No has registrado condiciones de salud',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: onAddCondition,
                      child: const Text('Agregar condición'),
                    ),
                  ],
                ),
              ),
            )
          else
            ...conditions.map(
              (condition) => ConditionCard(
                condition: condition,
                onRemove: () => onRemoveCondition(condition),
              ),
            ),
          const SizedBox(height: 16),
          if (conditions.isNotEmpty)
            Center(
              child: TextButton.icon(
                onPressed: onAddCondition,
                icon: const Icon(Icons.add),
                label: const Text('Agregar otra condición'),
              ),
            ),
          const SizedBox(height: 24),
          const ProfileSectionTitle(title: 'Alergias'),
          if (profile.allergies.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No has registrado alergias'),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: profile.allergies
                  .map(
                    (allergy) => Chip(
                      label: Text(allergy),
                      backgroundColor: Colors.red.shade100,
                      avatar: const Icon(Icons.warning, size: 18),
                    ),
                  )
                  .toList(),
            ),
          const SizedBox(height: 24),
          const ProfileSectionTitle(title: 'Restricciones Dietéticas'),
          if (profile.dietaryRestrictions.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No has registrado restricciones'),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: profile.dietaryRestrictions
                  .map(
                    (restriction) => Chip(
                      label: Text(restriction),
                      backgroundColor: Colors.green.shade100,
                      avatar: const Icon(Icons.eco, size: 18),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
