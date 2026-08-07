import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Definición de un logro desbloqueable.
class Achievement {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool Function(AchievementStats stats) isUnlocked;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.isUnlocked,
  });
}

/// Estadísticas necesarias para evaluar logros.
class AchievementStats {
  final int currentStreak;
  final int longestStreak;
  final int daysLogged;
  final int exercisesCompleted;
  final int articlesRead;
  final int foodsViewed;

  const AchievementStats({
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.daysLogged = 0,
    this.exercisesCompleted = 0,
    this.articlesRead = 0,
    this.foodsViewed = 0,
  });
}

/// Catálogo completo de logros.
List<Achievement> kAchievements = [
  // Racha
  Achievement(
    id: 'streak_3',
    title: 'Primeros pasos',
    description: 'Usa la app 3 días seguidos',
    icon: Icons.local_fire_department,
    color: Color(0xFFFF9800),
    isUnlocked: _stats((s) => s.longestStreak >= 3 || s.currentStreak >= 3),
  ),
  Achievement(
    id: 'streak_7',
    title: 'Semana completa',
    description: 'Mantén una racha de 7 días',
    icon: Icons.whatshot,
    color: Color(0xFFFF5722),
    isUnlocked: _stats((s) => s.longestStreak >= 7 || s.currentStreak >= 7),
  ),
  Achievement(
    id: 'streak_30',
    title: 'Un mes imparable',
    description: 'Mantén una racha de 30 días',
    icon: Icons.auto_awesome,
    color: Color(0xFFE64A19),
    isUnlocked: _stats((s) => s.longestStreak >= 30 || s.currentStreak >= 30),
  ),
  // Días registrados
  Achievement(
    id: 'days_7',
    title: 'Constancia',
    description: 'Registra 7 días de uso',
    icon: Icons.calendar_month,
    color: Color(0xFF2196F3),
    isUnlocked: _stats((s) => s.daysLogged >= 7),
  ),
  Achievement(
    id: 'days_30',
    title: 'Hábito formado',
    description: 'Registra 30 días de uso',
    icon: Icons.calendar_view_month,
    color: Color(0xFF1976D2),
    isUnlocked: _stats((s) => s.daysLogged >= 30),
  ),
  Achievement(
    id: 'days_100',
    title: 'Veterano',
    description: 'Registra 100 días de uso',
    icon: Icons.event_available,
    color: Color(0xFF0D47A1),
    isUnlocked: _stats((s) => s.daysLogged >= 100),
  ),
  // Ejercicios
  Achievement(
    id: 'exercise_10',
    title: 'En movimiento',
    description: 'Completa 10 ejercicios',
    icon: Icons.directions_run,
    color: Color(0xFF4CAF50),
    isUnlocked: _stats((s) => s.exercisesCompleted >= 10),
  ),
  Achievement(
    id: 'exercise_50',
    title: 'Atleta en formación',
    description: 'Completa 50 ejercicios',
    icon: Icons.fitness_center,
    color: Color(0xFF388E3C),
    isUnlocked: _stats((s) => s.exercisesCompleted >= 50),
  ),
  Achievement(
    id: 'exercise_500',
    title: 'Máquina',
    description: 'Completa 500 ejercicios',
    icon: Icons.military_tech,
    color: Color(0xFF1B5E20),
    isUnlocked: _stats((s) => s.exercisesCompleted >= 500),
  ),
  // Artículos
  Achievement(
    id: 'articles_10',
    title: 'Curioso',
    description: 'Lee 10 artículos',
    icon: Icons.menu_book,
    color: Color(0xFF9C27B0),
    isUnlocked: _stats((s) => s.articlesRead >= 10),
  ),
  Achievement(
    id: 'articles_50',
    title: 'Buscador de conocimiento',
    description: 'Lee 50 artículos',
    icon: Icons.auto_stories,
    color: Color(0xFF7B1FA2),
    isUnlocked: _stats((s) => s.articlesRead >= 50),
  ),
  // Alimentos
  Achievement(
    id: 'food_100',
    title: 'Explorador',
    description: 'Explora 100 alimentos',
    icon: Icons.restaurant,
    color: Color(0xFFEF6C00),
    isUnlocked: _stats((s) => s.foodsViewed >= 100),
  ),
  Achievement(
    id: 'food_500',
    title: 'Conocedor nutricional',
    description: 'Explora 500 alimentos',
    icon: Icons.ramen_dining,
    color: Color(0xFFE65100),
    isUnlocked: _stats((s) => s.foodsViewed >= 500),
  ),
];

typedef AchievementPredicate = bool Function(AchievementStats);

bool Function(AchievementStats) _stats(AchievementPredicate pred) => pred;

/// Cuadrícula de medallas ganadas y bloqueadas.
class AchievementsGrid extends StatelessWidget {
  final int currentStreak;
  final int longestStreak;
  final int daysLogged;
  final int exercisesCompleted;
  final int articlesRead;
  final int foodsViewed;

  const AchievementsGrid({
    super.key,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.daysLogged = 0,
    this.exercisesCompleted = 0,
    this.articlesRead = 0,
    this.foodsViewed = 0,
  });

  @override
  Widget build(BuildContext context) {
    final stats = AchievementStats(
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      daysLogged: daysLogged,
      exercisesCompleted: exercisesCompleted,
      articlesRead: articlesRead,
      foodsViewed: foodsViewed,
    );

    final unlockedCount = kAchievements
        .where((a) => a.isUnlocked(stats))
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Logros',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$unlockedCount/${kAchievements.length}',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.orange.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.82,
          children: kAchievements.map((a) {
            final unlocked = a.isUnlocked(stats);
            return _AchievementBadge(achievement: a, unlocked: unlocked);
          }).toList(),
        ),
      ],
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  final Achievement achievement;
  final bool unlocked;

  const _AchievementBadge({required this.achievement, required this.unlocked});

  @override
  Widget build(BuildContext context) {
    final color = unlocked ? achievement.color : Colors.grey.shade600;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: unlocked
            ? achievement.color.withValues(alpha: .1)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: unlocked
              ? achievement.color.withValues(alpha: .4)
              : Colors.grey.shade300,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            unlocked ? achievement.icon : Icons.lock_outline,
            color: color,
            size: 30,
          ),
          const SizedBox(height: 8),
          Text(
            achievement.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: unlocked ? Colors.black87 : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
