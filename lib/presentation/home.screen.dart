import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/fitness/fitness.screen.dart';
import 'package:nutriplato/infrastructure/entities/food/calories_tracker_screen.dart';
import 'package:nutriplato/presentation/screens/plate/plate_screen.dart';
import 'package:nutriplato/search/search.screen.dart';
import 'package:nutriplato/presentation/screens/widgets/custom_bottom_nav.dart';
import 'package:nutriplato/presentation/screens/dashboard/modern_dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _Home();
}

class _Home extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _screens = const [
    ModernDashboardScreen(),
    CaloriesTrackerScreen(),
    SearchScreen(),
    PlateScreen(),
    FitnessScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);

    // Verificar si hay un argumento de índice para el tab
    if (Get.arguments != null && Get.arguments is int) {
      _currentIndex = Get.arguments;
      _pageController = PageController(initialPage: _currentIndex);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
