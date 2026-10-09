import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/presentation/screens/onboarding/widgets/onboarding_shared.dart';

/// Paso 6 del onboarding: condiciones medicas y alergias.
class HealthStep extends StatelessWidget {
  const HealthStep({
    super.key,
    required this.selectedConditions,
    required this.selectedAllergies,
    required this.commonAllergies,
    required this.onConditionToggled,
    required this.onAllergyToggled,
  });

  final Set<String> selectedConditions;
  final Set<String> selectedAllergies;
  final List<String> commonAllergies;
  final ValueChanged<String> onConditionToggled;
  final ValueChanged<String> onAllergyToggled;

  @override
  Widget build(BuildContext context) {
    final conditions = MexicanHealthConditions.all;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingPageHeader(
            icon: Icons.health_and_safety,
            title: 'Tu salud',
            subtitle: 'Tienes alguna condicion? (Opcional)',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ExcludeSemantics(
                  child: Icon(Icons.info_outline, color: Colors.green.shade900),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Esto nos ayuda a darte recomendaciones mas seguras',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Semantics(
            header: true,
            child: Text(
              'Condiciones medicas',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: conditions.map((condition) {
              final isSelected = selectedConditions.contains(condition.id);
              return FilterChip(
                label: Text(condition.name),
                selected: isSelected,
                onSelected: (_) => onConditionToggled(condition.id),
                selectedColor: Colors.green.shade900,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.green.shade900,
                ),
                checkmarkColor: Colors.white,
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Semantics(
            header: true,
            child: Text(
              'Alergias alimentarias',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: commonAllergies.map((allergy) {
              final isSelected = selectedAllergies.contains(allergy);
              return FilterChip(
                label: Text(allergy),
                selected: isSelected,
                onSelected: (_) => onAllergyToggled(allergy),
                selectedColor: Colors.red.shade800,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.red.shade800,
                ),
                checkmarkColor: Colors.white,
                avatar: isSelected
                    ? const Icon(Icons.warning, size: 16, color: Colors.white)
                    : null,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// Ajuste dietetico sugerido para una condicion medica.
String conditionAdjustment(HealthCondition c) {
  switch (c.id) {
    case 'diabetes_type_2':
      return 'Limita azúcares y carbohidratos de alto índice glucémico. '
          'Prefiere alimentos con IG bajo y fibra (nopal, avena, verduras).';
    case 'prediabetes':
      return 'Reduce azúcares simples y elige carbohidratos complejos.';
    case 'hipertension':
      return 'Reduce el sodio (máx 1500 mg/día) y evita embutidos y ultraprocesados.';
    case 'colesterol_alto':
      return 'Disminuye grasas saturadas y colesterol; prioriza grasas '
          'insaturadas (aguacate, nueces, aceite de oliva).';
    case 'obesidad':
      return 'Controla porciones y evita ultraprocesados y bebidas azucaradas.';
    case 'enfermedad_renal_cronica':
      return 'Ajusta proteína, potasio y fósforo según indicación médica.';
    case 'gastritis':
      return 'Evita irritantes: chile, café, cítricos, frituras y alcohol.';
    case 'celiaquia':
      return 'Sin gluten estricto: maíz, arroz, quinoa y amaranto como base.';
    case 'intolerancia_lactosa':
      return 'Evita lácteos con lactosa; usa versiones deslactosadas o vegetales.';
    case 'hipotiroidismo':
      return 'Asegura yodo (sal yodada) y limita soya y crucíferas crudas en exceso.';
    case 'anemia':
      return 'Combina hierro (lentejas, carne magra) con vitamina C (cítricos).';
    default:
      return 'Ajustes dietéticos personalizados para ${c.name}.';
  }
}
