import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:nutriplato/fitness/fitness.controller.dart';
import 'package:nutriplato/fitness/fitness.data.dart';
import 'package:nutriplato/fitness/shared/fitness-popular.widget.dart';
import 'package:nutriplato/fitness/shared/simple-card.widget.dart';
import 'package:nutriplato/presentation/screens/screens.dart';
import 'package:nutriplato/config/theme/app_theme.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/presentation/provider/theme_changer_provider.dart';

class FitnessScreen extends StatelessWidget {
  const FitnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listedExercises = Get.find<FitnessController>().listedExercises;
    final themeProvider = context.watch<ThemeChangerProvider>();
    final currentTheme = AppTheme.gradientThemes[themeProvider.selectedColor];
    final primaryColor = AppTheme().colorThemes[themeProvider.selectedColor];

    return Scaffold(
      backgroundColor: NutriDesign.backgroundLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // AppBar con gradiente
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: currentTheme.first,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: currentTheme,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(NutriDesign.spacing20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                FontAwesomeIcons.dumbbell,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fitness',
                                    style: GoogleFonts.poppins(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${listedExercises.length} rutinas disponibles',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color:
                                          Colors.white.withValues(alpha: 0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Contenido
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(NutriDesign.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Sección de ejercicios populares
                  const PopularExercisesScreen(),

                  const SizedBox(height: NutriDesign.spacing24),

                  // Sección de categorías
                  Text(
                    'Categorías',
                    style: NutriDesign.heading4,
                  ),
                  const SizedBox(height: NutriDesign.spacing12),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: fitnessCategories.length,
                      itemBuilder: (context, index) {
                        final category = fitnessCategories[index];
                        return Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(NutriDesign.radiusLarge),
                            boxShadow: NutriDesign.softShadow,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: (category['color'] as Color)
                                      .withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  category['icon'] as IconData,
                                  color: category['color'] as Color,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category['name'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: NutriDesign.spacing24),

                  // Sección de rutinas para principiantes
                  Text(
                    'Para principiantes',
                    style: NutriDesign.heading4,
                  ),
                  const SizedBox(height: NutriDesign.spacing12),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listedExercises
                          .where((e) => e.difficulty == 'Facil')
                          .length,
                      itemBuilder: (context, index) {
                        final exercise = listedExercises
                            .where((e) => e.difficulty == 'Facil')
                            .toList()[index];
                        return SimpleCard(
                          title: exercise.name,
                          time: '${exercise.exercises.length ~/ 2} minutos',
                          icon: exercise.icon,
                          onTap: () => Get.to(
                            () => ExerciseViewScreen(selectedFitness: exercise),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: NutriDesign.spacing24),

                  // Sección de tips de fitness
                  Text(
                    'Tips de Entrenamiento',
                    style: NutriDesign.heading4,
                  ),
                  const SizedBox(height: NutriDesign.spacing12),
                  ...fitnessTips.take(4).map((tip) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(NutriDesign.radiusLarge),
                          boxShadow: NutriDesign.softShadow,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: primaryColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                tip['icon'] as IconData,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tip['title'] as String,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    tip['tip'] as String,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: NutriDesign.grey600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),

                  const SizedBox(height: 100), // Espacio para bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
