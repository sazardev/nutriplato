import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:nutriplato/config/theme/app_theme.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/fitness/smart/smart_exercise.model.dart';
import 'package:nutriplato/fitness/smart/smart_fitness.controller.dart';
import 'package:nutriplato/fitness/smart/exercise_svg_guide.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/presentation/provider/theme_changer_provider.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';

class SmartFitnessScreen extends StatelessWidget {
  const SmartFitnessScreen({super.key});

  SmartFitnessController get _ctrl => Get.find<SmartFitnessController>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeChangerProvider>();
    final profileProvider = context.watch<UserProfileProvider>();
    final primaryColor = AppTheme().colorThemes[themeProvider.selectedColor];
    final gradients = AppTheme.gradientThemes[themeProvider.selectedColor];

    // Sincronizar perfil con controller
    final profile = profileProvider.profile;
    if (profile.isProfileComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _ctrl.refreshWithProfile(profile);
      });
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: NutriDesign.backgroundLight,
        body: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            _buildSliverAppBar(context, gradients, primaryColor, profile),
            _buildStatsRow(context, primaryColor),
            _buildTabBar(context, primaryColor),
          ],
          body: TabBarView(
            children: [
              _RecommendationsTab(primaryColor: primaryColor),
              _ExerciseLibraryTab(primaryColor: primaryColor),
              _HistoryTab(primaryColor: primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context, List<Color> gradients,
      Color primaryColor, UserProfile profile) {
    final bmi = (profile.weightKg != null && profile.heightCm != null)
        ? profile.weightKg! /
            ((profile.heightCm! / 100) * (profile.heightCm! / 100))
        : null;
    final bmiLabel = bmi != null ? _ctrl.bmiCategory(bmi) : null;

    return SliverAppBar(
      expandedHeight: 170,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: gradients.first,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradients,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(FontAwesomeIcons.personRunning,
                            color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fitness Inteligente',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Ejercicios adaptados a tu perfil',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.85),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (bmi != null) ...[
                    Row(
                      children: [
                        _InfoChip(
                            label: 'IMC: ${bmi.toStringAsFixed(1)}',
                            icon: FontAwesomeIcons.weightScale),
                        const SizedBox(width: 8),
                        _InfoChip(
                            label: bmiLabel ?? '',
                            icon: FontAwesomeIcons.chartLine),
                        const SizedBox(width: 8),
                        _InfoChip(
                            label: profile.nutritionGoal.label,
                            icon: FontAwesomeIcons.bullseye),
                      ],
                    ),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.info_outline,
                              color: Colors.white, size: 13),
                          const SizedBox(width: 4),
                          Text(
                            'Completa tu perfil para recomendaciones personalizadas',
                            style: GoogleFonts.poppins(
                                fontSize: 10, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildStatsRow(BuildContext context, Color primaryColor) {
    return SliverToBoxAdapter(
      child: Obx(() {
        final ctrl = _ctrl;
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatCard(
                label: 'Hoy',
                value:
                    '${ctrl.todayCaloriesBurned.value.toStringAsFixed(0)} kcal',
                icon: FontAwesomeIcons.fire,
                color: const Color(0xFFFF6B6B),
              ),
              _StatDivider(),
              _StatCard(
                label: 'Esta semana',
                value: '${ctrl.weeklyWorkoutCount} entrenos',
                icon: FontAwesomeIcons.calendar,
                color: primaryColor,
              ),
              _StatDivider(),
              _StatCard(
                label: 'Semana kcal',
                value: '${ctrl.weeklyCaloriesBurned.toStringAsFixed(0)} kcal',
                icon: FontAwesomeIcons.chartBar,
                color: const Color(0xFF51CF66),
              ),
            ],
          ),
        );
      }),
    );
  }

  SliverPersistentHeader _buildTabBar(
      BuildContext context, Color primaryColor) {
    final tabBar = TabBar(
      labelColor: primaryColor,
      unselectedLabelColor: Colors.grey.shade500,
      indicatorColor: primaryColor,
      labelStyle:
          GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
      tabs: const [
        Tab(text: 'Recomendado'),
        Tab(text: 'Ejercicios'),
        Tab(text: 'Historial'),
      ],
    );
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TabBarDelegate(tabBar),
    );
  }
}

// ── Tab 1: Recomendaciones ────────────────────────────────────────────────────
class _RecommendationsTab extends StatefulWidget {
  final Color primaryColor;
  const _RecommendationsTab({required this.primaryColor});

  @override
  State<_RecommendationsTab> createState() => _RecommendationsTabState();
}

class _RecommendationsTabState extends State<_RecommendationsTab> {
  SmartFitnessController get _ctrl => Get.find<SmartFitnessController>();

  static const _energyEmojis = ['😴', '😐', '🙂', '💪', '🔥'];
  static const _energyLabels = [
    'Agotado',
    'Normal',
    'Bien',
    'Energizado',
    'Al máximo'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Barra de acciones ─────────────────────────────────────────────
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _onRandomTap,
                  icon: const Icon(Icons.shuffle_rounded, size: 16),
                  label: Text('Aleatorio',
                      style: GoogleFonts.poppins(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: widget.primaryColor,
                    side: BorderSide(color: widget.primaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _showCustomSheet(context),
                  icon: const Icon(Icons.tune_rounded, size: 16),
                  label: Text('Personalizar',
                      style: GoogleFonts.poppins(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
        // ── Selector de energía ───────────────────────────────────────────
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 2, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('¿Cómo te sientes ahora?',
                  style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: NutriDesign.grey600,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              Obx(() {
                final current = _ctrl.energyLevel.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (i) {
                    final level = i + 1;
                    final selected = current == level;
                    return GestureDetector(
                      onTap: () => _ctrl.updateEnergyLevel(level),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: selected
                              ? widget.primaryColor
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selected
                                ? widget.primaryColor
                                : Colors.transparent,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_energyEmojis[i],
                                style: const TextStyle(fontSize: 18)),
                            Text(_energyLabels[i],
                                style: GoogleFonts.poppins(
                                    fontSize: 9,
                                    color: selected
                                        ? Colors.white
                                        : NutriDesign.grey600,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.normal)),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }),
            ],
          ),
        ),
        const Divider(height: 1),
        // ── Lista de rutinas ──────────────────────────────────────────────
        Expanded(
          child: Obx(() {
            final workouts = _ctrl.recommendedWorkouts;
            if (workouts.isEmpty) {
              return _EmptyRecommendations(primaryColor: widget.primaryColor);
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: workouts.length,
              itemBuilder: (ctx, i) => _WorkoutCard(
                  workout: workouts[i], primaryColor: widget.primaryColor),
            );
          }),
        ),
      ],
    );
  }

  void _onRandomTap() {
    final workout = _ctrl.generateRandomWorkout();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WorkoutDetailSheet(
          workout: workout, primaryColor: widget.primaryColor),
    );
  }

  void _showCustomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CustomWorkoutSheet(primaryColor: widget.primaryColor),
    );
  }
}

