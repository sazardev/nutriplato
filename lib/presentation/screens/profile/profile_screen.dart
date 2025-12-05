import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/infrastructure/services/nutrition_calculator_service.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';

/// Pantalla de perfil completo del usuario
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, provider, _) {
        final profile = provider.profile;
        final calculation = provider.getNutritionCalculation();

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // App Bar con información del usuario
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildProfileHeader(context, profile, provider),
                ),
              ),

              // Tabs
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    tabs: const [
                      Tab(icon: Icon(Icons.person), text: 'Perfil'),
                      Tab(icon: Icon(Icons.restaurant), text: 'Nutrición'),
                      Tab(icon: Icon(Icons.medical_services), text: 'Salud'),
                      Tab(icon: Icon(Icons.emoji_events), text: 'Logros'),
                    ],
                  ),
                ),
              ),

              // Contenido de tabs
              SliverFillRemaining(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildProfileTab(context, profile, provider),
                    _buildNutritionTab(context, profile, calculation),
                    _buildHealthTab(context, provider),
                    _buildAchievementsTab(context, profile, provider),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    UserProfile profile,
    UserProfileProvider provider,
  ) {
    final level = provider.getUserLevel();
    final levelTitle = provider.getUserLevelTitle();
    final levelProgress = provider.getLevelProgress();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Center(
                  child: Text(
                    profile.username.isNotEmpty
                        ? profile.username[0].toUpperCase()
                        : '?',
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                profile.username,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      'Nivel $level - $levelTitle',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Barra de progreso de nivel
              Column(
                children: [
                  LinearProgressIndicator(
                    value: levelProgress / 100,
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${levelProgress.toStringAsFixed(0)}% hacia el siguiente nivel',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTab(
    BuildContext context,
    UserProfile profile,
    UserProfileProvider provider,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Información Personal'),
          _buildInfoCard([
            _buildInfoRow(Icons.person, 'Nombre', profile.username),
            _buildInfoRow(
              Icons.cake,
              'Edad',
              profile.age != null ? '${profile.age} años' : 'No especificado',
            ),
            _buildInfoRow(
              Icons.wc,
              'Género',
              profile.gender.label,
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionTitle('Medidas Corporales'),
          _buildInfoCard([
            _buildInfoRow(
              Icons.height,
              'Altura',
              profile.heightCm != null
                  ? '${profile.heightCm!.toStringAsFixed(0)} cm'
                  : 'No especificado',
            ),
            _buildInfoRow(
              Icons.monitor_weight,
              'Peso actual',
              profile.weightKg != null
                  ? '${profile.weightKg!.toStringAsFixed(1)} kg'
                  : 'No especificado',
            ),
            _buildInfoRow(
              Icons.flag,
              'Peso objetivo',
              profile.targetWeightKg != null
                  ? '${profile.targetWeightKg!.toStringAsFixed(1)} kg'
                  : 'No especificado',
            ),
            if (profile.bmi != null)
              _buildInfoRow(
                Icons.analytics,
                'IMC',
                '${profile.bmi!.toStringAsFixed(1)} (${profile.bmiCategory})',
              ),
          ]),
          const SizedBox(height: 24),
          _buildSectionTitle('Estilo de Vida'),
          _buildInfoCard([
            _buildInfoRow(
              Icons.directions_run,
              'Actividad física',
              profile.activityLevel.label,
            ),
            _buildInfoRow(
              Icons.track_changes,
              'Objetivo',
              profile.nutritionGoal.label,
            ),
          ]),
          const SizedBox(height: 24),
          Center(
            child: TextButton.icon(
              onPressed: () => _showEditProfileDialog(context, provider),
              icon: const Icon(Icons.edit),
              label: const Text('Editar Perfil'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionTab(
    BuildContext context,
    UserProfile profile,
    NutritionCalculation? calculation,
  ) {
    if (calculation == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 64,
                color: Colors.orange.shade300,
              ),
              const SizedBox(height: 16),
              Text(
                'Completa tu perfil',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Necesitamos tu altura, peso, edad y género para calcular tus requerimientos nutricionales.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calorías diarias
          _buildCalorieCard(calculation),
          const SizedBox(height: 16),

          // Macronutrientes
          _buildSectionTitle('Macronutrientes Diarios'),
          _buildMacroCard(calculation.macros),
          const SizedBox(height: 16),

          // Agua
          _buildSectionTitle('Hidratación'),
          _buildWaterCard(calculation.waterRequirement),
          const SizedBox(height: 16),

          // Peso ideal
          _buildSectionTitle('Peso Ideal'),
          _buildIdealWeightCard(calculation.idealWeight, profile),
          const SizedBox(height: 16),

          // Proyección de peso
          if (calculation.weightProjection != null) ...[
            _buildSectionTitle('Proyección'),
            _buildProjectionCard(calculation.weightProjection!),
          ],
        ],
      ),
    );
  }

  Widget _buildCalorieCard(NutritionCalculation calculation) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCalorieColumn(
                  'TMB',
                  calculation.bmr.round().toString(),
                  'kcal',
                  Colors.blue,
                ),
                _buildCalorieColumn(
                  'TDEE',
                  calculation.tdee.round().toString(),
                  'kcal',
                  Colors.orange,
                ),
                _buildCalorieColumn(
                  'Objetivo',
                  calculation.targetCalories.round().toString(),
                  'kcal',
                  Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'TMB: Tasa Metabólica Basal\nTDEE: Gasto Energético Total Diario',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalorieColumn(
    String label,
    String value,
    String unit,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          unit,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildMacroCard(MacroDistribution macros) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildMacroRow(
              'Proteínas',
              macros.proteinGrams,
              macros.proteinPercent,
              Colors.red,
            ),
            const SizedBox(height: 12),
            _buildMacroRow(
              'Carbohidratos',
              macros.carbGrams,
              macros.carbPercent,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildMacroRow(
              'Grasas',
              macros.fatGrams,
              macros.fatPercent,
              Colors.yellow.shade700,
            ),
            const SizedBox(height: 12),
            _buildMacroRow(
              'Fibra',
              macros.fiberGrams,
              0,
              Colors.green,
              showPercent: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroRow(
    String name,
    double grams,
    double percent,
    Color color, {
    bool showPercent = true,
  }) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          '${grams.round()}g',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (showPercent) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${percent.round()}%',
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildWaterCard(WaterRequirement water) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.water_drop,
                color: Colors.blue,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${water.liters.toStringAsFixed(1)} litros',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    '${water.glasses} vasos de 250ml',
                    style: TextStyle(
                      color: Colors.grey.shade600,
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

  Widget _buildIdealWeightCard(
      IdealWeightResult idealWeight, UserProfile profile) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rango saludable'),
                    Text(
                      '${idealWeight.minHealthyWeight.toStringAsFixed(1)} - ${idealWeight.maxHealthyWeight.toStringAsFixed(1)} kg',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Peso ideal promedio'),
                    Text(
                      '${idealWeight.average.toStringAsFixed(1)} kg',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (profile.weightKg != null) ...[
              const SizedBox(height: 16),
              _buildWeightDifferenceIndicator(
                profile.weightKg!,
                idealWeight.average,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWeightDifferenceIndicator(double current, double ideal) {
    final difference = current - ideal;
    final isOver = difference > 0;
    final color = difference.abs() < 2
        ? Colors.green
        : isOver
            ? Colors.orange
            : Colors.blue;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            difference.abs() < 2
                ? Icons.check_circle
                : isOver
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
            color: color,
          ),
          const SizedBox(width: 12),
          Text(
            difference.abs() < 2
                ? '¡Estás en tu peso ideal!'
                : isOver
                    ? 'Te faltan ${difference.abs().toStringAsFixed(1)} kg para tu peso ideal'
                    : 'Te faltan ${difference.abs().toStringAsFixed(1)} kg para tu peso ideal',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectionCard(WeightGoalProjection projection) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  projection.isRealistic
                      ? Icons.check_circle
                      : Icons.warning_amber,
                  color: projection.isRealistic ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    projection.message,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            if (projection.weeksToGoal != null) ...[
              const SizedBox(height: 12),
              Text(
                'Tiempo estimado: ${projection.weeksToGoal!.round()} semanas',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHealthTab(BuildContext context, UserProfileProvider provider) {
    final conditions = provider.healthConditions;
    final profile = provider.profile;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Condiciones de Salud'),
          if (conditions.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.health_and_safety,
                      size: 48,
                      color: Colors.green.shade300,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No has registrado condiciones de salud',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () =>
                          _showAddConditionDialog(context, provider),
                      child: const Text('Agregar condición'),
                    ),
                  ],
                ),
              ),
            )
          else
            ...conditions.map((condition) => _buildConditionCard(
                  context,
                  condition,
                  () => provider.removeHealthCondition(condition.id),
                )),
          const SizedBox(height: 16),
          if (conditions.isNotEmpty)
            Center(
              child: TextButton.icon(
                onPressed: () => _showAddConditionDialog(context, provider),
                icon: const Icon(Icons.add),
                label: const Text('Agregar otra condición'),
              ),
            ),
          const SizedBox(height: 24),
          _buildSectionTitle('Alergias'),
          if (profile.allergies.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No has registrado alergias'),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: profile.allergies
                  .map((allergy) => Chip(
                        label: Text(allergy),
                        backgroundColor: Colors.red.shade100,
                        avatar: const Icon(Icons.warning, size: 18),
                      ))
                  .toList(),
            ),
          const SizedBox(height: 24),
          _buildSectionTitle('Restricciones Dietéticas'),
          if (profile.dietaryRestrictions.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No has registrado restricciones'),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: profile.dietaryRestrictions
                  .map((restriction) => Chip(
                        label: Text(restriction),
                        backgroundColor: Colors.green.shade100,
                        avatar: const Icon(Icons.eco, size: 18),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildConditionCard(
    BuildContext context,
    HealthCondition condition,
    VoidCallback onRemove,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.medical_services, color: Colors.red),
        ),
        title: Text(
          condition.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          condition.type.label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onRemove,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  condition.description,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                if (condition.avoidFoods.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const Text(
                    'Evitar:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: condition.avoidFoods
                        .take(5)
                        .map((f) => Chip(
                              label:
                                  Text(f, style: const TextStyle(fontSize: 12)),
                              backgroundColor: Colors.red.shade50,
                              visualDensity: VisualDensity.compact,
                            ))
                        .toList(),
                  ),
                ],
                if (condition.recommendedFoods.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const Text(
                    'Recomendados:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: condition.recommendedFoods
                        .take(5)
                        .map((f) => Chip(
                              label:
                                  Text(f, style: const TextStyle(fontSize: 12)),
                              backgroundColor: Colors.green.shade50,
                              visualDensity: VisualDensity.compact,
                            ))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab(
    BuildContext context,
    UserProfile profile,
    UserProfileProvider provider,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Estadísticas'),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              _buildStatCard(
                'Artículos leídos',
                profile.articlesRead.toString(),
                Icons.menu_book,
                Colors.purple,
              ),
              _buildStatCard(
                'Ejercicios hechos',
                profile.exercisesCompleted.toString(),
                Icons.fitness_center,
                Colors.orange,
              ),
              _buildStatCard(
                'Alimentos vistos',
                profile.foodsViewed.toString(),
                Icons.restaurant,
                Colors.green,
              ),
              _buildStatCard(
                'Días registrados',
                profile.daysLogged.toString(),
                Icons.calendar_today,
                Colors.blue,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Racha'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.local_fire_department,
                          color: Colors.orange, size: 40),
                      const SizedBox(height: 8),
                      Text(
                        '${profile.currentStreak}',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const Text('Racha actual'),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 80,
                    color: Colors.grey.shade300,
                  ),
                  Column(
                    children: [
                      const Icon(Icons.emoji_events,
                          color: Colors.amber, size: 40),
                      const SizedBox(height: 8),
                      Text(
                        '${profile.longestStreak}',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                      const Text('Mejor racha'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(
    BuildContext context,
    UserProfileProvider provider,
  ) {
    // Implementar diálogo de edición
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de edición próximamente')),
    );
  }

  void _showAddConditionDialog(
    BuildContext context,
    UserProfileProvider provider,
  ) {
    final conditions = MexicanHealthConditions.all;
    final existingIds = provider.healthConditions.map((c) => c.id).toSet();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Agregar Condición de Salud',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: conditions.length,
                itemBuilder: (context, index) {
                  final condition = conditions[index];
                  final exists = existingIds.contains(condition.id);

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          exists ? Colors.grey.shade200 : Colors.red.shade100,
                      child: Icon(
                        Icons.medical_services,
                        color: exists ? Colors.grey : Colors.red,
                      ),
                    ),
                    title: Text(condition.name),
                    subtitle: Text(condition.type.label),
                    trailing: exists
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                    enabled: !exists,
                    onTap: exists
                        ? null
                        : () {
                            provider.addHealthCondition(condition);
                            Navigator.pop(context);
                          },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
