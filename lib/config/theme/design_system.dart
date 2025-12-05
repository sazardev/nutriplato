import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Sistema de diseño unificado para NutriPlato
/// Este archivo contiene todas las constantes y estilos reutilizables
class NutriDesign {
  NutriDesign._();

  // ============ COLORES ============
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundWhite = Colors.white;
  static const Color surfaceColor = Colors.white;

  // Colores de estado
  static const Color success = Color(0xFF51CF66);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFFF6B6B);
  static const Color info = Color(0xFF4DABF7);

  // Grises
  static const Color grey50 = Color(0xFFF8F9FA);
  static const Color grey100 = Color(0xFFF1F3F4);
  static const Color grey200 = Color(0xFFE8EAED);
  static const Color grey300 = Color(0xFFDADCE0);
  static const Color grey400 = Color(0xFFBDC1C6);
  static const Color grey500 = Color(0xFF9AA0A6);
  static const Color grey600 = Color(0xFF80868B);
  static const Color grey700 = Color(0xFF5F6368);
  static const Color grey800 = Color(0xFF3C4043);
  static const Color grey900 = Color(0xFF202124);

  // ============ ESPACIADO ============
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing48 = 48.0;

  // ============ BORDER RADIUS ============
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;
  static const double radiusXXLarge = 24.0;
  static const double radiusCircle = 100.0;

  // ============ ELEVACIÓN ============
  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;

  // ============ ICONOS ============
  static const double iconSmall = 16.0;
  static const double iconMedium = 20.0;
  static const double iconLarge = 24.0;
  static const double iconXLarge = 32.0;

  // ============ TIPOGRAFÍA ============
  static TextStyle get heading1 => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: grey900,
      );

  static TextStyle get heading2 => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: grey900,
      );

  static TextStyle get heading3 => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: grey900,
      );

  static TextStyle get heading4 => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: grey900,
      );

  static TextStyle get subtitle1 => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: grey700,
      );

  static TextStyle get subtitle2 => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: grey700,
      );

  static TextStyle get body1 => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: grey800,
      );

  static TextStyle get body2 => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: grey700,
      );

  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: grey600,
      );

  static TextStyle get buttonText => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  // ============ DECORACIONES ============
  static BoxDecoration get cardDecoration => BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration cardDecorationWithColor(Color color) => BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(radiusLarge),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration gradientDecoration(List<Color> colors) => BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusXLarge),
      );

  // ============ SOMBRAS ============
  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> shadowWithColor(Color color) => [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ];

  // ============ BORDES ============
  static BorderRadius get borderRadiusSmall =>
      BorderRadius.circular(radiusSmall);
  static BorderRadius get borderRadiusMedium =>
      BorderRadius.circular(radiusMedium);
  static BorderRadius get borderRadiusLarge =>
      BorderRadius.circular(radiusLarge);
  static BorderRadius get borderRadiusXLarge =>
      BorderRadius.circular(radiusXLarge);
}

/// Extensión para obtener colores con opacidad usando el nuevo método
extension ColorOpacity on Color {
  Color get withAlpha15 => withValues(alpha: 0.15);
  Color get withAlpha20 => withValues(alpha: 0.2);
  Color get withAlpha30 => withValues(alpha: 0.3);
  Color get withAlpha50 => withValues(alpha: 0.5);
  Color get withAlpha70 => withValues(alpha: 0.7);
  Color get withAlpha90 => withValues(alpha: 0.9);
}

/// Widget de AppBar unificado para todas las pantallas
class NutriAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Color> gradientColors;
  final Widget? leading;
  final List<Widget>? actions;
  final double expandedHeight;
  final bool centerTitle;
  final Widget? flexibleContent;

  const NutriAppBar({
    super.key,
    required this.title,
    this.subtitle,
    required this.gradientColors,
    this.leading,
    this.actions,
    this.expandedHeight = 140,
    this.centerTitle = false,
    this.flexibleContent,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: gradientColors.first,
      leading: leading,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(NutriDesign.spacing20),
              child: Column(
                crossAxisAlignment: centerTitle
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (flexibleContent != null)
                    flexibleContent!
                  else ...[
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Card unificado para toda la app
class NutriCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final VoidCallback? onTap;
  final List<Color>? gradientColors;

  const NutriCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.onTap,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidget = Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 6),
      decoration: gradientColors != null
          ? NutriDesign.gradientDecoration(gradientColors!)
          : NutriDesign.cardDecoration.copyWith(
              color: color ?? NutriDesign.surfaceColor,
            ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(NutriDesign.spacing16),
        child: child,
      ),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: NutriDesign.borderRadiusLarge,
          child: cardWidget,
        ),
      );
    }

    return cardWidget;
  }
}

/// Sección con título unificada
class NutriSection extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const NutriSection({
    super.key,
    required this.title,
    this.trailing,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: NutriDesign.spacing16,
            vertical: NutriDesign.spacing8,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: NutriDesign.heading4),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: NutriDesign.spacing12),
          child,
        ],
      ),
    );
  }
}

