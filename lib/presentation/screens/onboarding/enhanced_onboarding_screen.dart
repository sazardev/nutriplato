import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
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
  final int _totalPages = 6;

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

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
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
    _fadeController.reverse().then((_) {
      if (_currentPage < _totalPages - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        _completeOnboarding();
      }
      _fadeController.forward();
    });
  }

  void _animateToPreviousPage() {
    if (_currentPage > 0) {
      _fadeController.reverse().then((_) {
        _pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        _fadeController.forward();
      });
    }
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
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
              Colors.green.shade400,
              Colors.green.shade600,
              Colors.green.shade800,
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
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      children: [
                        _buildWelcomePage(),
                        _buildNamePage(),
                        _buildBodyDataPage(),
                        _buildActivityPage(),
                        _buildGoalPage(),
                        _buildHealthPage(),
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
              label: const Text(
                'Atras',
                style: TextStyle(color: Colors.white),
              ),
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
            duration: const Duration(milliseconds: 800),
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
                  child: Icon(
                    Icons.restaurant_menu,
                    size: 70,
                    color: Colors.green.shade600,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          Text(
            'Bienvenido a',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white.withOpacity(0.9),
            ),
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
          child: Icon(icon, color: Colors.white, size: 24),
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
                  color: Colors.white.withOpacity(0.8),
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
                    prefixIcon:
                        Icon(Icons.person, color: Colors.green.shade600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Colors.green.shade600, width: 2),
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
              Text(
                'Tu IMC',
                style: TextStyle(color: color.withOpacity(0.8)),
              ),
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
            return GestureDetector(
              onTap: () => setState(() => _activityLevel = level),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:
                      isSelected ? Colors.white : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:
                        isSelected ? Colors.green.shade600 : Colors.transparent,
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
            return GestureDetector(
              onTap: () => setState(() => _goal = goal),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:
                      isSelected ? Colors.white : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:
                        isSelected ? Colors.green.shade600 : Colors.transparent,
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
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.white.withOpacity(0.9)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Esto nos ayuda a darte recomendaciones mas seguras',
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Condiciones medicas',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
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
                selectedColor: Colors.white,
                backgroundColor: Colors.white.withOpacity(0.2),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.green.shade700 : Colors.white,
                ),
                checkmarkColor: Colors.green.shade700,
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text(
            'Alergias alimentarias',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
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
                selectedColor: Colors.red.shade100,
                backgroundColor: Colors.white.withOpacity(0.2),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.red.shade700 : Colors.white,
                ),
                avatar: isSelected
                    ? Icon(Icons.warning, size: 16, color: Colors.red.shade700)
                    : null,
              );
            }).toList(),
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
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}
