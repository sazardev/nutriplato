import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/presentation/provider/user_provider.dart';
import 'package:nutriplato/presentation/provider/theme_changer_provider.dart';
import 'package:nutriplato/presentation/screens/widgets/theme_changer_screen.dart';
import 'package:nutriplato/presentation/screens/meal_plan/meal_plan_screen.dart';
import 'package:nutriplato/presentation/screens/education/nutrition_education_screen.dart';
import 'package:nutriplato/presentation/screens/profile/profile_screen.dart';
import 'package:nutriplato/config/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../../../infrastructure/entities/user.dart';

class ModernDrawerProfile extends StatefulWidget {
  const ModernDrawerProfile({super.key});

  @override
  State<ModernDrawerProfile> createState() => _ModernDrawerProfileState();
}

class _ModernDrawerProfileState extends State<ModernDrawerProfile> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeChangerProvider>();
    final currentTheme = AppTheme.gradientThemes[themeProvider.selectedColor];

    return Drawer(
      backgroundColor: Colors.grey.shade50,
      child: Column(
        children: [
          // Header moderno con gradiente
          const ModernUserCard(),

          // Opciones del menú
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 8),
                _buildMenuSection(
                  context,
                  'Nutrición Inteligente',
                  [
                    _buildMenuItem(
                      context,
                      'Plan Alimenticio',
                      FontAwesomeIcons.bowlFood,
                      Colors.green.shade600,
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MealPlanScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      'Aprende Nutrición',
                      FontAwesomeIcons.graduationCap,
                      Colors.purple.shade600,
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NutritionEducationScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      'Mi Perfil de Salud',
                      FontAwesomeIcons.heartPulse,
                      Colors.red.shade600,
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfileScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                _buildMenuSection(
                  context,
                  'Personalización',
                  [
                    _buildMenuItem(
                      context,
                      'Cambiar tema',
                      FontAwesomeIcons.palette,
                      currentTheme[0],
                      () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ThemeChangerScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      'Configuración',
                      FontAwesomeIcons.gear,
                      Colors.grey.shade600,
                      () {
                        // TODO: Implementar configuración
                      },
                    ),
                  ],
                ),
                _buildMenuSection(
                  context,
                  'Información',
                  [
                    _buildMenuItem(
                      context,
                      'Acerca de',
                      FontAwesomeIcons.circleInfo,
                      Colors.blue.shade600,
                      () {
                        Navigator.pop(context);
                        showAboutDialog(
                          context: context,
                          applicationName: 'NutriPlato',
                          applicationVersion: '3.0.0',
                          applicationLegalese:
                              'Creado con ❤️ para una mejor nutrición',
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      'Términos y Condiciones',
                      FontAwesomeIcons.fileContract,
                      Colors.purple.shade600,
                      () {
                        if (Platform.isAndroid) {
                          const url =
                              'https://github.com/CerberusProgrammer/nutriplato/blob/master/Pol%C3%ADtica%20de%20Privacidad%20-%20NutriPlato.pdf';
                          const intent = AndroidIntent(
                            action: 'action_view',
                            data: url,
                          );
                          intent.launch();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.red.shade400,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Hecho con amor para ti',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(
      BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...items,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FaIcon(
                    icon,
                    size: 16,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ModernUserCard extends StatefulWidget {
  const ModernUserCard({super.key});

  @override
  State<ModernUserCard> createState() => _ModernUserCardState();
}

class _ModernUserCardState extends State<ModernUserCard> {
  bool editMode = false;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<UserProvider>().user;
    final themeProvider = context.watch<ThemeChangerProvider>();
    final currentTheme = AppTheme.gradientThemes[themeProvider.selectedColor];

    _nameController.text = user.username;

    return Container(
      constraints: const BoxConstraints(maxHeight: 260),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: currentTheme,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header con botones
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (editMode) {
                          // Guardar cambios
                          user.username = _nameController.text;
                          context.read<UserProvider>().saveUser(user);
                          editMode = false;
                        } else {
                          editMode = true;
                        }
                      });
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        editMode ? Icons.check : Icons.edit,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Avatar y nombre
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        user.username.isNotEmpty
                            ? user.username[0].toUpperCase()
                            : 'U',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        editMode
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextField(
                                  controller: _nameController,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Tu nombre',
                                    hintStyle: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              )
                            : Text(
                                user.username.isEmpty
                                    ? 'Usuario'
                                    : user.username,
                                style: GoogleFonts.poppins(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                        const SizedBox(height: 2),
                        Text(
                          'Miembro desde ${DateTime.now().year}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Estadísticas
              Row(
                children: [
                  Expanded(
                      child: _buildStat('${user.postReadIt}', 'Artículos')),
                  Container(
                    width: 1,
                    height: 25,
                    color: Colors.white.withValues(alpha: 0.3),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  Expanded(
                      child: _buildStat('${user.exercisesDoIt}', 'Ejercicios')),
                  Container(
                    width: 1,
                    height: 25,
                    color: Colors.white.withValues(alpha: 0.3),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  Expanded(
                      child: _buildStat('${user.viewedFood}', 'Alimentos')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: Colors.white.withValues(alpha: 0.8),
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
