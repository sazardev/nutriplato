import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:nutriplato/config/theme/app_theme.dart';
import 'package:nutriplato/presentation/provider/theme_changer_provider.dart';
import 'package:nutriplato/presentation/provider/user_provider.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';
import 'package:nutriplato/presentation/screens/widgets/modern_cards.dart';
import 'package:nutriplato/presentation/screens/dashboard/widgets/modern_learn_screen.dart';
import 'package:nutriplato/presentation/screens/dashboard/widgets/nutrition_summary_card.dart';
import 'package:nutriplato/presentation/screens/dashboard/widgets/smart_suggestions_widget.dart';
import 'package:nutriplato/presentation/screens/featured_articles.dart';
import 'package:nutriplato/presentation/screens/widgets/modern_sidebar.dart';
import 'package:nutriplato/presentation/screens/profile/profile_screen.dart';

class ModernDashboardScreen extends StatefulWidget {
  const ModernDashboardScreen({super.key});

  @override
  State<ModernDashboardScreen> createState() => _ModernDashboardScreenState();
}

class _ModernDashboardScreenState extends State<ModernDashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final themeProvider = context.watch<ThemeChangerProvider>();
    final currentTheme = AppTheme.gradientThemes[themeProvider.selectedColor];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Modern App Bar
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.menu_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
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
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '¡Hola, ${user.username}!',
                                    style: GoogleFonts.poppins(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Bienvenido a tu journey nutricional',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Colors.white.withValues(alpha: 0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  icon: Consumer<UserProfileProvider>(
                    builder: (context, profileProvider, _) {
                      final profile = profileProvider.profile;
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: profile.username.isNotEmpty
                            ? Text(
                                profile.username[0].toUpperCase(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // Resumen nutricional personalizado
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NutritionSummaryCard(gradientColors: currentTheme),
                        const SizedBox(height: 12),
                        const HealthAlertsCard(),
                        const SizedBox(height: 12),
                        HydrationCard(accentColor: currentTheme[0]),
                        const SizedBox(height: 20),
                        // Sugerencias inteligentes
                        const SmartSuggestionsWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Estadisticas del usuario
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tu progreso',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Grid de estadísticas
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 1.3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          children: [
                            StatCard(
                              title: 'Artículos leídos',
                              value: '${user.postReadIt}',
                              icon: FontAwesomeIcons.bookOpen,
                              color: currentTheme[0],
                              progress:
                                  user.postReadIt / 50, // Ejemplo: meta de 50
                            ),
                            StatCard(
                              title: 'Ejercicios hechos',
                              value: '${user.exercisesDoIt}',
                              icon: FontAwesomeIcons.dumbbell,
                              color: Colors.orange.shade600,
                              progress: user.exercisesDoIt /
                                  30, // Ejemplo: meta de 30
                            ),
                            StatCard(
                              title: 'Alimentos vistos',
                              value: '${user.viewedFood}',
                              icon: FontAwesomeIcons.apple,
                              color: Colors.green.shade600,
                              progress:
                                  user.viewedFood / 100, // Ejemplo: meta de 100
                            ),
                            StatCard(
                              title: 'Nivel actual',
                              value: _calculateUserLevel(user).toString(),
                              icon: FontAwesomeIcons.trophy,
                              color: Colors.amber.shade600,
                              subtitle: 'Novato',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Sección de aprendizaje
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explora y aprende',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(
                        height: 200,
                        child: ModernLearnScreen(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Artículos destacados
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Artículos destacados',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to articles list
                            },
                            child: Text(
                              'Ver todos',
                              style: GoogleFonts.poppins(
                                color: currentTheme[0],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(
                        height: 250,
                        child: FeaturedArticlesWidget(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Padding inferior para el navigation bar
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      drawer: const ModernDrawerProfile(),
    );
  }

  int _calculateUserLevel(user) {
    // Algoritmo simple para calcular nivel basado en actividad
    int totalActivity = user.postReadIt + user.exercisesDoIt + user.viewedFood;
    return (totalActivity / 10).floor() + 1;
  }
}
