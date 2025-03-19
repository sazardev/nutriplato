import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nutriplato/presentation/screens/plate/widgets/plato_info_screen.dart';

import '../../../data/data.dart';
import '../food/foods.screen.dart';
import 'widgets/circlepainter.dart';

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
    2 * pi // Fin de verduras & frutas / Cierre del círculo
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

  // Determina qué sección del plato fue tocada
  int? getTappedSection(
      Offset tapPosition, double size, BoxConstraints constraints) {
    final double centerX = constraints.maxWidth / 2;
    final double centerY = constraints.maxHeight / 2;

    // Calcula la distancia desde el centro
    final double distance = sqrt(
        pow(tapPosition.dx - centerX, 2) + pow(tapPosition.dy - centerY, 2));

    // Verifica si el toque está dentro del círculo
    if (distance > size / 2) {
      return null;
    }

    // Calcula el ángulo del toque
    double angle = atan2(tapPosition.dy - centerY, tapPosition.dx - centerX);
    if (angle < 0) angle += 2 * pi;

    // Determina la sección basada en el ángulo
    for (int i = 0; i < angles.length - 1; i++) {
      if (angle >= angles[i] && angle < angles[i + 1]) {
        return i;
      }
    }

    return null;
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
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Plato del buen comer'),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const PlatoInformationScreen())),
              icon: const Icon(Icons.info_outline))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildPlateContent(),
        ),
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
          size / 2 - 43, // Leguminosas (15%)
          size / 2 - 40, // Animal (8%)
          size / 2 - 38, // Grasas (5%)
          size / 2 - 50, // Verduras & Frutas (50%)
        ];

        return GestureDetector(
          onTapDown: (details) => _handleTapDown(details, size, constraints),
          child: AnimatedBuilder(
            animation: _highlightAnimationController,
            builder: (context, child) {
              return Material(
                elevation: 8,
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
        );
      },
    );
  }

  void _handleTapDown(
      TapDownDetails details, double size, BoxConstraints constraints) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset localPosition = box.globalToLocal(details.globalPosition);

    final tappedSection = getTappedSection(localPosition, size, constraints);

    if (tappedSection != null) {
      _highlightSection(tappedSection);
      Color color = sectionColors[tappedSection];
      displayDialog(color, tappedSection);
    }
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
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (context, animation1, animation2, widget) {
          final curvedValue = Curves.easeInOutQuart.transform(animation1.value);
          return Transform.translate(
              offset: Offset(300 * (1 - curvedValue), 0), child: widget);
        });
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
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: FoodsScreen(
              color: color,
              tappedSection: tappedSection,
              isPhone: true,
            ),
          );
        });
  }
}
