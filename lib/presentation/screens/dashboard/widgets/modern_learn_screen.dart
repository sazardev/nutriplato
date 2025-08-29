import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/presentation/screens/plate/widgets/example_hands_screen.dart';
import 'package:nutriplato/presentation/screens/plate/widgets/plato_info_screen.dart';
import 'package:nutriplato/presentation/screens/widgets/modern_cards.dart';
import 'package:provider/provider.dart';
import 'package:nutriplato/presentation/provider/theme_changer_provider.dart';
import 'package:nutriplato/config/theme/app_theme.dart';

class ModernLearnScreen extends StatelessWidget {
  const ModernLearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeChangerProvider>();
    final currentTheme = AppTheme.gradientThemes[themeProvider.selectedColor];

    return ListView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: [
        _buildModernLearnCard(
          context,
          'Plato del Bien Comer',
          'Conoce los grupos alimenticios',
          FontAwesomeIcons.utensils,
          currentTheme[0],
          () {
            Get.to(() => const PlatoInformationScreen());
          },
        ),
        _buildModernLearnCard(
          context,
          'Porciones con las Manos',
          'Aprende a medir tus porciones',
          FontAwesomeIcons.handPaper,
          Colors.orange.shade600,
          () {
            Get.to(() => const ExampleHandScreen());
          },
        ),
        _buildModernLearnCard(
          context,
          'Nutrición Balanceada',
          'Tips para una vida saludable',
          FontAwesomeIcons.heartPulse,
          Colors.red.shade500,
          () {
            // Navigate to nutrition tips
          },
        ),
        _buildModernLearnCard(
          context,
          'Ejercicio y Salud',
          'Mantente activo cada día',
          FontAwesomeIcons.dumbbell,
          Colors.purple.shade600,
          () {
            // Navigate to fitness tips
          },
        ),
      ],
    );
  }

  Widget _buildModernLearnCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      child: GradientCard(
        colors: [
          color,
          color.withValues(alpha: 0.8),
        ],
        onTap: onTap,
        child: SizedBox(
          height: 180, // Altura fija para evitar overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 6),
              Flexible(
                child: Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    'Explorar',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
