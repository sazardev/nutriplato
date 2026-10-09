import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';

/// Muestra el selector de condiciones de salud para agregar al perfil.
void showAddConditionDialog(
  BuildContext context,
  UserProfileProvider provider,
) {
  final conditions = MexicanHealthConditions.all;
  final existingIds = provider.healthConditions.map((c) => c.id).toSet();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Agregar Condición de Salud',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: conditions.length,
              itemBuilder: (context, index) {
                final condition = conditions[index];
                final exists = existingIds.contains(condition.id);

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: exists
                        ? Colors.grey.shade200
                        : Colors.red.shade100,
                    child: Icon(
                      Icons.medical_services,
                      color: exists ? Colors.grey : Colors.red,
                    ),
                  ),
                  title: Text(condition.name),
                  subtitle: Text(condition.type.label),
                  trailing: exists
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  enabled: !exists,
                  onTap: exists
                      ? null
                      : () {
                          provider.addHealthCondition(condition);
                          Navigator.pop(context);
                        },
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
