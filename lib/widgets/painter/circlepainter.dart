import 'package:flutter/material.dart';

import '../../data/data.dart';
import 'dart:math' as math;

class CirclePainter extends CustomPainter {
  final List<double> radii;
  final List<double> angles;
  final double lineLength;
  final List<String> categories;

  CirclePainter({
    required this.radii,
    required this.angles,
    required this.categories,
    this.lineLength = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 12;

    for (int i = 0; i < radii.length; i++) {
      double startAngle = angles[i];
      double endAngle = angles[i + 1];

      final paint = Paint()
        ..style = PaintingStyle.fill
        ..shader = SweepGradient(
          colors: [sectionColors[i], sectionColors[i].withAlpha(200)],
          startAngle: startAngle,
          endAngle: endAngle,
        ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: radii[i],
        ));

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: radii[i],
        ),
        startAngle,
        endAngle - startAngle,
        true,
        paint,
      );

      double x1 = size.width / 2 + math.cos(startAngle) * radii[i] * lineLength;
      double y1 =
          size.height / 2 + math.sin(startAngle) * radii[i] * lineLength;
      canvas.drawLine(
          Offset(size.width / 2, size.height / 2), Offset(x1, y1), linePaint);

      double textAngle = startAngle + (endAngle - startAngle) / 2;
      double x2 =
          size.width / 2 + math.cos(textAngle) * (radii[i] + radii[i] * 0.1);
      double y2 =
          size.height / 2 + math.sin(textAngle) * (radii[i] + radii[i] * 0.1);
      canvas.save();
      canvas.translate(x2, y2);

      if (i == 0) {
        canvas.rotate(textAngle + math.pi * 4 / 2.72);
      } else if (i == 1) {
        canvas.rotate(textAngle + math.pi * 4 / 2.65);
      } else if (i == 2) {
        canvas.rotate(textAngle + math.pi * 4 / 2.65);
      } else {
        canvas.rotate(textAngle + math.pi / 2);
      }

      TextPainter textPainter = TextPainter(
          text: TextSpan(
              text: categories[i],
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          textDirection: TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));

      canvas.restore();
    }

    // Draw line for last angle
    double x1 =
        size.width / 2 + math.cos(angles.last) * radii.last * lineLength;
    double y1 =
        size.height / 2 + math.sin(angles.last) * radii.last * lineLength;
    canvas.drawLine(
        Offset(size.width / 2, size.height / 2), Offset(x1, y1), linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
