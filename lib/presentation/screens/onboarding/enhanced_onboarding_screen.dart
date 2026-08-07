import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_entry.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_provider.dart';
import 'package:nutriplato/infrastructure/services/nutrition_calculator_service.dart';
import 'package:nutriplato/infrastructure/services/smart_nutrition_service.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';
import 'package:nutriplato/presentation/home.screen.dart';

/// Pantalla de onboarding mejorada con animaciones fluidas
class EnhancedOnboardingScreen extends StatefulWidget {
  const EnhancedOnboardingScreen({super.key});

  @override
  State<EnhancedOnboardingScreen> createState() =>
      _EnhancedOnboardingScreenState();
}

class _EnhancedOnboardingScreenState extends State<EnhancedOnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 7;

  // Animaciones
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Datos del formulario
  String _name = '';
  DateTime? _birthDate;
  Gender _gender = Gender.other;
  double? _height;
  double? _weight;
  double? _targetWeight;
  ActivityLevel _activityLevel = ActivityLevel.sedentary;
  NutritionGoal _goal = NutritionGoal.maintainWeight;
  final Set<String> _selectedConditions = {};
  final Set<String> _selectedAllergies = {};
  bool _planApplied = false;
  _PlanProposal? _cachedProposal;

  final List<String> _commonAllergies = [
    'Cacahuate',
    'Nueces',
    'Leche',
    'Huevo',
    'Trigo',
    'Soya',
    'Mariscos',
    'Pescado',
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _animateToNextPage() {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    void goToNext() {
      if (_currentPage < _totalPages - 1) {
        if (reduceMotion) {
          _pageController.jumpToPage(_currentPage + 1);
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      } else {
        _completeOnboarding();
      }
    }

    if (reduceMotion) {
      goToNext();
      return;
    }
    _fadeController.reverse().then((_) {
      goToNext();
      _fadeController.forward();
    });
  }

  void _animateToPreviousPage() {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    void goToPrevious() {
      if (_currentPage > 0) {
        if (reduceMotion) {
          _pageController.jumpToPage(_currentPage - 1);
        } else {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      }
    }

    if (reduceMotion) {
      goToPrevious();
      return;
    }
    _fadeController.reverse().then((_) {
      goToPrevious();
      _fadeController.forward();
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
      // Si el usuario vuelve a editar datos, el plan se recalcula al regresar.
      if (index != _totalPages - 1) {
        _cachedProposal = null;
      }
    });
  }

  bool _canProceed() {
    switch (_currentPage) {
      case 0:
        return true; // Bienvenida
      case 1:
        return _name.trim().length >= 2;
      case 2:
        return _birthDate != null && _height != null && _weight != null;
      case 3:
        return true; // Actividad
      case 4:
        return true; // Objetivo
      case 5:
        return true; // Condiciones
      case 6:
        return true; // Plan
      default:
        return true;
    }
  }

  Future<void> _completeOnboarding() async {
    final provider = context.read<UserProfileProvider>();

    await provider.updateProfileFields(
      username: _name,
      birthDate: _birthDate,
      gender: _gender,
      heightCm: _height,
      weightKg: _weight,
      targetWeightKg: _targetWeight,
      activityLevel: _activityLevel,
      nutritionGoal: _goal,
      allergies: _selectedAllergies.toList(),
      onboardingCompleted: true,
    );

    for (final conditionId in _selectedConditions) {
      await provider.addPredefinedCondition(conditionId);
    }

    // Marcar presentacion como completada
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('presentation', false);

    if (mounted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade600,
              Colors.green.shade700,
              Colors.green.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Indicador de progreso
              _buildProgressIndicator(),

              // Contenido
              Expanded(
                child: MediaQuery.disableAnimationsOf(context)
                    ? PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          _onPageChanged(index);
                        },
                        children: [
                          _buildWelcomePage(),
                          _buildNamePage(),
                          _buildBodyDataPage(),
                          _buildActivityPage(),
                          _buildGoalPage(),
                          _buildHealthPage(),
                          _buildPlanProposalPage(),
                        ],
                      )
                    : FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (index) {
                              _onPageChanged(index);
                            },
                            children: [
                              _buildWelcomePage(),
                              _buildNamePage(),
                              _buildBodyDataPage(),
                              _buildActivityPage(),
                              _buildGoalPage(),
                              _buildHealthPage(),
                              _buildPlanProposalPage(),
                            ],
                          ),
                        ),
                      ),
              ),

              // Botones de navegacion
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: List.generate(_totalPages, (index) {
          final isActive = index <= _currentPage;
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          if (_currentPage > 0)
            TextButton.icon(
              onPressed: _animateToPreviousPage,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text('Atras', style: TextStyle(color: Colors.white)),
            ),
          const Spacer(),
          ElevatedButton(
            onPressed: _canProceed() ? _animateToNextPage : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green.shade700,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _currentPage == _totalPages - 1 ? 'Comenzar' : 'Siguiente',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  _currentPage == _totalPages - 1
                      ? Icons.check
                      : Icons.arrow_forward,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============== PAGINAS ==============

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo animado
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: MediaQuery.disableAnimationsOf(context)
                ? Duration.zero
                : const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ExcludeSemantics(
                    child: Icon(
                      Icons.restaurant_menu,
                      size: 70,
                      color: Colors.green.shade600,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          Text(
            'Bienvenido a',
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
          ),
          Text(
            'NutriPlato',
            style: GoogleFonts.poppins(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _buildFeatureItem(
                  Icons.restaurant,
                  'Nutricion personalizada',
                  'Planes basados en tus necesidades',
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  Icons.health_and_safety,
                  'Cuida tu salud',
                  'Alertas para condiciones medicas',
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  Icons.insights,
                  'Aprende cada dia',
                  'Datos curiosos y consejos',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExcludeSemantics(
            child: Icon(icon, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.92),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNamePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(
            icon: Icons.person_outline,
            title: 'Como te llamas?',
            subtitle: 'Personalizaremos tu experiencia',
          ),
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => setState(() => _name = value),
                  style: GoogleFonts.poppins(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Tu nombre',
                    hintText: 'Ej: Maria',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.green.shade600,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.green.shade600,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Selecciona tu genero',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: Gender.values.map((gender) {
                    final isSelected = _gender == gender;
                    return Expanded(
                      child: Semantics(
                        button: true,
                        selected: isSelected,
                        child: GestureDetector(
                          onTap: () => setState(() => _gender = gender),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.green.shade100
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.green.shade600
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  gender == Gender.male
                                      ? Icons.male
                                      : gender == Gender.female
                                      ? Icons.female
                                      : Icons.person,
                                  color: isSelected
                                      ? Colors.green.shade600
                                      : Colors.grey,
                                  size: 28,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  gender.label,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.green.shade700
                                        : Colors.grey.shade600,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyDataPage() {
    final age = _birthDate != null
        ? DateTime.now().difference(_birthDate!).inDays ~/ 365
        : 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(
            icon: Icons.straighten,
            title: 'Tus medidas',
            subtitle: 'Para calcular tus necesidades',
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Fecha de nacimiento
                ListTile(
                  leading: Icon(Icons.cake, color: Colors.green.shade600),
                  title: const Text('Fecha de nacimiento'),
                  subtitle: Text(
                    _birthDate != null
                        ? '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year} ($age anos)'
                        : 'Seleccionar',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().subtract(
                        const Duration(days: 365 * 25),
                      ),
                      firstDate: DateTime(1920),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() => _birthDate = date);
                    }
                  },
                ),
                const Divider(),
                // Altura
                _buildSliderInput(
                  label: 'Altura',
                  value: _height ?? 160,
                  min: 100,
                  max: 220,
                  unit: 'cm',
                  icon: Icons.height,
                  onChanged: (v) => setState(() => _height = v),
                ),
                const SizedBox(height: 16),
                // Peso
                _buildSliderInput(
                  label: 'Peso actual',
                  value: _weight ?? 70,
                  min: 30,
                  max: 200,
                  unit: 'kg',
                  icon: Icons.monitor_weight,
                  onChanged: (v) => setState(() => _weight = v),
                ),
                const SizedBox(height: 16),
                // Peso objetivo (opcional)
                _buildSliderInput(
                  label: 'Peso objetivo (opcional)',
                  value: _targetWeight ?? _weight ?? 70,
                  min: 30,
                  max: 200,
                  unit: 'kg',
                  icon: Icons.flag,
                  onChanged: (v) => setState(() => _targetWeight = v),
                ),
              ],
            ),
          ),
          if (_height != null && _weight != null) ...[
            const SizedBox(height: 16),
            _buildBMICard(),
          ],
        ],
      ),
    );
  }

  Widget _buildSliderInput({
    required String label,
    required double value,
    required double min,
    required double max,
    required String unit,
    required IconData icon,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.green.shade600, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${value.round()} $unit',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.green.shade400,
            inactiveTrackColor: Colors.green.shade100,
            thumbColor: Colors.green.shade600,
            overlayColor: Colors.green.withOpacity(0.2),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            label: label,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildBMICard() {
    final bmi = _weight! / ((_height! / 100) * (_height! / 100));
    String category;
    Color color;

    if (bmi < 18.5) {
      category = 'Bajo peso';
      color = Colors.blue;
    } else if (bmi < 25) {
      category = 'Peso normal';
      color = Colors.green;
    } else if (bmi < 30) {
      category = 'Sobrepeso';
      color = Colors.orange;
    } else {
      category = 'Obesidad';
      color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                bmi.toStringAsFixed(1),
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tu IMC', style: TextStyle(color: color.withOpacity(0.8))),
              Text(
                category,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(
            icon: Icons.directions_run,
            title: 'Tu actividad fisica',
            subtitle: 'Que tan activo eres en el dia a dia?',
          ),
          const SizedBox(height: 24),
          ...ActivityLevel.values.map((level) {
            final isSelected = _activityLevel == level;
            return Semantics(
              button: true,
              selected: isSelected,
              child: GestureDetector(
                onTap: () => setState(() => _activityLevel = level),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? Colors.green.shade600
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.green.shade100
                              : Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getActivityIcon(level),
                          color: isSelected
                              ? Colors.green.shade600
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              level.label,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: isSelected
                                    ? Colors.green.shade700
                                    : Colors.black87,
                              ),
                            ),
                            Text(
                              level.description,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check_circle, color: Colors.green.shade600),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getActivityIcon(ActivityLevel level) {
    switch (level) {
      case ActivityLevel.sedentary:
        return Icons.weekend;
      case ActivityLevel.lightlyActive:
        return Icons.directions_walk;
      case ActivityLevel.moderatelyActive:
        return Icons.directions_run;
      case ActivityLevel.veryActive:
        return Icons.fitness_center;
      case ActivityLevel.extraActive:
        return Icons.sports_martial_arts;
    }
  }

  Widget _buildGoalPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(
            icon: Icons.flag,
            title: 'Tu objetivo',
            subtitle: 'Que quieres lograr?',
          ),
          const SizedBox(height: 24),
          ...NutritionGoal.values.map((goal) {
            final isSelected = _goal == goal;
            return Semantics(
              button: true,
              selected: isSelected,
              child: GestureDetector(
                onTap: () => setState(() => _goal = goal),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? Colors.green.shade600
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.green.shade100
                              : Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getGoalIcon(goal),
                          color: isSelected
                              ? Colors.green.shade600
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              goal.label,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: isSelected
                                    ? Colors.green.shade700
                                    : Colors.black87,
                              ),
                            ),
                            Text(
                              goal.description,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check_circle, color: Colors.green.shade600),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getGoalIcon(NutritionGoal goal) {
    switch (goal) {
      case NutritionGoal.loseWeight:
        return Icons.trending_down;
      case NutritionGoal.loseWeightFast:
        return Icons.speed;
      case NutritionGoal.maintainWeight:
        return Icons.balance;
      case NutritionGoal.gainMuscle:
        return Icons.fitness_center;
      case NutritionGoal.gainWeight:
        return Icons.trending_up;
    }
  }

  Widget _buildHealthPage() {
    final conditions = MexicanHealthConditions.all;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(
            icon: Icons.health_and_safety,
            title: 'Tu salud',
            subtitle: 'Tienes alguna condicion? (Opcional)',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ExcludeSemantics(
                  child: Icon(Icons.info_outline, color: Colors.green.shade900),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Esto nos ayuda a darte recomendaciones mas seguras',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Semantics(
            header: true,
            child: Text(
              'Condiciones medicas',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: conditions.map((condition) {
              final isSelected = _selectedConditions.contains(condition.id);
              return FilterChip(
                label: Text(condition.name),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedConditions.add(condition.id);
                    } else {
                      _selectedConditions.remove(condition.id);
                    }
                  });
                },
                selectedColor: Colors.green.shade900,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.green.shade900,
                ),
                checkmarkColor: Colors.white,
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Semantics(
            header: true,
            child: Text(
              'Alergias alimentarias',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _commonAllergies.map((allergy) {
              final isSelected = _selectedAllergies.contains(allergy);
              return FilterChip(
                label: Text(allergy),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedAllergies.add(allergy);
                    } else {
                      _selectedAllergies.remove(allergy);
                    }
                  });
                },
                selectedColor: Colors.red.shade800,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.red.shade800,
                ),
                checkmarkColor: Colors.white,
                avatar: isSelected
                    ? Icon(Icons.warning, size: 16, color: Colors.white)
                    : null,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ============== PLAN PERSONALIZADO ==============

  /// Calcula la propuesta de plan usando el algoritmo real de NutriPlato.
  _PlanProposal _computePlanProposal() {
    final weight = _weight ?? 70;
    final height = _height ?? 165;
    final age = _birthDate != null
        ? DateTime.now().difference(_birthDate!).inDays ~/ 365
        : 25;

    final bmr = NutritionCalculatorService.calculateBMR(
      weightKg: weight,
      heightCm: height,
      age: age,
      gender: _gender,
    );
    final tdee = NutritionCalculatorService.calculateTDEE(
      bmr: bmr,
      activityLevel: _activityLevel,
    );
    final targetCalories = NutritionCalculatorService.calculateTargetCalories(
      tdee: tdee,
      goal: _goal,
    );
    final macros = NutritionCalculatorService.calculateMacros(
      targetCalories: targetCalories,
      goal: _goal,
      weightKg: weight,
      healthConditions: _selectedConditions.toList(),
    );
    final idealWeight = NutritionCalculatorService.calculateIdealWeight(
      heightCm: height,
      gender: _gender,
    );

    final heightM = height / 100;
    final bmi = weight / (heightM * heightM);
    final bmiCategory = bmi < 18.5
        ? 'Bajo peso'
        : bmi < 25
        ? 'Peso normal'
        : bmi < 30
        ? 'Sobrepeso'
        : 'Obesidad';

    final water = NutritionCalculatorService.calculateWaterRequirement(
      weightKg: weight,
      activityLevel: _activityLevel,
    );

    WeightGoalProjection? projection;
    if (_goal != NutritionGoal.maintainWeight) {
      projection = NutritionCalculatorService.calculateWeightGoalProjection(
        currentWeight: weight,
        targetWeight: _targetWeight ?? idealWeight.average,
        dailyCalorieDeficit: _goal.calorieAdjustment.toDouble(),
      );
    }

    final conditions = _selectedConditions
        .map((id) => MexicanHealthConditions.getById(id))
        .whereType<HealthCondition>()
        .toList();

    final nutrientLimits = <String, double>{};
    for (final c in conditions) {
      nutrientLimits.addAll(c.nutrientLimits);
    }

    final profile = UserProfile(
      id: 'onboarding',
      username: _name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      birthDate: _birthDate,
      gender: _gender,
      heightCm: _height,
      weightKg: _weight,
      targetWeightKg: _targetWeight,
      activityLevel: _activityLevel,
      nutritionGoal: _goal,
      allergies: _selectedAllergies.toList(),
      healthConditionIds: _selectedConditions.toList(),
    );

    final mealPlan = SmartNutritionService.generateMealPlan(
      profile: profile,
      conditions: conditions,
      targetCalories: targetCalories,
    );

    return _PlanProposal(
      bmr: bmr,
      tdee: tdee,
      targetCalories: targetCalories,
      macros: macros,
      idealWeight: idealWeight,
      bmi: bmi,
      bmiCategory: bmiCategory,
      water: water,
      projection: projection,
      conditionNames: conditions.map((c) => c.name).toList(),
      adjustments: conditions.map(_conditionAdjustment).toList(),
      nutrientLimits: nutrientLimits,
      mealPlan: mealPlan,
      recommendedFoods: SmartNutritionService.getRecommendedFoods(
        profile: profile,
        conditions: conditions,
        limit: 8,
      ),
      avoidFoods: SmartNutritionService.getFoodsToAvoid(
        profile: profile,
        conditions: conditions,
        limit: 6,
      ),
      mealDistribution: {
        'Desayuno': targetCalories * 0.25,
        'Comida': targetCalories * 0.35,
        'Cena': targetCalories * 0.25,
        'Snacks': targetCalories * 0.15,
      },
    );
  }

  String _conditionAdjustment(HealthCondition c) {
    switch (c.id) {
      case 'diabetes_type_2':
        return 'Limita azúcares y carbohidratos de alto índice glucémico. '
            'Prefiere alimentos con IG bajo y fibra (nopal, avena, verduras).';
      case 'prediabetes':
        return 'Reduce azúcares simples y elige carbohidratos complejos.';
      case 'hipertension':
        return 'Reduce el sodio (máx 1500 mg/día) y evita embutidos y ultraprocesados.';
      case 'colesterol_alto':
        return 'Disminuye grasas saturadas y colesterol; prioriza grasas '
            'insaturadas (aguacate, nueces, aceite de oliva).';
      case 'obesidad':
        return 'Controla porciones y evita ultraprocesados y bebidas azucaradas.';
      case 'enfermedad_renal_cronica':
        return 'Ajusta proteína, potasio y fósforo según indicación médica.';
      case 'gastritis':
        return 'Evita irritantes: chile, café, cítricos, frituras y alcohol.';
      case 'celiaquia':
        return 'Sin gluten estricto: maíz, arroz, quinoa y amaranto como base.';
      case 'intolerancia_lactosa':
        return 'Evita lácteos con lactosa; usa versiones deslactosadas o vegetales.';
      case 'hipotiroidismo':
        return 'Asegura yodo (sal yodada) y limita soya y crucíferas crudas en exceso.';
      case 'anemia':
        return 'Combina hierro (lentejas, carne magra) con vitamina C (cítricos).';
      default:
        return 'Ajustes dietéticos personalizados para ${c.name}.';
    }
  }

  Widget _buildPlanProposalPage() {
    final proposal = _cachedProposal ??= _computePlanProposal();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(
            icon: Icons.auto_awesome,
            title: 'Tu plan personalizado',
            subtitle: 'Calculado con tu perfil y el algoritmo de NutriPlato',
          ),
          const SizedBox(height: 16),
          _buildCalorieHeroCard(proposal),
          const SizedBox(height: 16),
          _buildStatsGrid(proposal),
          const SizedBox(height: 16),
          _buildMacroCard(proposal),
          const SizedBox(height: 16),
          _buildMealDistributionCard(proposal),
          const SizedBox(height: 16),
          _buildMealPlanCard(proposal),
          const SizedBox(height: 16),
          _buildWeightProjectionCard(proposal),
          if (proposal.adjustments.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildAdjustmentsCard(proposal),
          ],
          if (proposal.nutrientLimits.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildNutrientLimitsCard(proposal),
          ],
          const SizedBox(height: 16),
          _buildFoodCards(proposal),
          const SizedBox(height: 16),
          _buildDisclaimerCard(),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _planApplied ? null : _applyPlanToLog,
              icon: Icon(
                _planApplied ? Icons.check_circle : Icons.event_available,
                size: 20,
              ),
              label: Text(
                _planApplied
                    ? 'Plan aplicado a tu día'
                    : 'Aplicar plan a mi registro de hoy',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green.shade900,
                disabledBackgroundColor: Colors.white.withValues(alpha: 0.7),
                disabledForegroundColor: Colors.green.shade700,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Future<void> _applyPlanToLog() async {
    final proposal = _cachedProposal ?? _computePlanProposal();
    final plan = proposal.mealPlan;
    final foodLog = context.read<FoodLogProvider>();

    final meals = {
      'Desayuno': plan.breakfast,
      'Almuerzo': plan.lunch,
      'Cena': plan.dinner,
      'Snack': plan.snacks,
    };

    var added = 0;
    final now = DateTime.now();
    for (final entry in meals.entries) {
      for (final suggestion in entry.value) {
        await foodLog.addFoodEntry(
          FoodLogEntry(
            food: suggestion.food,
            quantity: suggestion.portions,
            timestamp: now,
            mealType: entry.key,
          ),
        );
        added++;
      }
    }

    if (mounted) {
      setState(() => _planApplied = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            added > 0
                ? '$added alimentos del plan agregados a tu día. ¡Buen provecho!'
                : 'No se encontraron alimentos para tu plan de hoy.',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.green.shade900,
        ),
      );
    }
  }

  Widget _buildWhiteCard({required Widget child, double padding = 16}) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildCardTitle(String text, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.green.shade900,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalorieHeroCard(_PlanProposal p) {
    return _buildWhiteCard(
      padding: 20,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calorías objetivo diarias',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  p.targetCalories.round().toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    'kcal / día',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Tu meta: ${_goal.label} · ${_goal.description}',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
            if (p.projection != null && p.projection!.weeksToGoal != null) ...[
              const SizedBox(height: 8),
              Text(
                'Proyección: alcanzar tu peso meta en '
                '~${p.projection!.weeksToGoal!.round()} semanas '
                '(${p.projection!.message.replaceFirst('Perderás', 'perdiendo').replaceFirst('Ganarás', 'ganando')})',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(_PlanProposal p) {
    Widget stat(IconData icon, String label, String value, Color color) {
      return _buildWhiteCard(
        padding: 14,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.green.shade900,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: stat(
                Icons.local_fire_department,
                'TMB',
                '${p.bmr.round()} kcal',
                Colors.orange.shade600,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: stat(
                Icons.bolt,
                'Gasto total (TDEE)',
                '${p.tdee.round()} kcal',
                Colors.amber.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: stat(
                Icons.monitor_weight,
                'IMC · ${p.bmiCategory}',
                p.bmi.toStringAsFixed(1),
                Colors.green.shade600,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: stat(
                Icons.water_drop,
                'Agua (${p.water.liters.toStringAsFixed(1)} L)',
                '${p.water.glasses} vasos',
                Colors.blue.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMacroCard(_PlanProposal p) {
    Widget barRow(String label, double percent, double grams, Color color) {
      return Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.green.shade900,
                ),
              ),
              const Spacer(),
              Text(
                '${grams.round()} g · ${percent.round()}%',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 10,
              child: Stack(
                children: [
                  Container(color: Colors.grey.shade200),
                  FractionallySizedBox(
                    widthFactor: (percent / 100).clamp(0.0, 1.0),
                    child: Container(color: color),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      );
    }

    return _buildWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(
            'Distribución de macronutrientes',
            Icons.pie_chart,
            Colors.green.shade700,
          ),
          const SizedBox(height: 14),
          barRow(
            'Proteína',
            p.macros.proteinPercent,
            p.macros.proteinGrams,
            Colors.green.shade600,
          ),
          barRow(
            'Carbohidratos',
            p.macros.carbPercent,
            p.macros.carbGrams,
            Colors.amber.shade700,
          ),
          barRow(
            'Grasas',
            p.macros.fatPercent,
            p.macros.fatGrams,
            Colors.orange.shade600,
          ),
          Text(
            'Fibra: ${p.macros.fiberGrams.round()} g · '
            'Proteína: ${p.macros.proteinPerKg.toStringAsFixed(1)} g/kg',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealDistributionCard(_PlanProposal p) {
    final maxKcal = p.mealDistribution.values.reduce((a, b) => a > b ? a : b);
    return _buildWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(
            'Cómo distribuir tus comidas',
            Icons.restaurant,
            Colors.green.shade700,
          ),
          const SizedBox(height: 12),
          ...p.mealDistribution.entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 78,
                    child: Text(
                      e.key,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: SizedBox(
                        height: 8,
                        child: Stack(
                          children: [
                            Container(color: Colors.grey.shade200),
                            FractionallySizedBox(
                              widthFactor: (e.value / maxKcal).clamp(0.0, 1.0),
                              child: Container(color: Colors.green.shade500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 56,
                    child: Text(
                      '${e.value.round()} kcal',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMealPlanCard(_PlanProposal p) {
    final plan = p.mealPlan;
    final meals = [
      ('Desayuno', plan.breakfast, Icons.wb_sunny, Colors.orange.shade600),
      ('Comida', plan.lunch, Icons.restaurant, Colors.green.shade600),
      ('Cena', plan.dinner, Icons.nights_stay, Colors.indigo.shade400),
      ('Snacks', plan.snacks, Icons.apple, Colors.amber.shade700),
    ];

    return _buildWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(
            'Tu plan de comidas de hoy',
            Icons.today,
            Colors.green.shade700,
          ),
          const SizedBox(height: 6),
          Text(
            'Generado por el algoritmo con alimentos seguros para tu perfil.',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 14),
          ...meals.map((m) => _buildMealBlock(m.$1, m.$2, m.$3, m.$4)),
        ],
      ),
    );
  }

  Widget _buildMealBlock(
    String title,
    List<MealSuggestion> items,
    IconData icon,
    Color color,
  ) {
    final totalKcal = items.fold<double>(0, (sum, s) => sum + s.calories);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              const Spacer(),
              Text(
                '${totalKcal.round()} kcal',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'Sin sugerencias para esta comida.',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            )
          else
            ...items.map(_buildMealItem),
        ],
      ),
    );
  }

  Widget _buildMealItem(MealSuggestion s) {
    final isWhole = s.portions == s.portions.roundToDouble();
    final portions = isWhole
        ? s.portions.toInt().toString()
        : s.portions.toStringAsFixed(1);
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.food.name,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade900,
                  ),
                ),
                Text(
                  '$portions porciones · ${s.calories.round()} kcal',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),
                if (s.preparationTip.isNotEmpty)
                  Text(
                    'Tip: ${s.preparationTip}',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightProjectionCard(_PlanProposal p) {
    final ideal = p.idealWeight;
    final proj = p.projection;
    final targetLabel = _targetWeight != null
        ? '${_targetWeight!.toStringAsFixed(0)} kg'
        : '${ideal.average.toStringAsFixed(0)} kg';

    return _buildWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(
            'Tu peso ideal y meta',
            Icons.monitor_weight,
            Colors.green.shade700,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildMiniStat(
                'IMC actual',
                p.bmi.toStringAsFixed(1),
                p.bmiCategory,
              ),
              _buildMiniStat(
                'Rango saludable',
                '${ideal.minHealthyWeight.toStringAsFixed(0)}-${ideal.maxHealthyWeight.toStringAsFixed(0)} kg',
                'OMS',
              ),
              _buildMiniStat(
                'Peso meta',
                targetLabel,
                proj != null && proj.weeksToGoal != null
                    ? '~${proj.weeksToGoal!.round()} sem'
                    : 'Mantener',
              ),
            ],
          ),
          if (proj != null) ...[
            const SizedBox(height: 12),
            Text(
              proj.message,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: proj.isRealistic
                    ? Colors.green.shade700
                    : Colors.orange.shade700,
              ),
            ),
            if (!proj.isRealistic)
              Text(
                'Considera ajustar tu meta para un ritmo más saludable.',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.grey.shade700,
                ),
              ),
          ],
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade200, height: 1),
          const SizedBox(height: 12),
          Text(
            'Estimaciones de peso ideal por fórmula',
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildFormulaStat('Devine', ideal.devine),
              _buildFormulaStat('Robinson', ideal.robinson),
              _buildFormulaStat('Miller', ideal.miller),
              _buildFormulaStat('Promedio', ideal.average),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaStat(String label, double value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '${value.toStringAsFixed(0)} kg',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.green.shade900,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, String sub) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.green.shade900,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            sub,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdjustmentsCard(_PlanProposal p) {
    return _buildWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(
            'Ajustes para tu salud',
            Icons.health_and_safety,
            Colors.red.shade600,
          ),
          const SizedBox(height: 12),
          ...p.adjustments.map(
            (adj) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: Colors.green.shade600,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      adj,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientLimitsCard(_PlanProposal p) {
    String labelFor(String key) {
      switch (key) {
        case 'sodium':
          return 'Sodio (mg/día)';
        case 'sugar':
          return 'Azúcar (g/día)';
        case 'carbs':
          return 'Carbohidratos (g/día)';
        case 'cholesterol':
          return 'Colesterol (mg/día)';
        case 'saturatedFat':
          return 'Grasa saturada (g/día)';
        case 'protein':
          return 'Proteína (g/kg)';
        case 'potassium':
          return 'Potasio (mg/día)';
        case 'phosphorus':
          return 'Fósforo (mg/día)';
        default:
          return key;
      }
    }

    return _buildWhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(
            'Límites de nutrientes',
            Icons.speed,
            Colors.orange.shade700,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: p.nutrientLimits.entries.map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Text(
                  '${labelFor(e.key)}: máx ${e.value.toStringAsFixed(e.value == e.value.roundToDouble() ? 0 : 1)}',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange.shade900,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCards(_PlanProposal p) {
    Widget chips(List<String> items, Color bg, Color text) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: items
            .map(
              (name) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: text,
                  ),
                ),
              ),
            )
            .toList(),
      );
    }

    return Column(
      children: [
        if (p.recommendedFoods.isNotEmpty) ...[
          _buildWhiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCardTitle(
                  'Alimentos recomendados para ti',
                  Icons.thumb_up,
                  Colors.green.shade600,
                ),
                const SizedBox(height: 12),
                chips(
                  p.recommendedFoods.take(8).map((s) => s.food.name).toList(),
                  Colors.green.shade50,
                  Colors.green.shade900,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (p.avoidFoods.isNotEmpty)
          _buildWhiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCardTitle(
                  'Alimentos a evitar o limitar',
                  Icons.block,
                  Colors.red.shade600,
                ),
                const SizedBox(height: 12),
                chips(
                  p.avoidFoods.take(6).map((s) => s.food.name).toList(),
                  Colors.red.shade50,
                  Colors.red.shade800,
                ),
              ],
            ),
          ),
        if (p.recommendedFoods.isEmpty && p.avoidFoods.isEmpty) ...[
          _buildWhiteCard(
            child: Text(
              'Con tu perfil actual no hay restricciones alimentarias '
              'especiales. ¡Disfruta de una alimentación variada!',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDisclaimerCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(
            child: Icon(Icons.info_outline, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Esta propuesta es orientativa y no sustituye la consulta con '
              'un profesional de la salud.',
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExcludeSemantics(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
        ),
        const SizedBox(height: 20),
        Semantics(
          header: true,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

/// Propuesta de plan nutricional calculada con el algoritmo real.
class _PlanProposal {
  final double bmr;
  final double tdee;
  final double targetCalories;
  final MacroDistribution macros;
  final IdealWeightResult idealWeight;
  final double bmi;
  final String bmiCategory;
  final WaterRequirement water;
  final WeightGoalProjection? projection;
  final List<String> conditionNames;
  final List<String> adjustments;
  final Map<String, double> nutrientLimits;
  final DailyMealPlan mealPlan;
  final List<FoodSuggestion> recommendedFoods;
  final List<FoodSuggestion> avoidFoods;
  final Map<String, double> mealDistribution;

  const _PlanProposal({
    required this.bmr,
    required this.tdee,
    required this.targetCalories,
    required this.macros,
    required this.idealWeight,
    required this.bmi,
    required this.bmiCategory,
    required this.water,
    required this.projection,
    required this.conditionNames,
    required this.adjustments,
    required this.nutrientLimits,
    required this.mealPlan,
    required this.recommendedFoods,
    required this.avoidFoods,
    required this.mealDistribution,
  });
}
