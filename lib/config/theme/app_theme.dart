import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final List<Color> colorThemes = [
    const Color(0xFF6C63FF), // Morado moderno
    const Color(0xFF4ECDC4), // Verde azulado
    const Color(0xFFFF6B6B), // Coral
    const Color(0xFF4DABF7), // Azul cielo
    const Color(0xFFFFA726), // Naranja cálido
    const Color(0xFF51CF66), // Verde fresco
    const Color(0xFFFF8CC8), // Rosa suave
    const Color(0xFF845EC2), // Púrpura real
  ];

  // Colores complementarios para gradientes
  static const List<List<Color>> gradientThemes = [
    [Color(0xFF6C63FF), Color(0xFF845EC2)], // Morado
    [Color(0xFF4ECDC4), Color(0xFF44A08D)], // Verde azulado
    [Color(0xFFFF6B6B), Color(0xFFFF8E53)], // Coral
    [Color(0xFF4DABF7), Color(0xFF339AF0)], // Azul
    [Color(0xFFFFA726), Color(0xFFFF7043)], // Naranja
    [Color(0xFF51CF66), Color(0xFF40C057)], // Verde
    [Color(0xFFFF8CC8), Color(0xFFFF6B9D)], // Rosa
    [Color(0xFF845EC2), Color(0xFF6C63FF)], // Púrpura
  ];

  ThemeData getTheme([int selectedColor = 0]) {
    final Color primaryColor = colorThemes[selectedColor];

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: primaryColor,
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      chipTheme: ChipThemeData(
        elevation: 0,
        pressElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide.none,
        selectedColor: primaryColor.withValues(alpha: 0.15),
        backgroundColor: Colors.grey.shade100,
        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        hintStyle: GoogleFonts.poppins(
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: GoogleFonts.poppins(
          color: primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        highlightElevation: 0,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }
}
