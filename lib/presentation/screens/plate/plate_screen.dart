import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nutriplato/presentation/screens/plate/widgets/plato_info_screen.dart';
import 'package:nutriplato/config/theme/design_system.dart';

import '../../../data/data.dart';
import '../food/foods.screen.dart';
import 'widgets/circlepainter.dart';

/// Detecta la sección del plato correspondiente a un toque (geometría polar).
///
/// [tapPosition] usa coordenadas locales del plato: (0,0) es la esquina
/// superior izquierda del cuadrado que lo contiene y [size] su lado. La
/// geometría sigue la misma convención que [Canvas.drawArc] (ángulo 0 en el
/// eje +x "3 en punto", positivo en sentido horario), consistente con el
/// pintado de [CirclePainter]. Devuelve el índice de la sección tocada o
/// `null` si el toque cae fuera del círculo del plato.
///
/// Es una función pura para facilitar pruebas unitarias.
int? detectPlateSection(Offset tapPosition, double size, List<double> angles) {
  if (size <= 0 || angles.length < 2) return null;

  final Offset center = Offset(size / 2, size / 2);
  final Offset delta = tapPosition - center;

  // Área de acierto: el círculo del plato, con tolerancia en el borde.
  if (delta.distance > size / 2 * 1.05) return null;

  // Normaliza el ángulo a [0, 2π). `atan2` comparte convención con drawArc.
  double angle = atan2(delta.dy, delta.dx);
  if (angle < 0) angle += 2 * pi;

  // Búsqueda por rango angular exacto; las secciones pequeñas se tocan igual.
  for (int i = 0; i < angles.length - 1; i++) {
    if (angle >= angles[i] && angle < angles[i + 1]) {
      return i;
    }
  }

  // Fallback a la última sección (ángulo == 2π, imposible tras normalizar).
  return angles.length - 2;
}

class PlateScreen extends StatefulWidget {
  const PlateScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PlateState();
}

class _PlateState extends State<PlateScreen> with TickerProviderStateMixin {
  // Changed to TickerProviderStateMixin to support multiple animations
  int? highlightedSection;
  late AnimationController _highlightAnimationController;
  late AnimationController _sheetAnimationController;

  // Definición de los ángulos para las secciones del plato (en radianes)
  // Los ángulos representan las nuevas proporciones:
  // 22% Cereales, 15% Leguminosas, 8% Animal, 5% Grasas, 50% Verduras & Frutas
  final List<double> angles = [
    0, // Inicio de cereales
    0.44 * pi, // Fin de cereales / Inicio de leguminosas
    0.74 * pi, // Fin de leguminosas / Inicio de animal
    0.9 * pi, // Fin de animal / Inicio de grasas
    pi, // Fin de grasas / Inicio de verduras & frutas
    2 * pi, // Fin de verduras & frutas / Cierre del círculo
  ];

  @override
  void initState() {
    super.initState();
    _highlightAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _sheetAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _highlightAnimationController.dispose();
    _sheetAnimationController.dispose();
    super.dispose();
  }

  // Activa la animación de resaltado para la sección tocada
  void _highlightSection(int? section) {
    if (section == null) return;

    setState(() {
      highlightedSection = section;
    });

    _highlightAnimationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: AppGradients.success),
              child: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                title: Text(
                  'Plato del Buen Comer',
                  style: AppTypography.titleLarge.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(gradient: AppGradients.success),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.pie_chart,
                            color: Colors.white.withValues(alpha: .3),
                            size: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PlatoInformationScreen(),
                  ),
                ),
                icon: const Icon(Icons.info_outline, color: Colors.white),
                tooltip: 'Información del plato',
              ),
            ],
          ),
          SliverFillRemaining(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: _buildPlateContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlateContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double size = min(constraints.maxWidth, constraints.maxHeight);

        // Ajustar los radios para cada sección (ahora con 5 secciones)
        // El tamaño de cada sección está ajustado visualmente para que sea agradable
        final List<double> radii = [
          size / 2 - 45, // Cereales (22%)
          size / 2 - 45, // Leguminosas (15%)
          size / 2 - 45, // Animal (8%)
          size / 2 - 45, // Grasas (5%)
          size / 2 - 45, // Verduras & Frutas (50%)
        ];

        final Map<CustomSemanticsAction, VoidCallback> sectionActions = {
          for (int i = 0; i < shortCategories.length; i++)
            CustomSemanticsAction(label: shortCategories[i]): () =>
                _openSection(i),
        };

        return Semantics(
          container: true,
          label:
              'Plato del Buen Comer: 5 grupos de alimentos. Activa una sección para ver sus alimentos.',
          focusable: true,
          customSemanticsActions: sectionActions,
          child: GestureDetector(
            onTapDown: (details) => _handleTapDown(details, size),
            child: AnimatedBuilder(
              animation: _highlightAnimationController,
              builder: (context, child) {
                return Material(
                  elevation: 10,
                  shadowColor: Colors.black54,
                  shape: const CircleBorder(),
                  child: SizedBox(
                    width: size,
                    height: size,
                    child: CustomPaint(
                      painter: CirclePainter(
                        radii: radii,
                        angles: angles,
                        lineLength: 1.1,
                        categories: shortCategories,
                        highlightedSection: highlightedSection,
                        highlightAnimation: _highlightAnimationController.value,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _handleTapDown(TapDownDetails details, double size) {
    // `localPosition` ya viene en coordenadas del plato: corrige el desfase
    // que causaba usar `globalToLocal` del Scaffold (appbar/padding).
    final tappedSection = detectPlateSection(
      details.localPosition,
      size,
      angles,
    );

    if (tappedSection != null) {
      _openSection(tappedSection);
    }
  }

  void _openSection(int section) {
    _highlightSection(section);
    Color color = sectionColors[section];
    displayDialog(color, section);
  }

  void displayDialog(Color color, int tappedSection) {
    final bool isLandscape =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;

    if (isLandscape) {
      _showSlidingDialog(color, tappedSection);
    } else {
      _showBottomSheetDialog(color, tappedSection);
    }
  }

  void _showSlidingDialog(Color color, int tappedSection) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return FoodsScreen(
          color: color,
          tappedSection: tappedSection,
          isPhone: false,
        );
      },
      barrierDismissible: true,
      barrierLabel: 'Cerrar sección',
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation1, animation2, widget) {
        final curvedValue = Curves.easeInOutQuart.transform(animation1.value);
        return Transform.translate(
          offset: Offset(300 * (1 - curvedValue), 0),
          child: widget,
        );
      },
    );
  }

  void _showBottomSheetDialog(Color color, int tappedSection) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      transitionAnimationController: _sheetAnimationController,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadius.xl),
            ),
          ),
          child: FoodsScreen(
            color: color,
            tappedSection: tappedSection,
            isPhone: true,
          ),
        );
      },
    );
  }
}
