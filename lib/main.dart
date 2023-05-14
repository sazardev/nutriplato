import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'foods.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriPlato',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'NutriPlato',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int getTappedSection(Offset tapPosition, double size) {
  double angle =
      math.atan2(tapPosition.dy - size / 2, tapPosition.dx - size / 2);
  if (angle < 0) angle += 2 * math.pi;
  return (angle / (2 * math.pi / 5)).floor();
}

class _MyHomePageState extends State<MyHomePage> {
  int tappedSection = -1;
  bool cardVisible = false;
  Color cardColor = Colors.white;
  final List<Color> sectionColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue
  ];

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Widget card = Visibility(
      visible: cardVisible,
      child: Expanded(
        child: Card(
          color: cardColor,
          child: Center(
            child: Foods(
              position: tappedSection,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: tappedSection > -1
          ? null
          : AppBar(
              title: const Text('NutriPlate'),
            ),
      backgroundColor: Colors.white,
      body: isLandscape
          ? Row(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double size = math.min(
                              constraints.maxWidth, constraints.maxHeight);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTapDown: (details) {
                                  RenderBox box =
                                      context.findRenderObject() as RenderBox;
                                  Offset localPosition =
                                      box.globalToLocal(details.globalPosition);
                                  setState(() {
                                    tappedSection =
                                        getTappedSection(localPosition, size);
                                    cardVisible = true;
                                    cardColor = sectionColors[tappedSection];
                                  });
                                },
                                onPanUpdate: (details) {
                                  RenderBox box =
                                      context.findRenderObject() as RenderBox;
                                  Offset localPosition =
                                      box.globalToLocal(details.globalPosition);
                                  setState(() {
                                    tappedSection =
                                        getTappedSection(localPosition, size);
                                    cardVisible = true;
                                    cardColor = sectionColors[tappedSection];
                                  });
                                },
                                onPanEnd: (details) {
                                  setState(() {
                                    tappedSection = -1;
                                    cardVisible = false;
                                  });
                                },
                                child: Material(
                                  elevation: 4.0,
                                  shape: CircleBorder(),
                                  child: Container(
                                    width: size,
                                    height: size,
                                    child: CustomPaint(
                                      painter: CirclePainter(tappedSection),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                card,
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double size = math.min(
                              constraints.maxWidth, constraints.maxHeight);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTapDown: (details) {
                                  RenderBox box =
                                      context.findRenderObject() as RenderBox;
                                  Offset localPosition =
                                      box.globalToLocal(details.globalPosition);
                                  setState(() {
                                    tappedSection =
                                        getTappedSection(localPosition, size);
                                    cardVisible = true;
                                    cardColor = sectionColors[tappedSection];
                                  });
                                },
                                onPanUpdate: (details) {
                                  RenderBox box =
                                      context.findRenderObject() as RenderBox;
                                  Offset localPosition =
                                      box.globalToLocal(details.globalPosition);
                                  setState(() {
                                    tappedSection =
                                        getTappedSection(localPosition, size);
                                    cardVisible = true;
                                    cardColor = sectionColors[tappedSection];
                                  });
                                },
                                onPanEnd: (details) {
                                  setState(() {
                                    tappedSection = -1;
                                    cardVisible = false;
                                  });
                                },
                                child: Material(
                                  elevation: 4.0,
                                  shape: CircleBorder(),
                                  child: Container(
                                    width: size,
                                    height: size,
                                    child: CustomPaint(
                                      painter: CirclePainter(tappedSection),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                card,
              ],
            ),
    );
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
  final List<IconData> sectionIcons = [
    Icons.fastfood,
    Icons.local_drink,
    Icons.directions_run,
    Icons.local_hospital,
    Icons.sentiment_satisfied_alt
  ];

  CirclePainter(this.tappedSection);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    List<double> radii = List.filled(5, size.width / 2);

    double anglePerSection = (2 * math.pi / radii.length);

    for (int i = 0; i < radii.length; i++) {
      double startAngle = i * anglePerSection;
      double endAngle = startAngle + anglePerSection;

      paint.color =
          (i == tappedSection) ? sectionPressedColors[i] : sectionColors[i];

      if (i == tappedSection) {
        radii[i] *= 1.05; // Aumentar el radio en un 5%
      }

      canvas.drawArc(
          Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2),
              radius: radii[i]),
          startAngle,
          endAngle - startAngle,
          true,
          paint);

      double textAngle = startAngle + (endAngle - startAngle) / 2;
      double x = size.width / 2 + math.cos(textAngle) * (radii[i] / 2);
      double y = size.height / 2 + math.sin(textAngle) * (radii[i] / 2);
      canvas.save();
      canvas.translate(x, y);

      final icon = IconsPainter(
        icon: sectionIcons[i],
        color: Colors.white,
        size: 24.0,
      );

      icon.paint(canvas, Size(icon.size, icon.size));

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class IconsPainter extends CustomPainter {
  final IconData icon;
  final Color color;
  final double size;

  IconsPainter({required this.icon, required this.color, required this.size});

  @override
  void paint(Canvas canvas, Size size) {
    final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
      fontFamily: icon.fontFamily,
      fontSize: this.size,
    ))
      ..pushStyle(ui.TextStyle(color: color))
      ..addText(String.fromCharCode(icon.codePoint));
    final paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: size.width));
    canvas.drawParagraph(
        paragraph, Offset(-paragraph.width / 2, -paragraph.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
