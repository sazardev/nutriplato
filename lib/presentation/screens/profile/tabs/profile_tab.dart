import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/presentation/screens/profile/tabs/achievements_tab.dart';
import 'package:nutriplato/presentation/screens/profile/widgets/profile_data_card.dart';

/// Pestaña con la información personal y corporal del usuario.
class ProfileTab extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback onViewProgress;
  final VoidCallback onEditProfile;
  final VoidCallback onShareBackup;
  final VoidCallback onCopyBackup;
  final VoidCallback onRestoreBackup;

  const ProfileTab({
    super.key,
    required this.profile,
    required this.onViewProgress,
    required this.onEditProfile,
    required this.onShareBackup,
    required this.onCopyBackup,
    required this.onRestoreBackup,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileSectionTitle(title: 'Información Personal'),
          ProfileInfoCard(
            children: [
              ProfileInfoRow(
                icon: Icons.person,
                label: 'Nombre',
                value: profile.username,
              ),
              ProfileInfoRow(
                icon: Icons.cake,
                label: 'Edad',
                value: profile.age != null
                    ? '${profile.age} años'
                    : 'No especificado',
              ),
              ProfileInfoRow(
                icon: Icons.wc,
                label: 'Género',
                value: profile.gender.label,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const ProfileSectionTitle(title: 'Medidas Corporales'),
          ProfileInfoCard(
            children: [
              ProfileInfoRow(
                icon: Icons.height,
                label: 'Altura',
                value: profile.heightCm != null
                    ? '${profile.heightCm!.toStringAsFixed(0)} cm'
                    : 'No especificado',
              ),
              ProfileInfoRow(
                icon: Icons.monitor_weight,
                label: 'Peso actual',
                value: profile.weightKg != null
                    ? '${profile.weightKg!.toStringAsFixed(1)} kg'
                    : 'No especificado',
              ),
              ProfileInfoRow(
                icon: Icons.flag,
                label: 'Peso objetivo',
                value: profile.targetWeightKg != null
                    ? '${profile.targetWeightKg!.toStringAsFixed(1)} kg'
                    : 'No especificado',
              ),
              if (profile.bmi != null)
                ProfileInfoRow(
                  icon: Icons.analytics,
                  label: 'IMC',
                  value:
                      '${profile.bmi!.toStringAsFixed(1)} (${profile.bmiCategory})',
                ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onViewProgress,
              icon: const Icon(Icons.trending_up),
              label: const Text('Ver mi progreso y gráficas'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const ProfileSectionTitle(title: 'Tus datos'),
          ProfileDataCard(
            onShare: onShareBackup,
            onCopy: onCopyBackup,
            onRestore: onRestoreBackup,
          ),
          const SizedBox(height: 24),
          const ProfileSectionTitle(title: 'Estilo de Vida'),
          ProfileInfoCard(
            children: [
              ProfileInfoRow(
                icon: Icons.directions_run,
                label: 'Actividad física',
                value: profile.activityLevel.label,
              ),
              ProfileInfoRow(
                icon: Icons.track_changes,
                label: 'Objetivo',
                value: profile.nutritionGoal.label,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton.icon(
              onPressed: onEditProfile,
              icon: const Icon(Icons.edit),
              label: const Text('Editar Perfil'),
            ),
          ),
        ],
      ),
    );
  }
}
