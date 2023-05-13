import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tappedSection = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      setState(() {
                        tappedSection =
                            getTappedSection(details.localPosition, size);
                      });
                    },
                    onTapUp: (details) {
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

    for (int i = 0; i < 5; i++) {
      double startAngle = i * (2 * math.pi / 5);
      double endAngle = startAngle + (2 * math.pi / 5);
      paint.color =
          (i == tappedSection) ? sectionPressedColors[i] : sectionColors[i];
      canvas.drawArc(
          Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2),
              radius: size.width / 2),
          startAngle,
          endAngle - startAngle,
          true,
          paint);
    }

    paint
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    for (int i = 0; i < 5; i++) {
      double startAngle = i * (2 * math.pi / 5);

      // Dibujar línea desde el centro hasta el borde del círculo
      double lineAngle = startAngle;
      double x = size.width / 2 +
          math.cos(lineAngle) * (size.width / 2 + paint.strokeWidth / 2);
      double y = size.height / 2 +
          math.sin(lineAngle) * (size.width / 2 + paint.strokeWidth / 2);
      canvas.drawLine(
          Offset(size.width / 2, size.height / 2), Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
