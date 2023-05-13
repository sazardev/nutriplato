import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriPlato',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'NutriPlato'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tappedSection = -1;
  Offset circlePosition = Offset.zero;
  bool isDragging = false;
  double outerCircleRotation = 0;
  Offset? lastDragPosition;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double size =
                    math.min(constraints.maxWidth, constraints.maxHeight);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onPanStart: (details) {
                        lastDragPosition = null;
                      },
                      onTapDown: (details) {
                        RenderBox box = context.findRenderObject() as RenderBox;
                        Offset localPosition =
                            box.globalToLocal(details.globalPosition);
                        setState(() {
                          tappedSection = getTappedSection(localPosition, size);
                        });
                      },
                      onPanUpdate: (details) {
                        RenderBox box = context.findRenderObject() as RenderBox;
                        Offset localPosition =
                            box.globalToLocal(details.globalPosition);
                        if (lastDragPosition != null) {
                          double angleDelta = math.atan2(
                                  localPosition.dy - context.size!.height / 2,
                                  localPosition.dx - context.size!.width / 2) -
                              math.atan2(
                                  lastDragPosition!.dy -
                                      context.size!.height / 2,
                                  lastDragPosition!.dx -
                                      context.size!.width / 2);
                          setState(() {
                            outerCircleRotation += angleDelta;
                            // Normaliza el ángulo de rotación para mantenerlo dentro del rango de 0 a 2π
                            while (outerCircleRotation < 0) {
                              outerCircleRotation += 2 * math.pi;
                            }
                            while (outerCircleRotation >= 2 * math.pi) {
                              outerCircleRotation -= 2 * math.pi;
                            }
                          });
                        }
                        lastDragPosition = localPosition;
                      },
                      onPanEnd: (details) {
                        setState(() {
                          tappedSection = -1;
                          lastDragPosition = null;
                        });
                      },
                      child: CustomPaint(
                        size: Size(size, size),
                        painter:
                            CirclePainter(tappedSection, outerCircleRotation),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  int getTappedSection(Offset tapPosition, double size) {
    double angle =
        math.atan2(tapPosition.dy - size / 2, tapPosition.dx - size / 2);
    angle -= outerCircleRotation; // Resta el ángulo de rotación actual
    if (angle < 0) angle += 2 * math.pi;
    return (angle / (2 * math.pi / 5)).floor();
  }
}

class CirclePainter extends CustomPainter {
  final int tappedSection;
  final double outerCircleRotation;
  final List<Color> sectionColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue
  ];
  final List<Color> sectionPressedColors = [
    Colors.pink,
    Colors.deepOrange,
    Colors.amber,
    Colors.lightGreen,
    Colors.lightBlue
  ];

  CirclePainter(this.tappedSection, this.outerCircleRotation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Lista para almacenar los radios de cada sección
    List<double> radii = List.filled(5, size.width / 2);

    // Calculate the angles for each section
    double anglePerSection = (2 * math.pi / radii.length);

    // List of labels for each section
    List<String> labels = [
      "Leguminosas",
      "Origen animal",
      "Cereales",
      "Frutas",
      "Verduras",
    ];

    // Aplica la transformación de rotación a todo el canvas
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(outerCircleRotation);

    for (int i = 0; i < radii.length; i++) {
      double startAngle = i * anglePerSection;
      double endAngle = startAngle + anglePerSection;

      paint.color =
          (i == tappedSection) ? sectionPressedColors[i] : sectionColors[i];

      // Aumentar el radio para la sección que se ha hecho clic
      if (i == tappedSection) {
        radii[i] *= 1.05; // Aumentar el radio en un 5%
      }

      canvas.drawArc(Rect.fromCircle(center: Offset.zero, radius: radii[i]),
          startAngle, endAngle - startAngle, true, paint);

      // Add the code to draw the outer circle here
      final outerCirclePaint = Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.black
        ..strokeWidth = 8.0;

      // Decrease the radius of the outer circle to increase the distance between the circles
      double outerCircleRadius = math.min(size.width, size.height) / 2 -
          outerCirclePaint.strokeWidth / 2 +
          60; // Decrease by 20 pixels

      // Draw an arc on the outer circle with the same color as the inner circle arc
      canvas.drawArc(
          Rect.fromCircle(center: Offset.zero, radius: outerCircleRadius),
          startAngle,
          endAngle - startAngle,
          false,
          Paint()
            ..style = PaintingStyle.stroke
            ..color = paint.color
            ..strokeWidth = outerCirclePaint.strokeWidth);

      // Agregar texto con el número de la división
      double fontSize =
          size.width * 0.04; // Ajusta el factor de escala según sea necesario
      final textSpan = TextSpan(
        text: labels[i],
        style: TextStyle(color: Colors.black, fontSize: fontSize),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      double textAngle = startAngle + (endAngle - startAngle) / 2;
      double radius = radii[i] + textPainter.height;
      double x = math.cos(textAngle) * radius;
      double y = math.sin(textAngle) * radius;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(textAngle + math.pi / 2);
      textPainter.paint(
          canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }

    // Restaura el canvas para eliminar la transformación de rotación
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