/// Chip unificado
class NutriChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;

  const NutriChip({
    super.key,
    required this.label,
    required this.color,
    this.selected = false,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(NutriDesign.radiusCircle),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: NutriDesign.spacing12,
            vertical: NutriDesign.spacing8,
          ),
          decoration: BoxDecoration(
            color: selected ? color : color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(NutriDesign.radiusCircle),
            border: Border.all(
              color: selected ? color : color.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: NutriDesign.iconSmall,
                  color: selected ? Colors.white : color,
                ),
                const SizedBox(width: NutriDesign.spacing4),
              ],
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.white : color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Badge de información nutricional
class NutriBadge extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData? icon;

  const NutriBadge({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: NutriDesign.spacing12,
        vertical: NutriDesign.spacing8,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(NutriDesign.radiusMedium),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: color.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Empty state unificado
class NutriEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? action;

  const NutriEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(NutriDesign.spacing32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(NutriDesign.spacing24),
              decoration: BoxDecoration(
                color: NutriDesign.grey100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: NutriDesign.grey400,
              ),
            ),
            const SizedBox(height: NutriDesign.spacing24),
            Text(
              title,
              style: NutriDesign.heading4.copyWith(color: NutriDesign.grey700),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: NutriDesign.spacing8),
              Text(
                subtitle!,
                style: NutriDesign.body2,
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: NutriDesign.spacing24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Loading indicator unificado
class NutriLoading extends StatelessWidget {
  final String? message;
  final Color? color;

  const NutriLoading({
    super.key,
    this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = color ?? Theme.of(context).primaryColor;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: primaryColor,
            strokeWidth: 3,
          ),
          if (message != null) ...[
            const SizedBox(height: NutriDesign.spacing16),
            Text(
              message!,
              style: NutriDesign.body2,
            ),
          ],
        ],
      ),
    );
  }
}

// ============ ALIASES PARA MEJOR LEGIBILIDAD ============

/// Colores de la aplicación - Alias de NutriDesign
class AppColors {
  AppColors._();

  static Color get background => NutriDesign.backgroundLight;
  static Color get surface => NutriDesign.surfaceColor;
  static Color get textPrimary => NutriDesign.grey900;
  static Color get textSecondary => NutriDesign.grey600;
  static Color get textMuted => NutriDesign.grey500;
  static Color get divider => NutriDesign.grey200;
  static Color get success => NutriDesign.success;
  static Color get warning => NutriDesign.warning;
  static Color get error => NutriDesign.error;
  static Color get info => NutriDesign.info;
}

/// Espaciado de la aplicación - Alias de NutriDesign
class AppSpacing {
  AppSpacing._();

  static const double xs = NutriDesign.spacing4;
  static const double sm = NutriDesign.spacing8;
  static const double md = NutriDesign.spacing16;
  static const double lg = NutriDesign.spacing24;
  static const double xl = NutriDesign.spacing32;
  static const double xxl = NutriDesign.spacing48;
}

/// Radios de borde - Alias de NutriDesign
class AppRadius {
  AppRadius._();

  static const double sm = NutriDesign.radiusSmall;
  static const double md = NutriDesign.radiusMedium;
  static const double lg = NutriDesign.radiusLarge;
  static const double xl = NutriDesign.radiusXLarge;
  static const double xxl = NutriDesign.radiusXXLarge;
  static const double full = NutriDesign.radiusCircle;
}

/// Tipografía de la aplicación - Alias de NutriDesign
class AppTypography {
  AppTypography._();

  static TextStyle get h1 => NutriDesign.heading1;
  static TextStyle get h2 => NutriDesign.heading2;
  static TextStyle get h3 => NutriDesign.heading3;
  static TextStyle get titleLarge => NutriDesign.heading3;
  static TextStyle get titleMedium => NutriDesign.heading4;
  static TextStyle get titleSmall => NutriDesign.subtitle1;
  static TextStyle get bodyLarge => NutriDesign.body1;
  static TextStyle get bodyMedium => NutriDesign.body2;
  static TextStyle get bodySmall => NutriDesign.caption;
  static TextStyle get labelLarge => NutriDesign.buttonText;
  static TextStyle get labelSmall => NutriDesign.caption;
}

/// Sombras de la aplicación
class AppShadows {
  AppShadows._();

  static BoxShadow get subtle => BoxShadow(
        color: Colors.black.withValues(alpha: 0.04),
        blurRadius: 8,
        offset: const Offset(0, 2),
      );

  static BoxShadow get card => BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 12,
        offset: const Offset(0, 4),
      );

  static BoxShadow get elevated => BoxShadow(
        color: Colors.black.withValues(alpha: 0.12),
        blurRadius: 20,
        offset: const Offset(0, 8),
      );
}

/// Gradientes de la aplicación
class AppGradients {
  AppGradients._();

  static LinearGradient get primary => const LinearGradient(
        colors: [Color(0xFF7C3AED), Color(0xFF9333EA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get success => const LinearGradient(
        colors: [Color(0xFF10B981), Color(0xFF059669)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get warning => const LinearGradient(
        colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get danger => const LinearGradient(
        colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get ocean => const LinearGradient(
        colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
