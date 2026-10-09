import 'package:flutter/material.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/presentation/screens/onboarding/widgets/onboarding_shared.dart';

/// Paso 2 del onboarding: nombre y genero del usuario.
class NameStep extends StatelessWidget {
  const NameStep({
    super.key,
    required this.name,
    required this.onNameChanged,
    required this.gender,
    required this.onGenderChanged,
  });

  final String name;
  final ValueChanged<String> onNameChanged;
  final Gender gender;
  final ValueChanged<Gender> onGenderChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingPageHeader(
            icon: Icons.person_outline,
            title: 'Como te llamas?',
            subtitle: 'Personalizaremos tu experiencia',
          ),
          const SizedBox(height: 40),
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
                TextField(
                  onChanged: onNameChanged,
                  style: NutriDesign.font(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Tu nombre',
                    hintText: 'Ej: Maria',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.green.shade600,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.green.shade600,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Selecciona tu genero',
                  style: NutriDesign.font(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: Gender.values.map((option) {
                    final isSelected = gender == option;
                    return Expanded(
                      child: Semantics(
                        button: true,
                        selected: isSelected,
                        child: GestureDetector(
                          onTap: () => onGenderChanged(option),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.green.shade100
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.green.shade600
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  option == Gender.male
                                      ? Icons.male
                                      : option == Gender.female
                                      ? Icons.female
                                      : Icons.person,
                                  color: isSelected
                                      ? Colors.green.shade600
                                      : Colors.grey,
                                  size: 28,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  option.label,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.green.shade700
                                        : Colors.grey.shade600,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
