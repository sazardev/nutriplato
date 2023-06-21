import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nutriplato/presentation/plate/widgets/plato_info.dart';
import 'dart:math' as math;

import '../../data/data.dart';
import '../search/widgets/foods.dart';
import 'widgets/circlepainter.dart';

class Plate extends StatefulWidget {
  const Plate({super.key});

  @override
  State<StatefulWidget> createState() => _Plate();
}

class _Plate extends State<Plate> {
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
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Plato del buen comer'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) {
                  return const Plato();
                }));
              },
              icon: const Icon(Icons.info_outline))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(children: [
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
                                        RenderBox box = context
                                            .findRenderObject() as RenderBox;
                                        Offset localPosition =
                                            box.globalToLocal(
                                                details.globalPosition);
                                        tappedSection = getTappedSection(
                                            localPosition,
                                            size,
                                            angles,
                                            constraints);
                                        Color color =
                                            sectionColors[tappedSection];

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
            ]),
          ),
        ],
      ),
    );
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
