import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: theme.primaryColor,
          unselectedItemColor: Colors.grey.shade400,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: _NavIcon(FontAwesomeIcons.house, false),
              activeIcon: _NavIcon(FontAwesomeIcons.house, true),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: _NavIcon(FontAwesomeIcons.chartPie, false),
              activeIcon: _NavIcon(FontAwesomeIcons.chartPie, true),
              label: 'Nutrición',
            ),
            BottomNavigationBarItem(
              icon: _NavIcon(FontAwesomeIcons.magnifyingGlass, false),
              activeIcon: _NavIcon(FontAwesomeIcons.magnifyingGlass, true),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: _NavIcon(FontAwesomeIcons.utensils, false),
              activeIcon: _NavIcon(FontAwesomeIcons.utensils, true),
              label: 'Plato',
            ),
            BottomNavigationBarItem(
              icon: _NavIcon(FontAwesomeIcons.dumbbell, false),
              activeIcon: _NavIcon(FontAwesomeIcons.dumbbell, true),
              label: 'Fitness',
            ),
          ],
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const _NavIcon(this.icon, this.isActive);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive
            ? theme.primaryColor.withValues(alpha: 0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: FaIcon(
        icon,
        size: isActive ? 20 : 18,
        color: isActive ? theme.primaryColor : Colors.grey.shade400,
      ),
    );
  }
}
