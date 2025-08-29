import 'package:flutter/material.dart';
import '../../../../data/data.dart';
import 'dart:math' as math;

class CirclePainter extends CustomPainter {
  final List<double> radii;
  final List<double> angles;
  final double lineLength;
  final List<String> categories;
  final int? highlightedSection;
  final double highlightAnimation;

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
        radius *= 1.0 + (0.05 * highlightAnimation);
      }

      // Mejoramos la apariencia con un degradado suave
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..shader = SweepGradient(
          colors: [
            sectionColors[i],
            sectionColors[i].withAlpha(230),
            sectionColors[i].withAlpha(210),
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
        ..strokeWidth = 1.5
        ..color = Colors.white.withValues(alpha: .6);

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
      ..color = Colors.white.withValues(alpha: .45)
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5);

    // Línea principal más definida
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < angles.length; i++) {
      double angle = angles[i];

      // Ajuste para que las líneas sean proporcionales al radio de cada sección
      double maxRadius;
      if (i < radii.length) {
        maxRadius = radii[i] * lineLength;
      } else if (i == angles.length - 1) {
        maxRadius = radii[0] *
            lineLength; // La última línea usa el radio del primer sector
      } else {
        maxRadius = radii[i - 1] * lineLength; // Fallback
      }

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

      // Ajustamos la posición del texto según el tamaño de la sección
      double sectionSize = endAngle - startAngle;
      double labelOffset;

      // Para secciones pequeñas (grasas y animal), alejamos un poco más el texto
      if (sectionSize < 0.3) {
        labelOffset = 0.18; // Más lejos del borde
      } else if (sectionSize > 0.9) {
        // Para la sección grande de Verduras & Frutas
        labelOffset = 0.12; // Más cercano al borde ya que hay espacio
      } else {
        labelOffset = 0.14; // Distancia estándar
      }

      double x = center.dx + math.cos(textAngle) * (radius * (1 + labelOffset));
      double y = center.dy + math.sin(textAngle) * (radius * (1 + labelOffset));

      canvas.save();
      canvas.translate(x, y);

      // Ajustamos la rotación del texto para mejor legibilidad
      double rotationAngle;
      if (textAngle > math.pi * 0.5 && textAngle < math.pi * 1.5) {
        // Para textos en la parte izquierda del círculo
        rotationAngle = textAngle + math.pi / 2;
      } else {
        // Para textos en la parte derecha del círculo
        rotationAngle = textAngle - math.pi / 2;
      }

      canvas.rotate(rotationAngle);

      // Mejoramos el estilo del texto
      final bool isHighlighted = highlightedSection == i;

      // Ajustamos el tamaño de la fuente según el tamaño de la sección
      double fontSize;
      if (sectionSize < 0.3) {
        fontSize = 13.0; // Secciones pequeñas
      } else if (sectionSize > 0.9) {
        fontSize = 15.0; // Sección grande (Verduras & Frutas)
      } else {
        fontSize = 14.0; // Tamaño estándar
      }

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: categories[i],
          style: TextStyle(
            color: isHighlighted
                ? Colors.black
                : Colors.black.withValues(alpha: .9),
            fontSize: isHighlighted ? fontSize + 0.5 : fontSize,
            fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w600,
            shadows: [
              Shadow(
                offset: const Offset(0.5, 0.5),
                blurRadius: 2.0,
                color: Colors.white.withValues(alpha: .9),
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
