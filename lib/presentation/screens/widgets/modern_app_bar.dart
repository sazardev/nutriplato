import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:nutriplato/config/theme/app_theme.dart';
import 'package:nutriplato/presentation/provider/theme_changer_provider.dart';

class ModernAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final bool showGradient;
  final VoidCallback? onBackPressed;

  const ModernAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.backgroundColor,
    this.showGradient = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeChangerProvider>();
    final currentTheme = AppTheme.gradientThemes[themeProvider.selectedColor];

    return Container(
      decoration: showGradient
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: currentTheme,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            )
          : null,
      child: AppBar(
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: showGradient ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: centerTitle,
        backgroundColor: backgroundColor ??
            (showGradient ? Colors.transparent : Colors.transparent),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: leading ??
            (Navigator.canPop(context)
                ? IconButton(
                    onPressed: onBackPressed ?? () => Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: showGradient
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: showGradient ? Colors.white : Colors.black87,
                        size: 16,
                      ),
                    ),
                  )
                : null),
        actions: actions?.map((action) {
          if (action is IconButton) {
            return Container(
              margin: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: (action).onPressed,
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: showGradient
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    (action.icon as Icon).icon,
                    color: showGradient ? Colors.white : Colors.black87,
                    size: 20,
                  ),
                ),
              ),
            );
          }
          return action;
        }).toList(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SliverModernAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final double expandedHeight;
  final Widget? background;
  final bool pinned;
  final bool floating;

  const SliverModernAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.expandedHeight = 200.0,
    this.background,
    this.pinned = true,
    this.floating = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeChangerProvider>();
    final currentTheme = AppTheme.gradientThemes[themeProvider.selectedColor];

    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: floating,
      pinned: pinned,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: background ??
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: currentTheme,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          subtitle!,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
      ),
      actions: actions?.map((action) {
        if (action is IconButton) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: (action).onPressed,
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  (action.icon as Icon).icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          );
        }
        return action;
      }).toList(),
    );
  }
}
