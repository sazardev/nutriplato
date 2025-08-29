import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const ModernCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.boxShadow,
    this.border,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      child: Material(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(20),
              border: border ??
                  Border.all(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
              boxShadow: boxShadow,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class GradientCard extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const GradientCard({
    super.key,
    required this.child,
    required this.colors,
    this.padding,
    this.margin,
    this.borderRadius,
    this.onTap,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colors.first.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final String? value;
  final VoidCallback? onTap;
  final Widget? trailing;

  const InfoCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.iconColor,
    this.value,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (value != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                value!,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: iconColor,
                ),
              ),
            ),
          ],
          if (trailing != null) trailing!,
          if (onTap != null) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;
  final double? progress;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      child: SizedBox(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
                const Spacer(),
                if (progress != null)
                  Container(
                    width: 36,
                    height: 36,
                    child: CircularProgressIndicator(
                      value: progress!,
                      backgroundColor: color.withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      strokeWidth: 2.5,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Flexible(
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 2),
            Flexible(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  subtitle!,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