// ── Tab 2: Biblioteca de ejercicios ──────────────────────────────────────────
class _ExerciseLibraryTab extends StatelessWidget {
  final Color primaryColor;
  const _ExerciseLibraryTab({required this.primaryColor});

  SmartFitnessController get _ctrl => Get.find<SmartFitnessController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chips de categoría
        Obx(() {
          final selected = _ctrl.selectedCategory.value;
          return SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _CategoryChip(
                  label: 'Todos',
                  isSelected: selected == null,
                  color: primaryColor,
                  onTap: () => _ctrl.selectedCategory.value = null,
                ),
                ...ExerciseCategory.values.map((cat) => _CategoryChip(
                      label: cat.label,
                      icon: cat.icon,
                      isSelected: selected == cat,
                      color: cat.color,
                      onTap: () => _ctrl.selectedCategory.value = cat,
                    )),
              ],
            ),
          );
        }),
        Expanded(
          child: Obx(() {
            final exercises = _ctrl.filteredExercises;
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: exercises.length,
              itemBuilder: (ctx, i) => _ExerciseCard(
                exercise: exercises[i],
                primaryColor: primaryColor,
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ── Tab 3: Historial ──────────────────────────────────────────────────────────
class _HistoryTab extends StatelessWidget {
  final Color primaryColor;
  const _HistoryTab({required this.primaryColor});

  SmartFitnessController get _ctrl => Get.find<SmartFitnessController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final history = _ctrl.workoutHistory;
      if (history.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.clockRotateLeft,
                  size: 48, color: Colors.grey.shade300),
              const SizedBox(height: 12),
              Text(
                'Sin historial aún',
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500),
              ),
              const SizedBox(height: 4),
              Text(
                'Completa un entrenamiento para verlo aquí',
                style: GoogleFonts.poppins(
                    fontSize: 12, color: Colors.grey.shade400),
              ),
            ],
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (ctx, i) {
          final entry = history[i];
          final date = entry.completedAt;
          final dateStr =
              '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(NutriDesign.radiusMedium),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(FontAwesomeIcons.fire,
                      size: 18, color: primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dateStr,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: NutriDesign.grey900,
                        ),
                      ),
                      Text(
                        '${entry.caloriesBurned.toStringAsFixed(0)} kcal · ${(entry.durationSeconds ~/ 60)} min',
                        style: GoogleFonts.poppins(
                            fontSize: 11, color: NutriDesign.grey600),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF51CF66).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Completado',
                    style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: const Color(0xFF51CF66),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

// ── Workout Card ──────────────────────────────────────────────────────────────
class _WorkoutCard extends StatelessWidget {
  final SmartWorkout workout;
  final Color primaryColor;

  const _WorkoutCard({required this.workout, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showWorkoutDetail(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(NutriDesign.radiusLarge),
          gradient: LinearGradient(
            colors: workout.gradients,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: workout.gradients.first.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      workout.name,
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      workout.overallIntensity.label,
                      style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              if (workout.reasoning.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  workout.reasoning,
                  style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.85)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  _WorkoutStat(
                      icon: FontAwesomeIcons.clock,
                      label: '${workout.totalDurationMinutes} min'),
                  const SizedBox(width: 16),
                  _WorkoutStat(
                      icon: FontAwesomeIcons.fire,
                      label:
                          '~${workout.estimatedCalories.toStringAsFixed(0)} kcal'),
                  const SizedBox(width: 16),
                  _WorkoutStat(
                      icon: FontAwesomeIcons.layerGroup,
                      label: '${workout.exercises.length} ejercicios'),
                ],
              ),
              const SizedBox(height: 12),
              // Preview de ejercicios
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: workout.exercises.take(3).map((e) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      e.name,
                      style: GoogleFonts.poppins(
                          fontSize: 10, color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: workout.gradients.first,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _showWorkoutDetail(context),
                  child: Text(
                    'Ver rutina completa',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWorkoutDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          _WorkoutDetailSheet(workout: workout, primaryColor: primaryColor),
    );
  }
}

// ── Detail Sheet ──────────────────────────────────────────────────────────────
class _WorkoutDetailSheet extends StatefulWidget {
  final SmartWorkout workout;
  final Color primaryColor;
  const _WorkoutDetailSheet(
      {required this.workout, required this.primaryColor});

  @override
  State<_WorkoutDetailSheet> createState() => _WorkoutDetailSheetState();
}

class _WorkoutDetailSheetState extends State<_WorkoutDetailSheet> {
  int _step = 0;
  bool _started = false;

  void _onComplete(BuildContext context) async {
    Navigator.pop(context);
    final mood = await showDialog<WorkoutMood>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => _MoodTrackerDialog(),
    );
    Get.find<SmartFitnessController>()
        .completeWorkout(widget.workout, 1200, mood: mood);
  }

  @override
  Widget build(BuildContext context) {
    final exercises = widget.workout.exercises;
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (ctx, scroll) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.workout.name,
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  if (!_started)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => setState(() => _started = true),
                      icon: const Icon(Icons.play_arrow, size: 16),
                      label: Text('Iniciar',
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                    )
                  else
                    TextButton(
                      onPressed: () => _onComplete(context),
                      child: Text(
                        'Completar',
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF51CF66),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                ],
              ),
            ),
            // Ejercicio actual o lista
            Expanded(
              child: _started
                  ? _ExerciseStepView(
                      exercises: exercises,
                      step: _step,
                      primaryColor: widget.primaryColor,
                      onNext: () {
                        if (_step < exercises.length - 1) {
                          setState(() => _step++);
                        }
                      },
                      onPrev: () {
                        if (_step > 0) setState(() => _step--);
                      },
                    )
                  : ListView.builder(
                      controller: scroll,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: exercises.length,
                      itemBuilder: (_, i) => _ExerciseListTile(
                        exercise: exercises[i],
                        index: i + 1,
                        primaryColor: widget.primaryColor,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Exercise step view (during workout) ──────────────────────────────────────
class _ExerciseStepView extends StatelessWidget {
  final List<SmartExercise> exercises;
  final int step;
  final Color primaryColor;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const _ExerciseStepView({
    required this.exercises,
    required this.step,
    required this.primaryColor,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    final exercise = exercises[step];
    final currentStep = exercise.steps.isNotEmpty ? exercise.steps.first : null;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Progress
          LinearProgressIndicator(
            value: (step + 1) / exercises.length,
            backgroundColor: Colors.grey.shade200,
            color: primaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 4),
          Text(
            '${step + 1} / ${exercises.length}',
            style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          // SVG Guide
          ExerciseSvgGuide(
            position: currentStep?.bodyPosition ?? BodyPosition.standing,
            activeMuscles: exercise.muscleGroups,
            primaryColor: primaryColor,
            size: 180,
          ),
          const SizedBox(height: 12),
          // Músculoss
          ActivatedMusclesLegend(
            muscles: exercise.muscleGroups,
            activeColor: primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            exercise.name,
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            exercise.description,
            style:
                GoogleFonts.poppins(fontSize: 12, color: NutriDesign.grey600),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          // Navegación
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                onPressed: step > 0 ? onPrev : null,
                icon: const Icon(Icons.chevron_left),
                label:
                    Text('Anterior', style: GoogleFonts.poppins(fontSize: 13)),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: step < exercises.length - 1 ? onNext : null,
                icon: const Icon(Icons.chevron_right),
                label: Text(
                    step < exercises.length - 1 ? 'Siguiente' : 'Terminar',
                    style: GoogleFonts.poppins(
                        fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Exercise Card (biblioteca) ─────────────────────────────────────────────────
class _ExerciseCard extends StatelessWidget {
  final SmartExercise exercise;
  final Color primaryColor;

  const _ExerciseCard({required this.exercise, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetail(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(NutriDesign.radiusMedium),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: exercise.category.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(exercise.category.icon,
                  color: exercise.category.color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: NutriDesign.grey900),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color:
                              exercise.intensity.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          exercise.intensity.label,
                          style: TextStyle(
                            fontSize: 9,
                            color: exercise.intensity.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '${exercise.baseQuantity} ${_metricLabel(exercise.metric)}',
                        style: GoogleFonts.poppins(
                            fontSize: 10, color: NutriDesign.grey600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }

  static String _metricLabel(ExerciseMetric m) {
    switch (m) {
      case ExerciseMetric.reps:
        return 'reps';
      case ExerciseMetric.seconds:
        return 'seg';
      case ExerciseMetric.distance:
        return 'm';
    }
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          _ExerciseDetailSheet(exercise: exercise, primaryColor: primaryColor),
    );
  }
}

// ── Exercise detail sheet ─────────────────────────────────────────────────────
class _ExerciseDetailSheet extends StatefulWidget {
  final SmartExercise exercise;
  final Color primaryColor;
  const _ExerciseDetailSheet(
      {required this.exercise, required this.primaryColor});

  @override
  State<_ExerciseDetailSheet> createState() => _ExerciseDetailSheetState();
}

class _ExerciseDetailSheetState extends State<_ExerciseDetailSheet> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final e = widget.exercise;
    final steps = e.steps;
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (ctx, scroll) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          controller: scroll,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: e.category.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(e.category.icon,
                        color: e.category.color, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.name,
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          e.category.label,
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: e.category.color),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // SVG Guide con selector de paso
              if (steps.isNotEmpty) ...[
                Center(
                  child: ExerciseSvgGuide(
                    position: steps[_currentStep].bodyPosition,
                    activeMuscles: e.muscleGroups,
                    primaryColor: widget.primaryColor,
                    size: 200,
                  ),
                ),
                const SizedBox(height: 8),
                // Chips de pasos
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: steps.length,
                    itemBuilder: (_, i) => GestureDetector(
                      onTap: () => setState(() => _currentStep = i),
                      child: Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _currentStep == i
                              ? widget.primaryColor
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Paso ${i + 1}${steps[i].isStartPosition ? " (inicio)" : ""}',
                          style: TextStyle(
                            fontSize: 11,
                            color: _currentStep == i
                                ? Colors.white
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  steps[_currentStep].instruction,
                  style: GoogleFonts.poppins(
                      fontSize: 13, color: NutriDesign.grey900),
                ),
                const SizedBox(height: 16),
              ],
              // Músculos
              ActivatedMusclesLegend(
                muscles: e.muscleGroups,
                activeColor: widget.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Descripción',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                e.description,
                style: GoogleFonts.poppins(
                    fontSize: 12, color: NutriDesign.grey600),
              ),
              if (e.tips.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Consejos',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                ...e.tips.map((t) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle_outline,
                              size: 14, color: widget.primaryColor),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              t,
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: NutriDesign.grey600),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
              if (e.contraindications.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Precauciones',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF6B6B)),
                ),
                const SizedBox(height: 8),
                ...e.contraindications.map((c) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.warning_amber_outlined,
                              size: 14, color: Color(0xFFFF6B6B)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              c,
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: NutriDesign.grey600),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExerciseListTile extends StatelessWidget {
  final SmartExercise exercise;
  final int index;
  final Color primaryColor;

  const _ExerciseListTile(
      {required this.exercise,
      required this.index,
      required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: NutriDesign.backgroundLight,
        borderRadius: BorderRadius.circular(NutriDesign.radiusMedium),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.w600),
                ),
                Text(
                  '${exercise.baseQuantity} ${exercise.metric == ExerciseMetric.reps ? "reps" : exercise.metric == ExerciseMetric.seconds ? "seg" : "m"}',
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: NutriDesign.grey600),
                ),
              ],
            ),
          ),
          Icon(exercise.category.icon,
              size: 16, color: exercise.category.color),
        ],
      ),
    );
  }
}

// ── Small widgets ─────────────────────────────────────────────────────────────
class _InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _InfoChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, size: 9, color: Colors.white),
          const SizedBox(width: 4),
          Text(label,
              style: GoogleFonts.poppins(fontSize: 10, color: Colors.white)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(icon, size: 16, color: color),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(
              fontSize: 13, fontWeight: FontWeight.w700, color: color),
        ),
        Text(label,
            style:
                GoogleFonts.poppins(fontSize: 10, color: NutriDesign.grey600)),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 36, color: Colors.grey.shade200);
}

class _WorkoutStat extends StatelessWidget {
  final IconData icon;
  final String label;
  const _WorkoutStat({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(icon, size: 11, color: Colors.white.withValues(alpha: 0.85)),
        const SizedBox(width: 4),
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 11, color: Colors.white.withValues(alpha: 0.9))),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isSelected ? color : Colors.grey.shade300, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 12, color: isSelected ? Colors.white : color),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isSelected ? Colors.white : NutriDesign.grey600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyRecommendations extends StatelessWidget {
  final Color primaryColor;
  const _EmptyRecommendations({required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.personRunning,
                size: 52, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Generando tu plan...',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Completa tu perfil (peso, talla, fecha de nacimiento) para recibir recomendaciones personalizadas.',
              style:
                  GoogleFonts.poppins(fontSize: 12, color: NutriDesign.grey600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Tab bar delegate ──────────────────────────────────────────────────────────
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  const _TabBarDelegate(this.tabBar);

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(color: Colors.white, child: tabBar);

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant _TabBarDelegate old) => old.tabBar != tabBar;
}

// ── Custom Workout Sheet ──────────────────────────────────────────────────────
class _CustomWorkoutSheet extends StatefulWidget {
  final Color primaryColor;
  const _CustomWorkoutSheet({required this.primaryColor});

  @override
  State<_CustomWorkoutSheet> createState() => _CustomWorkoutSheetState();
}

class _CustomWorkoutSheetState extends State<_CustomWorkoutSheet> {
  SmartFitnessController get _ctrl => Get.find<SmartFitnessController>();

  late int _duration;
  late int _count;
  late double _calories;

  @override
  void initState() {
    super.initState();
    _duration = _ctrl.customDuration.value;
    _count = _ctrl.customExerciseCount.value;
    _calories = _ctrl.customTargetCalories.value;
  }

  String get _durLabel => '$_duration min';
  String get _cntLabel => '$_count ejercicios';
  String get _calLabel => '${_calories.toStringAsFixed(0)} kcal';

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (ctx, scroll) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Personalizar rutina',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: ListView(
                controller: scroll,
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  _SliderRow(
                    icon: Icons.timer_outlined,
                    label: 'Duración',
                    value: _durLabel,
                    sliderValue: _duration.toDouble(),
                    min: 5,
                    max: 60,
                    divisions: 11,
                    color: widget.primaryColor,
                    onChanged: (v) => setState(() => _duration = v.toInt()),
                  ),
                  const SizedBox(height: 12),
                  _SliderRow(
                    icon: Icons.fitness_center,
                    label: 'Ejercicios',
                    value: _cntLabel,
                    sliderValue: _count.toDouble(),
                    min: 3,
                    max: 10,
                    divisions: 7,
                    color: widget.primaryColor,
                    onChanged: (v) => setState(() => _count = v.toInt()),
                  ),
                  const SizedBox(height: 12),
                  _SliderRow(
                    icon: Icons.local_fire_department_outlined,
                    label: 'Calorías objetivo',
                    value: _calLabel,
                    sliderValue: _calories,
                    min: 50,
                    max: 600,
                    divisions: 11,
                    color: const Color(0xFFFF6B6B),
                    onChanged: (v) =>
                        setState(() => _calories = (v ~/ 50 * 50).toDouble()),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: _generate,
                      child: Text(
                        'Generar rutina',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _generate() {
    _ctrl.customDuration.value = _duration;
    _ctrl.customExerciseCount.value = _count;
    _ctrl.customTargetCalories.value = _calories;
    final workout = _ctrl.generateCustomWorkout(
      durationMinutes: _duration,
      exerciseCount: _count,
      targetCalories: _calories,
    );
    Navigator.pop(context);
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WorkoutDetailSheet(
          workout: workout, primaryColor: widget.primaryColor),
    );
  }
}

// ── Slider row helper ─────────────────────────────────────────────────────────
class _SliderRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double sliderValue;
  final double min;
  final double max;
  final int divisions;
  final Color color;
  final ValueChanged<double> onChanged;

  const _SliderRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.sliderValue,
    required this.min,
    required this.max,
    required this.divisions,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 13, fontWeight: FontWeight.w600)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(value,
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: color, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: color,
            thumbColor: color,
            inactiveTrackColor: color.withValues(alpha: 0.2),
            overlayColor: color.withValues(alpha: 0.1),
            trackHeight: 3,
          ),
          child: Slider(
            value: sliderValue,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

// ── Mood Tracker Dialog ───────────────────────────────────────────────────────
class _MoodTrackerDialog extends StatefulWidget {
  const _MoodTrackerDialog();

  @override
  State<_MoodTrackerDialog> createState() => _MoodTrackerDialogState();
}

class _MoodTrackerDialogState extends State<_MoodTrackerDialog> {
  int _energia = 3;
  int _esfuerzo = 3;
  int _competencia = 3;
  int _variedad = 3;
  int _potencia = 3;

  static const _moodDefs = [
    {
      'label': 'Energía',
      'emojis': ['😴', '😐', '🙂', '💪', '🔥'],
    },
    {
      'label': 'Esfuerzo',
      'emojis': ['🥱', '😊', '😤', '💦', '🏆'],
    },
    {
      'label': 'Competencia',
      'emojis': ['😟', '😐', '🙂', '😎', '🏅'],
    },
    {
      'label': 'Variedad',
      'emojis': ['🥱', '🙂', '😊', '🤩', '⭐'],
    },
    {
      'label': 'Potencia',
      'emojis': ['🐌', '🚶', '🏃', '⚡', '🚀'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '¿Cómo fue tu entrenamiento?',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _MoodRow(
              label: _moodDefs[0]['label'] as String,
              emojis: _moodDefs[0]['emojis'] as List<String>,
              value: _energia,
              onChanged: (v) => setState(() => _energia = v),
            ),
            _MoodRow(
              label: _moodDefs[1]['label'] as String,
              emojis: _moodDefs[1]['emojis'] as List<String>,
              value: _esfuerzo,
              onChanged: (v) => setState(() => _esfuerzo = v),
            ),
            _MoodRow(
              label: _moodDefs[2]['label'] as String,
              emojis: _moodDefs[2]['emojis'] as List<String>,
              value: _competencia,
              onChanged: (v) => setState(() => _competencia = v),
            ),
            _MoodRow(
              label: _moodDefs[3]['label'] as String,
              emojis: _moodDefs[3]['emojis'] as List<String>,
              value: _variedad,
              onChanged: (v) => setState(() => _variedad = v),
            ),
            _MoodRow(
              label: _moodDefs[4]['label'] as String,
              emojis: _moodDefs[4]['emojis'] as List<String>,
              value: _potencia,
              onChanged: (v) => setState(() => _potencia = v),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF51CF66),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => Navigator.pop(
                  context,
                  WorkoutMood(
                    energia: _energia,
                    esfuerzo: _esfuerzo,
                    competencia: _competencia,
                    variedad: _variedad,
                    potencia: _potencia,
                  ),
                ),
                child: Text('Guardar',
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text('Omitir',
                  style: GoogleFonts.poppins(
                      fontSize: 13, color: Colors.grey.shade500)),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodRow extends StatelessWidget {
  final String label;
  final List<String> emojis;
  final int value; // 1-5
  final ValueChanged<int> onChanged;

  const _MoodRow({
    required this.label,
    required this.emojis,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 86,
            child: Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w600)),
          ),
          ...List.generate(5, (i) {
            final level = i + 1;
            final selected = value == level;
            return GestureDetector(
              onTap: () => onChanged(level),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.only(right: 4),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF51CF66).withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        selected ? const Color(0xFF51CF66) : Colors.transparent,
                  ),
                ),
                child: Text(emojis[i],
                    style: TextStyle(fontSize: selected ? 22 : 18)),
              ),
            );
          }),
        ],
      ),
    );
  }
}
