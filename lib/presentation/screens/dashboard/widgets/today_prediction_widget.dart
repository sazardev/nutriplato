import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:nutriplato/fitness/smart/smart_fitness.controller.dart';
import 'package:nutriplato/fitness/smart/smart_fitness.screen.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_entry.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_provider.dart';
import 'package:nutriplato/infrastructure/services/daily_prediction_service.dart';
import 'package:nutriplato/presentation/provider/article_provider.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';
import 'package:nutriplato/presentation/screens/article_detail_screen.dart';

/// Predicción del día: qué comer, qué entrenar y qué leer hoy.
class TodayPredictionWidget extends StatefulWidget {
  const TodayPredictionWidget({super.key});

  @override
  State<TodayPredictionWidget> createState() => _TodayPredictionWidgetState();
}

class _TodayPredictionWidgetState extends State<TodayPredictionWidget> {
  bool _applied = false;

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<UserProfileProvider>();
    final foodLog = context.watch<FoodLogProvider>();
    final articleProvider = context.watch<ArticleProvider>();
    final fitnessCtrl = Get.find<SmartFitnessController>();

    final profile = profileProvider.profile;
    final prediction = DailyPredictionService.predict(
      userId: '${profile.id}|${profile.username}',
      date: DateTime.now(),
      profile: profile,
      conditions: profileProvider.healthConditions,
      recentFoodNames: _recentFoodNames(foodLog),
      recentExerciseIds: fitnessCtrl.workoutHistory
          .take(5)
          .expand((e) => e.exerciseIds)
          .toList(),
      articles: articleProvider.articles,
      energyLevel: fitnessCtrl.energyLevel.value,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(prediction),
          const SizedBox(height: 14),
          _buildEatSection(context, prediction),
          const SizedBox(height: 14),
          _buildWorkoutSection(context, prediction),
          const SizedBox(height: 14),
          _buildReadSection(context, prediction),
        ],
      ),
    );
  }

  Widget _buildHeader(DailyPrediction prediction) {
    final today = DateFormat('EEEE, d \'de\' MMMM').format(prediction.date);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.auto_awesome, color: Color(0xFF1B5E20), size: 20),
            const SizedBox(width: 8),
            Text(
              'Tu predicción de hoy',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          today[0].toUpperCase() + today.substring(1),
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 8),
        Text(
          prediction.motivation,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildEatSection(BuildContext context, DailyPrediction p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          'Qué comer hoy',
          Icons.restaurant,
          Colors.green.shade700,
        ),
        const SizedBox(height: 10),
        ...p.meals.map(
          (meal) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    meal.type,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade900,
                    ),
                  ),
                ),
                Expanded(
                  child: meal.foods.isEmpty
                      ? Text(
                          'Sin sugerencias',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        )
                      : Text(
                          meal.foods
                              .map(
                                (f) => '${f.name} (x${_portions(f.portions)})',
                              )
                              .join(' · '),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.grey.shade800,
                          ),
                        ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${meal.calories.round()} kcal',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _applied ? null : () => _applyMeals(p),
            icon: Icon(
              _applied ? Icons.check_circle : Icons.event_available,
              size: 16,
            ),
            label: Text(
              _applied
                  ? 'Comidas de hoy aplicadas'
                  : 'Aplicar comidas de hoy al registro',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.green.shade800,
              side: BorderSide(color: Colors.green.shade300),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutSection(BuildContext context, DailyPrediction p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          'Qué ejercicio hacer hoy',
          Icons.fitness_center,
          Colors.orange.shade700,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                p.workout.focus,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            _chip(
              '${p.workout.durationMinutes} min',
              Colors.orange.shade50,
              Colors.orange.shade900,
            ),
            const SizedBox(width: 6),
            _chip(
              '${p.workout.estimatedCalories} kcal',
              Colors.red.shade50,
              Colors.red.shade800,
            ),
            const SizedBox(width: 6),
            _chip(
              p.workout.intensityLabel,
              Colors.blue.shade50,
              Colors.blue.shade800,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: p.workout.exercises
              .map(
                (e) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    e,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 6),
        Text(
          p.workout.reason,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => Get.to(() => const SmartFitnessScreen()),
            icon: const Icon(Icons.play_circle, size: 16),
            label: Text(
              'Empezar esta rutina',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.orange.shade800,
              side: BorderSide(color: Colors.orange.shade300),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReadSection(BuildContext context, DailyPrediction p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          'Qué leer hoy',
          Icons.menu_book,
          Colors.indigo.shade600,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _chip(
                    p.read.articleTag,
                    Colors.indigo.shade100,
                    Colors.indigo.shade900,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                p.read.articleTitle,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                p.read.articleDescription,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '✨ ${p.read.factTitle}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.amber.shade900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                p.read.factText,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (p.read.article != null)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _openArticle(p.read.article!),
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: Text(
                'Leer artículo completo',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.indigo.shade700,
                side: BorderSide(color: Colors.indigo.shade300),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
      ],
    );
  }

  Widget _chip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }

  String _portions(double p) {
    final isWhole = p == p.roundToDouble();
    return isWhole ? p.toInt().toString() : p.toStringAsFixed(1);
  }

  List<String> _recentFoodNames(FoodLogProvider foodLog) {
    final cutoff = DateTime.now().subtract(const Duration(days: 2));
    final names = <String>[];
    for (final log in foodLog.logs) {
      if (log.date.isAfter(cutoff)) {
        names.addAll(log.entries.map((e) => e.food.name));
      }
    }
    return names;
  }

  Future<void> _applyMeals(DailyPrediction p) async {
    final foodLog = context.read<FoodLogProvider>();
    final now = DateTime.now();
    var added = 0;
    for (final meal in p.meals) {
      for (final food in meal.foods) {
        // Buscar el objeto Food original para conservar icono y nutrientes.
        final source = DailyPredictionService.sourceFood(food.name);
        if (source == null) continue;
        await foodLog.addFoodEntry(
          FoodLogEntry(
            food: source,
            quantity: food.portions,
            timestamp: now,
            mealType: meal.type,
          ),
        );
        added++;
      }
    }
    if (!mounted) return;
    setState(() => _applied = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          added > 0
              ? '$added alimentos de tu predicción agregados a tu día.'
              : 'No se pudieron aplicar los alimentos.',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color(0xFF1B5E20),
      ),
    );
  }

  void _openArticle(Article article) {
    final provider = context.read<ArticleProvider>();
    if (provider.articles.any(
      (a) => identical(a, article) || a.title == article.title,
    )) {
      provider.setSelectedArticle(article);
      Get.to(() => const ArticleDetailScreen());
    }
  }
}
