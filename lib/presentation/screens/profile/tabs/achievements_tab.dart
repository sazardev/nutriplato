import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/presentation/screens/profile/achievements.dart';

/// Pestaña de logros: estadísticas, racha y catálogo de logros.
class AchievementsTab extends StatelessWidget {
  final UserProfile profile;

  const AchievementsTab({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileSectionTitle(title: 'Estadísticas'),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              ProfileStatCard(
                title: 'Artículos leídos',
                value: profile.articlesRead.toString(),
                icon: Icons.menu_book,
                color: Colors.purple,
              ),
              ProfileStatCard(
                title: 'Ejercicios hechos',
                value: profile.exercisesCompleted.toString(),
                icon: Icons.fitness_center,
                color: Colors.orange,
              ),
              ProfileStatCard(
                title: 'Alimentos vistos',
                value: profile.foodsViewed.toString(),
                icon: Icons.restaurant,
                color: Colors.green,
              ),
              ProfileStatCard(
                title: 'Días registrados',
                value: profile.daysLogged.toString(),
                icon: Icons.calendar_today,
                color: Colors.blue,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const ProfileSectionTitle(title: 'Racha'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        color: Colors.orange,
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${profile.currentStreak}',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const Text('Racha actual'),
                    ],
                  ),
                  Container(width: 1, height: 80, color: Colors.grey.shade300),
                  Column(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: Colors.amber,
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${profile.longestStreak}',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                      const Text('Mejor racha'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          AchievementsGrid(
            currentStreak: profile.currentStreak,
            longestStreak: profile.longestStreak,
            daysLogged: profile.daysLogged,
            exercisesCompleted: profile.exercisesCompleted,
            articlesRead: profile.articlesRead,
            foodsViewed: profile.foodsViewed,
          ),
        ],
      ),
    );
  }
}

/// Tarjeta con una estadística del perfil.
class ProfileStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const ProfileStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

/// Título de sección usado dentro de las pestañas del perfil.
class ProfileSectionTitle extends StatelessWidget {
  final String title;

  const ProfileSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
