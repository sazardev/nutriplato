import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_entry.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_provider.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/services/nutrition_calculator_service.dart';
import 'package:nutriplato/infrastructure/services/smart_nutrition_service.dart';
import 'package:nutriplato/presentation/home.screen.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';
import 'package:nutriplato/presentation/screens/onboarding/models/plan_proposal.dart';
import 'package:nutriplato/presentation/screens/onboarding/steps/activity_step.dart';
import 'package:nutriplato/presentation/screens/onboarding/steps/body_data_step.dart';
import 'package:nutriplato/presentation/screens/onboarding/steps/goal_step.dart';
import 'package:nutriplato/presentation/screens/onboarding/steps/health_step.dart';
import 'package:nutriplato/presentation/screens/onboarding/steps/name_step.dart';
import 'package:nutriplato/presentation/screens/onboarding/steps/plan_proposal_step.dart';
import 'package:nutriplato/presentation/screens/onboarding/steps/welcome_step.dart';
import 'package:nutriplato/presentation/screens/onboarding/widgets/onboarding_nav_buttons.dart';
import 'package:nutriplato/presentation/screens/onboarding/widgets/onboarding_progress.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  PlanProposal? _cachedProposal;

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

  void _toggleCondition(String id) {
    setState(() {
      if (_selectedConditions.contains(id)) {
        _selectedConditions.remove(id);
      } else {
        _selectedConditions.add(id);
      }
    });
  }

  void _toggleAllergy(String allergy) {
    setState(() {
      if (_selectedAllergies.contains(allergy)) {
        _selectedAllergies.remove(allergy);
      } else {
        _selectedAllergies.add(allergy);
      }
    });
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
              OnboardingProgress(
                currentPage: _currentPage,
                totalPages: _totalPages,
              ),

              // Contenido
              Expanded(
                child: MediaQuery.disableAnimationsOf(context)
                    ? _buildPages()
                    : FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: _buildPages(),
                        ),
                      ),
              ),

              // Botones de navegacion
              OnboardingNavButtons(
                currentPage: _currentPage,
                totalPages: _totalPages,
                canProceed: _canProceed(),
                onNext: _animateToNextPage,
                onPrevious: _animateToPreviousPage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPages() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        _onPageChanged(index);
      },
      children: [
        const WelcomeStep(),
        NameStep(
          name: _name,
          onNameChanged: (value) => setState(() => _name = value),
          gender: _gender,
          onGenderChanged: (gender) => setState(() => _gender = gender),
        ),
        BodyDataStep(
          birthDate: _birthDate,
          height: _height,
          weight: _weight,
          targetWeight: _targetWeight,
          onBirthDateChanged: (date) => setState(() => _birthDate = date),
          onHeightChanged: (value) => setState(() => _height = value),
          onWeightChanged: (value) => setState(() => _weight = value),
          onTargetWeightChanged: (value) =>
              setState(() => _targetWeight = value),
        ),
        ActivityStep(
          activityLevel: _activityLevel,
          onChanged: (level) => setState(() => _activityLevel = level),
        ),
        GoalStep(
          goal: _goal,
          onChanged: (goal) => setState(() => _goal = goal),
        ),
        HealthStep(
          selectedConditions: _selectedConditions,
          selectedAllergies: _selectedAllergies,
          commonAllergies: _commonAllergies,
          onConditionToggled: _toggleCondition,
          onAllergyToggled: _toggleAllergy,
        ),
        PlanProposalStep(
          proposal: _cachedProposal ??= _computePlanProposal(),
          goal: _goal,
          targetWeight: _targetWeight,
          planApplied: _planApplied,
          onApplyPlan: _applyPlanToLog,
        ),
      ],
    );
  }

  // ============== PLAN PERSONALIZADO ==============

  /// Calcula la propuesta de plan usando el algoritmo real de NutriPlato.
  PlanProposal _computePlanProposal() {
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

    return PlanProposal(
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
      adjustments: conditions.map(conditionAdjustment).toList(),
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
}
