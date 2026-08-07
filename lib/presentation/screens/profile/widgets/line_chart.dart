import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Par de (etiqueta, valor) para graficar.
class ChartPoint {
  final String label;
  final double value;
  const ChartPoint(this.label, this.value);
}

/// Gráfica de línea simple dibujada con CustomPaint.
class LineChart extends StatelessWidget {
  final List<ChartPoint> points;
  final Color lineColor;
  final Color fillColor;

  const LineChart({
    super.key,
    required this.points,
    this.lineColor = Colors.green,
    this.fillColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    if (points.length < 2) {
      return Container(
        height: 180,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Registra al menos 2 mediciones para ver tu progreso',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 24),
        child: CustomPaint(
          size: Size.infinite,
          painter: _LineChartPainter(
            points: points,
            lineColor: lineColor,
            fillColor: fillColor,
          ),
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<ChartPoint> points;
  final Color lineColor;
  final Color fillColor;

  _LineChartPainter({
    required this.points,
    required this.lineColor,
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final minV = points.map((p) => p.value).reduce(math.min);
    final maxV = points.map((p) => p.value).reduce(math.max);
    final range = (maxV - minV) == 0 ? 1.0 : maxV - minV;
    // Agregar 10% de margen arriba y abajo.
    final top = minV - range * 0.15;
    final bottom = maxV + range * 0.15;

    final chartWidth = size.width;
    final chartHeight = size.height - 20;
    double dx(int i) => chartWidth * i / (points.length - 1);
    double dy(double v) =>
        chartHeight - (v - top) / (bottom - top) * chartHeight;

    final linePath = Path();
    for (var i = 0; i < points.length; i++) {
      final x = dx(i);
      final y = dy(points[i].value);
      if (i == 0) {
        linePath.moveTo(x, y);
      } else {
        linePath.lineTo(x, y);
      }
    }

    // Relleno bajo la línea.
    final fillPath = Path.from(linePath)
      ..lineTo(dx(points.length - 1), chartHeight)
      ..lineTo(dx(0), chartHeight)
      ..close();
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            fillColor.withValues(alpha: .25),
            fillColor.withValues(alpha: .02),
          ],
        ).createShader(Rect.fromLTWH(0, 0, chartWidth, chartHeight)),
    );

    // Línea principal.
    canvas.drawPath(
      linePath,
      Paint()
        ..color = lineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Puntos + etiquetas.
    for (var i = 0; i < points.length; i++) {
      final x = dx(i);
      final y = dy(points[i].value);

      canvas.drawCircle(Offset(x, y), 4, Paint()..color = lineColor);
      canvas.drawCircle(
        Offset(x, y),
        4,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );

      // Etiqueta de valor.
      final valueText = TextPainter(
        text: TextSpan(
          text: points[i].value.toStringAsFixed(1),
          style: TextStyle(fontSize: 9, color: Colors.grey.shade700),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final offsetX = (x - valueText.width / 2).clamp(
        0.0,
        chartWidth - valueText.width,
      );
      valueText.paint(canvas, Offset(offsetX, y - 18));

      // Etiqueta de fecha (solo primer y último para no saturar).
      if (i == 0 || i == points.length - 1) {
        final labelText = TextPainter(
          text: TextSpan(
            text: points[i].label,
            style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        final lx = i == 0 ? 0.0 : chartWidth - labelText.width;
        labelText.paint(canvas, Offset(lx, chartHeight + 6));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) =>
      oldDelegate.points != points || oldDelegate.lineColor != lineColor;
}
