import 'package:flutter/material.dart';
import 'package:nutriplato/presentation/screens/onboarding/widgets/onboarding_shared.dart';

/// Paso 3 del onboarding: fecha de nacimiento, medidas y peso objetivo.
class BodyDataStep extends StatelessWidget {
  const BodyDataStep({
    super.key,
    required this.birthDate,
    required this.height,
    required this.weight,
    required this.targetWeight,
    required this.onBirthDateChanged,
    required this.onHeightChanged,
    required this.onWeightChanged,
    required this.onTargetWeightChanged,
  });

  final DateTime? birthDate;
  final double? height;
  final double? weight;
  final double? targetWeight;
  final ValueChanged<DateTime> onBirthDateChanged;
  final ValueChanged<double> onHeightChanged;
  final ValueChanged<double> onWeightChanged;
  final ValueChanged<double> onTargetWeightChanged;

  @override
  Widget build(BuildContext context) {
    final age = birthDate != null
        ? DateTime.now().difference(birthDate!).inDays ~/ 365
        : 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingPageHeader(
            icon: Icons.straighten,
            title: 'Tus medidas',
            subtitle: 'Para calcular tus necesidades',
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Fecha de nacimiento
                ListTile(
                  leading: Icon(Icons.cake, color: Colors.green.shade600),
                  title: const Text('Fecha de nacimiento'),
                  subtitle: Text(
                    birthDate != null
                        ? '${birthDate!.day}/${birthDate!.month}/${birthDate!.year} ($age anos)'
                        : 'Seleccionar',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().subtract(
                        const Duration(days: 365 * 25),
                      ),
                      firstDate: DateTime(1920),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      onBirthDateChanged(date);
                    }
                  },
                ),
                const Divider(),
                // Altura
                OnboardingSliderInput(
                  label: 'Altura',
                  value: height ?? 160,
                  min: 100,
                  max: 220,
                  unit: 'cm',
                  icon: Icons.height,
                  onChanged: onHeightChanged,
                ),
                const SizedBox(height: 16),
                // Peso
                OnboardingSliderInput(
                  label: 'Peso actual',
                  value: weight ?? 70,
                  min: 30,
                  max: 200,
                  unit: 'kg',
                  icon: Icons.monitor_weight,
                  onChanged: onWeightChanged,
                ),
                const SizedBox(height: 16),
                // Peso objetivo (opcional)
                OnboardingSliderInput(
                  label: 'Peso objetivo (opcional)',
                  value: targetWeight ?? weight ?? 70,
                  min: 30,
                  max: 200,
                  unit: 'kg',
                  icon: Icons.flag,
                  onChanged: onTargetWeightChanged,
                ),
              ],
            ),
          ),
          if (height != null && weight != null) ...[
            const SizedBox(height: 16),
            OnboardingBmiCard(heightCm: height!, weightKg: weight!),
          ],
        ],
      ),
    );
  }
}
