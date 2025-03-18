import 'package:flutter/material.dart';
import 'package:nutriplato/fitness/shared/fitness-popular.widget.dart';
import 'package:nutriplato/presentation/provider/user_provider.dart';
import 'package:nutriplato/presentation/screens/dashboard/widgets/learn_screen.dart';
import 'package:nutriplato/presentation/screens/featured_articles.dart';
import 'package:nutriplato/presentation/screens/widgets/sidebar.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NutriPlato'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      drawer: const DrawerProfile(),
      body: SafeArea(
        child: ListView(
          // Prevenir rebote de scroll en dispositivos iOS
          physics: const ClampingScrollPhysics(),
          children: [
            // Bienvenida al usuario
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Hola, ${user.username}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 320,
              child: FeaturedArticlesWidget(),
            ),
            const Divider(height: 32, thickness: 1),
            SizedBox(
              height: 230,
              child: const LearnScreen(),
            ),
            const Divider(height: 32, thickness: 1),
            SizedBox(
              height: 350,
              child: const PopularExercisesScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
