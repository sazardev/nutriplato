import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/config/theme/app_theme.dart';
import 'package:nutriplato/fitness/fitness.controller.dart';
import 'package:nutriplato/fitness/smart/smart_fitness.controller.dart';
import 'package:nutriplato/infrastructure/entities/food/custom_food_provider.dart';
import 'package:nutriplato/infrastructure/entities/food/favorites_provider.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_provider.dart';
import 'package:nutriplato/infrastructure/repositories/preferences_repository.dart';
import 'package:nutriplato/presentation/home.screen.dart';
import 'package:nutriplato/presentation/provider/article_provider.dart';
import 'package:nutriplato/presentation/provider/theme_changer_provider.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';
import 'package:nutriplato/presentation/provider/user_provider.dart';
import 'package:nutriplato/presentation/screens/onboarding/enhanced_onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final preferencesRepository = PreferencesRepository(prefs);

  runApp(
    MyApp(
      presentation: preferencesRepository.presentation,
      preferencesRepository: preferencesRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool presentation;
  final PreferencesRepository preferencesRepository;

  const MyApp({
    super.key,
    required this.presentation,
    required this.preferencesRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PreferencesRepository>.value(value: preferencesRepository),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) {
            final articleProvider = ArticleProvider();
            articleProvider.getArticles();
            return articleProvider;
          },
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) {
            final foodLogProvider = FoodLogProvider(
              context.read<PreferencesRepository>(),
            );
            foodLogProvider.loadLogs();
            return foodLogProvider;
          },
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) {
            final customFoodProvider = CustomFoodProvider(
              context.read<PreferencesRepository>(),
            );
            customFoodProvider.loadFoods();
            return customFoodProvider;
          },
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) {
            final favoritesProvider = FavoritesProvider(
              context.read<PreferencesRepository>(),
            );
            favoritesProvider.loadFavorites();
            return favoritesProvider;
          },
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) {
            final userProvider = UserProvider(
              context.read<PreferencesRepository>(),
            );
            userProvider.loadUser();
            return userProvider;
          },
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) {
            final themeChangerProvider = ThemeChangerProvider(
              context.read<PreferencesRepository>(),
            );
            return themeChangerProvider;
          },
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) {
            final userProfileProvider = UserProfileProvider(
              context.read<PreferencesRepository>(),
            );
            userProfileProvider.loadProfile();
            return userProfileProvider;
          },
        ),
      ],
      child: Consumer<ThemeChangerProvider>(
        builder: (context, themeProvider, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NutriPlato',
            theme: AppTheme().getTheme(themeProvider.selectedColor),
            home: presentation
                ? const EnhancedOnboardingScreen()
                : const HomeScreen(),
            initialBinding: BindingsBuilder(() {
              Get.put(preferencesRepository);
              Get.put(FitnessController());
              Get.put(SmartFitnessController(preferencesRepository));
            }),
          );
        },
      ),
    );
  }
}
