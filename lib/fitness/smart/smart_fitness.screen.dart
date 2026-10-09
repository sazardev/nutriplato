import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/config/theme/app_theme.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/fitness/smart/smart_fitness.controller.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/presentation/provider/theme_changer_provider.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';
import 'package:provider/provider.dart';

import 'tabs/exercise_library_tab.dart';
import 'tabs/history_tab.dart';
import 'tabs/recommendations_tab.dart';
import 'widgets/fitness_common.dart';

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
              RecommendationsTab(primaryColor: primaryColor),
              ExerciseLibraryTab(primaryColor: primaryColor),
              HistoryTab(primaryColor: primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(
    BuildContext context,
    List<Color> gradients,
    Color primaryColor,
    UserProfile profile,
  ) {
    final bmi = (profile.weightKg != null && profile.heightCm != null)
        ? profile.weightKg! /
              ((profile.heightCm! / 100) * (profile.heightCm! / 100))
        : null;
    final bmiLabel = bmi != null ? _ctrl.bmiCategory(bmi) : null;

    return SliverAppBar(
      expandedHeight: 170,
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
                        child: Icon(
                          FontAwesomeIcons.personRunning.data,
                          color: Colors.white,
                          size: 22,
                        ),
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
                        InfoChip(
                          label: 'IMC: ${bmi.toStringAsFixed(1)}',
                          icon: FontAwesomeIcons.weightScale.data,
                        ),
                        const SizedBox(width: 8),
                        InfoChip(
                          label: bmiLabel ?? '',
                          icon: FontAwesomeIcons.chartLine.data,
                        ),
                        const SizedBox(width: 8),
                        InfoChip(
                          label: profile.nutritionGoal.label,
                          icon: FontAwesomeIcons.bullseye.data,
                        ),
                      ],
                    ),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 13,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Completa tu perfil para recomendaciones personalizadas',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
              StatCard(
                label: 'Hoy',
                value:
                    '${ctrl.todayCaloriesBurned.value.toStringAsFixed(0)} kcal',
                icon: FontAwesomeIcons.fire.data,
                color: NutriDesign.error,
              ),
              const StatDivider(),
              StatCard(
                label: 'Esta semana',
                value: '${ctrl.weeklyWorkoutCount} entrenos',
                icon: FontAwesomeIcons.calendar.data,
                color: primaryColor,
              ),
              const StatDivider(),
              StatCard(
                label: 'Semana kcal',
                value: '${ctrl.weeklyCaloriesBurned.toStringAsFixed(0)} kcal',
                icon: FontAwesomeIcons.chartBar.data,
                color: NutriDesign.success,
              ),
            ],
          ),
        );
      }),
    );
  }

  SliverPersistentHeader _buildTabBar(
    BuildContext context,
    Color primaryColor,
  ) {
    final tabBar = TabBar(
      labelColor: primaryColor,
      unselectedLabelColor: Colors.grey.shade700,
      indicatorColor: primaryColor,
      labelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      tabs: const [
        Tab(text: 'Recomendado'),
        Tab(text: 'Ejercicios'),
        Tab(text: 'Historial'),
      ],
    );
    return SliverPersistentHeader(
      pinned: true,
      delegate: TabBarDelegate(tabBar),
    );
  }
}
