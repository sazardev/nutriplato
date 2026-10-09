import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/infrastructure/repositories/preferences_repository.dart';
import 'package:nutriplato/infrastructure/services/backup_service.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';
import 'package:nutriplato/presentation/screens/profile/dialogs/add_condition_dialog.dart';
import 'package:nutriplato/presentation/screens/profile/dialogs/edit_profile_dialog.dart';
import 'package:nutriplato/presentation/screens/profile/progress_screen.dart';
import 'package:nutriplato/presentation/screens/profile/tabs/achievements_tab.dart';
import 'package:nutriplato/presentation/screens/profile/tabs/health_tab.dart';
import 'package:nutriplato/presentation/screens/profile/tabs/nutrition_tab.dart';
import 'package:nutriplato/presentation/screens/profile/tabs/profile_tab.dart';
import 'package:nutriplato/presentation/screens/profile/widgets/profile_header.dart';
import 'package:provider/provider.dart';

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
                  background: ProfileHeader(
                    profile: profile,
                    level: provider.getUserLevel(),
                    levelTitle: provider.getUserLevelTitle(),
                    levelProgress: provider.getLevelProgress(),
                  ),
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
                    ProfileTab(
                      profile: profile,
                      onViewProgress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProgressScreen(),
                        ),
                      ),
                      onEditProfile: () => showEditProfileDialog(context),
                      onShareBackup: _shareBackup,
                      onCopyBackup: _copyBackup,
                      onRestoreBackup: _restoreBackup,
                    ),
                    NutritionTab(profile: profile, calculation: calculation),
                    HealthTab(
                      conditions: provider.healthConditions,
                      profile: profile,
                      onAddCondition: () =>
                          showAddConditionDialog(context, provider),
                      onRemoveCondition: (condition) =>
                          provider.removeHealthCondition(condition.id),
                    ),
                    AchievementsTab(profile: profile),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _shareBackup() async {
    await BackupService.shareBackup(Get.find<PreferencesRepository>());
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Respaldo compartido')));
  }

  Future<void> _copyBackup() async {
    await BackupService.copyToClipboard(Get.find<PreferencesRepository>());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Respaldo copiado al portapapeles')),
    );
  }

  Future<void> _restoreBackup() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restaurar datos'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Pega aquí el JSON de un respaldo anterior. Se reemplazará la información actual.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              maxLines: 6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pega el JSON aquí...',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Restaurar'),
          ),
        ],
      ),
    );

    if (result == null || result.trim().isEmpty) return;

    final restored = await BackupService.restoreFromJson(
      Get.find<PreferencesRepository>(),
      result,
    );
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      restored > 0
          ? SnackBar(
              content: Text(
                'Datos restaurados ($restored claves). Reinicia la app.',
              ),
            )
          : const SnackBar(
              content: Text('No se pudo restaurar: JSON inválido'),
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
