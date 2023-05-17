import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class IconsPainter extends CustomPainter {
  final IconData icon;
  final Color color;
  final double size;

  IconsPainter({required this.icon, required this.color, required this.size});

  @override
  void paint(Canvas canvas, Size size) {
    final paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontFamily: icon.fontFamily,
        fontSize: this.size,
      ),
    )
      ..pushStyle(ui.TextStyle(color: color))
      ..addText(String.fromCharCode(icon.codePoint));

    final paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: size.width));
    canvas.drawParagraph(
        paragraph, Offset(-paragraph.width, -paragraph.height));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
