import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:nutriplato/config/theme/app_theme.dart';
import 'package:nutriplato/presentation/provider/theme_changer_provider.dart';

class ModernLoadingScreen extends StatefulWidget {
  final String message;
  final Widget? child;

  const ModernLoadingScreen({
    super.key,
    this.message = 'Cargando...',
    this.child,
  });

  @override
  State<ModernLoadingScreen> createState() => _ModernLoadingScreenState();
}

class _ModernLoadingScreenState extends State<ModernLoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _fadeController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeChangerProvider>();
    final currentTheme = AppTheme.gradientThemes[themeProvider.selectedColor];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              currentTheme[0].withValues(alpha: 0.1),
              currentTheme[1].withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo animado
              AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationController.value * 2 * 3.14159,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: currentTheme,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: currentTheme[0].withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.restaurant_menu,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // Texto animado
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  widget.message,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Indicador de progreso moderno
              Container(
                width: 150,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, child) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: currentTheme,
                          stops: [
                            (_rotationController.value - 0.3).clamp(0.0, 1.0),
                            _rotationController.value.clamp(0.0, 1.0),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  },
                ),
              ),

              if (widget.child != null) ...[
                const SizedBox(height: 32),
                widget.child!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerLoading({
    super.key,
    required this.child,
    required this.isLoading,
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isLoading) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(ShimmerLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    final baseColor = widget.baseColor ?? Colors.grey.shade300;
    final highlightColor = widget.highlightColor ?? Colors.grey.shade100;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: [
                0.0,
                0.5,
                1.0,
              ],
              transform: GradientRotation(_animation.value),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
