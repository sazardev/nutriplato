import 'package:flutter/material.dart';
import '../../../../data/data.dart';
import 'dart:math' as math;

class CirclePainter extends CustomPainter {
  final List<double> radii;
  final List<double> angles;
  final double lineLength;
  final List<String> categories;
  final int? highlightedSection;
  final double highlightAnimation; // Para animación de destacado

  CirclePainter({
    required this.radii,
    required this.angles,
    required this.categories,
    this.lineLength = 1.0,
    this.highlightedSection,
    this.highlightAnimation = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Dibujamos primero los sectores
    _drawSectors(canvas, size, center);

    // Luego dibujamos las líneas divisorias
    _drawDividers(canvas, size, center);

    // Finalmente dibujamos las etiquetas de texto
    _drawCategoryLabels(canvas, size, center);
  }

  void _drawSectors(Canvas canvas, Size size, Offset center) {
    for (int i = 0; i < radii.length; i++) {
      double startAngle = angles[i];
      double endAngle = angles[i + 1];
      double radius = radii[i];

      // Si esta sección está resaltada, aumentamos con animación suave
      if (highlightedSection == i) {
        radius *= 1.0 + (0.03 * highlightAnimation);
      }

      final paint = Paint()
        ..style = PaintingStyle.fill
        ..shader = SweepGradient(
          colors: [
            sectionColors[i],
            sectionColors[i].withAlpha(220),
            sectionColors[i].withAlpha(200),
          ],
          startAngle: startAngle,
          endAngle: endAngle,
          tileMode: TileMode.clamp,
        ).createShader(Rect.fromCircle(
          center: center,
          radius: radius,
        ));

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
        true,
        paint,
      );

      // Borde mejorado para separar secciones
      final borderPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = Colors.white.withOpacity(0.5);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
        borderPaint,
      );
    }
  }

  void _drawDividers(Canvas canvas, Size size, Offset center) {
    // Efecto de brillo sutil para las líneas
    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

    // Línea principal más definida
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < angles.length; i++) {
      double angle = angles[i];
      double maxRadius = radii[math.min(i, radii.length - 1)] * lineLength;

      double x = center.dx + math.cos(angle) * maxRadius;
      double y = center.dy + math.sin(angle) * maxRadius;

      // Primero dibujamos el efecto de brillo
      canvas.drawLine(center, Offset(x, y), glowPaint);

      // Luego dibujamos la línea principal encima
      canvas.drawLine(center, Offset(x, y), linePaint);
    }
  }

  void _drawCategoryLabels(Canvas canvas, Size size, Offset center) {
    for (int i = 0; i < radii.length; i++) {
      double startAngle = angles[i];
      double endAngle = angles[i + 1];
      double radius = radii[i];

      // Calculamos ángulo medio para posicionar el texto
      double textAngle = startAngle + (endAngle - startAngle) / 2;

      // Posicionamos el texto con mejor separación del borde
      double labelOffset = 0.14;
      double x =
          center.dx + math.cos(textAngle) * (radius + radius * labelOffset);
      double y =
          center.dy + math.sin(textAngle) * (radius + radius * labelOffset);

      canvas.save();
      canvas.translate(x, y);

      // Mantenemos la lógica original de rotación
      double rotationAngle;

      if (textAngle >= 0 && textAngle < math.pi / 2) {
        // Primer cuadrante
        rotationAngle = textAngle + math.pi / 2;
      } else if (textAngle >= math.pi / 2 && textAngle < math.pi) {
        // Segundo cuadrante
        rotationAngle = textAngle + math.pi / 2;
      } else if (textAngle >= math.pi && textAngle < 3 * math.pi / 2) {
        // Tercer cuadrante
        rotationAngle = textAngle - math.pi / 2;
      } else {
        // Cuarto cuadrante
        rotationAngle = textAngle - math.pi / 2;
      }

      canvas.rotate(rotationAngle);

      // Mejoramos el estilo del texto, destacando la sección seleccionada
      final bool isHighlighted = highlightedSection == i;

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: categories[i],
          style: TextStyle(
            color: isHighlighted ? Colors.black : Colors.black.withOpacity(0.9),
            fontSize: isHighlighted ? 14.5 : 14.0,
            fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w600,
            shadows: [
              Shadow(
                offset: const Offset(0.5, 0.5),
                blurRadius: 1.5,
                color: Colors.white.withOpacity(0.9),
              )
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
          canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is CirclePainter) {
      return oldDelegate.highlightedSection != highlightedSection ||
          oldDelegate.highlightAnimation != highlightAnimation;
    }
    return true;
  }
}
