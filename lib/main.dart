import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tappedSection = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double size =
                  math.min(constraints.maxWidth, constraints.maxHeight);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
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
                      setState(() {
                        tappedSection = getTappedSection(localPosition, size);
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        tappedSection = -1;
                      });
                    },
                    child: CustomPaint(
                      size: Size(size, size),
                      painter: CirclePainter(tappedSection),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  int getTappedSection(Offset tapPosition, double size) {
    double angle =
        math.atan2(tapPosition.dy - size / 2, tapPosition.dx - size / 2);
    if (angle < 0) angle += 2 * math.pi;
    return (angle / (2 * math.pi / 5)).floor();
  }
}

class CirclePainter extends CustomPainter {
  final int tappedSection;
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

  CirclePainter(this.tappedSection);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Lista para almacenar los radios de cada sección
    List<double> radii = List.filled(5, size.width / 2);

    // Calculate the angles for each section
    double anglePerSection = (2 * math.pi / 5);
    double angleForFirstSection = anglePerSection * 1.2;
    double angleForOtherSections =
        (2 * math.pi - angleForFirstSection) / (radii.length - 1);

    for (int i = 0; i < radii.length; i++) {
      double startAngle;
      double endAngle;

      if (i == 0) {
        startAngle = 0;
        endAngle = startAngle + angleForFirstSection;
      } else {
        startAngle = angleForFirstSection + (i - 1) * angleForOtherSections;
        endAngle = startAngle + angleForOtherSections;
      }

      paint.color =
          (i == tappedSection) ? sectionPressedColors[i] : sectionColors[i];

      // Aumentar el radio para la sección que se ha hecho clic
      if (i == tappedSection) {
        radii[i] *= 1.05; // Aumentar el radio en un 10%
      }

      canvas.drawArc(
          Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2),
              radius: radii[i]),
          startAngle,
          endAngle - startAngle,
          true,
          paint);

      // Agregar texto con el número de la división
      final textSpan = TextSpan(
        text: '$i',
        style: TextStyle(color: Colors.white, fontSize: 24),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      double textAngle = startAngle + (endAngle - startAngle) / 2;
      double x = size.width / 2 + math.cos(textAngle) * (radii[i] / 2);
      double y = size.height / 2 + math.sin(textAngle) * (radii[i] / 2);
      textPainter.paint(canvas,
          Offset(x - textPainter.width / 2, y - textPainter.height / 2));
    }

    // Remove the code that draws the white divider lines
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
