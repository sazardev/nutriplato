import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/config/theme/app_theme.dart';
import 'package:nutriplato/fitness/fitness.controller.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_provider.dart';
import 'package:nutriplato/presentation/home.screen.dart';
import 'package:nutriplato/presentation/provider/article_provider.dart';
import 'package:nutriplato/presentation/provider/theme_changer_provider.dart';
import 'package:nutriplato/presentation/provider/user_provider.dart';
import 'package:nutriplato/presentation/screens/presentation/presentation_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  bool presentation = prefs.getBool('presentation') ?? true;

  runApp(
    MyApp(
      presentation: presentation,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool presentation;

  const MyApp({super.key, required this.presentation});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
          create: (_) {
            final foodLogProvider = FoodLogProvider();
            foodLogProvider.loadLogs();
            return foodLogProvider;
          },
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) {
            final userProvider = UserProvider();
            userProvider.loadUser();
            return userProvider;
          },
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) {
            final themeChangerProvider = ThemeChangerProvider();
            return themeChangerProvider;
          },
        ),
      ],
      child: Consumer<ThemeChangerProvider>(
        builder: (context, themeProvider, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NutriPlato',
            theme: AppTheme().getTheme(themeProvider.selectedColor),
            home:
                presentation ? const PresentationScreen() : const HomeScreen(),
            initialBinding: BindingsBuilder(() {
              Get.put(FitnessController());
            }),
          );
        },
      ),
    );
  }
}
