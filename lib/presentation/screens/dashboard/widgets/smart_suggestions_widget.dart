import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:nutriplato/infrastructure/services/smart_nutrition_service.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/presentation/screens/meal_plan/meal_plan_screen.dart';
import 'package:nutriplato/presentation/screens/education/nutrition_education_screen.dart';

class SmartSuggestionsWidget extends StatefulWidget {
  const SmartSuggestionsWidget({super.key});

  @override
  State<SmartSuggestionsWidget> createState() => _SmartSuggestionsWidgetState();
}

class _SmartSuggestionsWidgetState extends State<SmartSuggestionsWidget> {
  List<FoodSuggestion> _suggestions = [];
  FoodFact? _dailyFact;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;

    final profileProvider = context.read<UserProfileProvider>();
    final profile = profileProvider.profile;

    // Por ahora usar lista vacía hasta que se resuelvan las condiciones
    final List<HealthCondition> conditions = [];

    final suggestions = SmartNutritionService.getRecommendedFoods(
      profile: profile,
      conditions: conditions,
      limit: 5,
    );

    final facts = SmartNutritionService.getFoodFacts();
    final dailyFact = facts.isNotEmpty ? facts.first : null;

    if (mounted) {
      setState(() {
        _suggestions = suggestions;
        _dailyFact = dailyFact;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header con navegación
        _buildQuickActions(),
        const SizedBox(height: 20),

        // Dato del día
        if (_dailyFact != null) ...[
          _buildDailyFact(),
          const SizedBox(height: 20),
        ],

        // Sugerencias rápidas
        if (_suggestions.isNotEmpty) ...[
          _buildSuggestionsSection(),
        ],
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            title: 'Plan de Hoy',
            subtitle: 'Alimentación personalizada',
            icon: FontAwesomeIcons.bowlFood,
            color: Colors.green,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MealPlanScreen()),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionCard(
            title: 'Aprende',
            subtitle: 'Datos y tips',
            icon: FontAwesomeIcons.graduationCap,
            color: Colors.purple,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const NutritionEducationScreen()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shadowColor: color.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyFact() {
    return Card(
      elevation: 3,
      shadowColor: _dailyFact!.color.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _dailyFact!.color.withValues(alpha: 0.1),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _dailyFact!.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _dailyFact!.icon,
                color: _dailyFact!.color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.lightbulb,
                        color: Colors.amber.shade600,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Dato del Día',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.amber.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _dailyFact!.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _dailyFact!.fact,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '🍎 Recomendados para Ti',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MealPlanScreen()),
              ),
              child: Text(
                'Ver más',
                style: GoogleFonts.poppins(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = _suggestions[index];
              return _buildSuggestionCard(suggestion);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionCard(FoodSuggestion suggestion) {
    final food = suggestion.food;
    final calorias = double.tryParse(food.energia) ?? 0;

    Color cardColor;
    switch (suggestion.type) {
      case SuggestionType.recommended:
        cardColor = Colors.green;
        break;
      case SuggestionType.alternative:
        cardColor = Colors.blue;
        break;
      case SuggestionType.limitConsumption:
        cardColor = Colors.orange;
        break;
      case SuggestionType.avoid:
        cardColor = Colors.red;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(right: 12),
      elevation: 3,
      shadowColor: cardColor.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cardColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getCategoryIcon(food.category),
                    color: cardColor,
                    size: 18,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Colors.amber.shade600,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        suggestion.score.toStringAsFixed(0),
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              food.name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${calorias.toStringAsFixed(0)} kcal',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
                if (suggestion.benefits.isNotEmpty)
                  Icon(
                    Icons.check_circle_rounded,
                    color: cardColor,
                    size: 16,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'fruta':
        return FontAwesomeIcons.appleWhole;
      case 'verdura':
        return FontAwesomeIcons.carrot;
      case 'cereal':
        return FontAwesomeIcons.wheatAwn;
      case 'animal':
        return FontAwesomeIcons.drumstickBite;
      case 'leguminosa':
        return FontAwesomeIcons.seedling;
      default:
        return FontAwesomeIcons.utensils;
    }
  }
}
