import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'data.dart';
import 'foods.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tappedSection = -1;
  List<double> angles = [
    0,
    math.pi / 2,
    math.pi * 3 / 4,
    math.pi,
    math.pi + math.pi / 2,
    math.pi * 2
  ];

  int getTappedSection(Offset tapPosition, double size, List<double> angles,
      BoxConstraints constraints) {
    if (constraints.maxHeight > constraints.maxWidth) {
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;

      double x = tapPosition.dx;
      double y = tapPosition.dy;

      double centerX = width / 2;
      double centerY = height / 2;

      double angle = atan2(y - centerY, x - centerX);

      if (angle < 0) {
        angle += 2 * pi;
      }

      if (angle >= 0 && angle < pi / 2) {
        return 0;
      } else if (angle >= pi / 2 && angle < (3 * pi) / 4) {
        return 1;
      } else if (angle >= (3 * pi) / 4 && angle < pi) {
        return 2;
      } else if (angle >= pi && angle < (3 * pi) / 2) {
        return 3;
      } else {
        return 4;
      }
    }

    double angle =
        math.atan2(tapPosition.dy - size / 2, tapPosition.dx - size / 2);
    if (angle < 0) angle += 2 * math.pi;

    for (int i = 0; i < angles.length - 1; i++) {
      if (angle >= angles[i] && angle < angles[i + 1]) {
        return i;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('NutriPlato')),
        body: Row(children: [
          Expanded(
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: LayoutBuilder(builder: (context, constraints) {
                        double size = math.min(
                            constraints.maxWidth, constraints.maxHeight);
                        List<double> radii = [
                          size / 2 - 50,
                          size / 2 - 50,
                          size / 2 - 45,
                          size / 2 - 40,
                          size / 2 - 40,
                        ];

                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                  onTapDown: (details) {
                                    RenderBox box =
                                        context.findRenderObject() as RenderBox;
                                    Offset localPosition = box
                                        .globalToLocal(details.globalPosition);
                                    tappedSection = getTappedSection(
                                        localPosition,
                                        size,
                                        angles,
                                        constraints);
                                    Color color = sectionColors[tappedSection];

                                    displayDialog(color);
                                  },
                                  onPanEnd: (details) {
                                    setState(() {
                                      tappedSection = -1;
                                    });
                                  },
                                  child: Material(
                                      elevation: 100,
                                      shape: const CircleBorder(),
                                      child: SizedBox(
                                          width: size,
                                          height: size,
                                          child: CustomPaint(
                                              painter: CirclePainter(
                                                  radii: radii,
                                                  angles: angles,
                                                  lineLength: 1.1,
                                                  categories:
                                                      shortCategories)))))
                            ]);
                      }))))
        ]));
  }

  void displayDialog(Color color) {
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      showGeneralDialog(
          context: context,
          pageBuilder: (context, animation1, animation2) {
            return Foods(
              color: color,
              tappedSection: tappedSection,
              isPhone: false,
            );
          },
          barrierDismissible: true,
          barrierLabel: '',
          transitionDuration: const Duration(milliseconds: 300),
          transitionBuilder: (context, animation1, animation2, widget) {
            final curvedValue = Curves.easeInOut.transform(animation1.value);
            return Transform.translate(
                offset: Offset(300 * (1 - curvedValue), 0), child: widget);
          });
    } else {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Foods(
                color: color,
                tappedSection: tappedSection,
                isPhone: true,
              ),
            );
          });
    }
  }
}

class CirclePainter extends CustomPainter {
  final List<double> radii;
  final List<double> angles;
  final double lineLength;
  final List<String> categories;

  CirclePainter(
      {required this.radii,
      required this.angles,
      required this.categories,
      this.lineLength = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 12;

    for (int i = 0; i < radii.length; i++) {
      double startAngle = angles[i];
      double endAngle = angles[i + 1];

      paint.color = sectionColors[i];
      canvas.drawArc(
          Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: radii[i],
          ),
          startAngle,
          endAngle - startAngle,
          true,
          paint);

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
