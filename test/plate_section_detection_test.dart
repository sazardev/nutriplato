import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:nutriplato/presentation/screens/plate/plate_screen.dart';

void main() {
  // Ángulos reales del plato (en radianes), mismos que pinta CirclePainter.
  final List<double> angles = [0, 0.44 * pi, 0.74 * pi, 0.9 * pi, pi, 2 * pi];
  const double size = 400;
  final Offset center = const Offset(size / 2, size / 2);

  /// Punto dentro del plato con el ángulo dado (a radio fijo).
  Offset pointAt(double angle, [double radius = 100]) {
    return center + Offset(cos(angle) * radius, sin(angle) * radius);
  }

  group('detectPlateSection', () {
    test('toca el centro de cada sección', () {
      // Cereales: 0° a 0.44π
      expect(detectPlateSection(pointAt(0.2 * pi), size, angles), 0);
      // Leguminosas: 0.44π a 0.74π
      expect(detectPlateSection(pointAt(0.59 * pi), size, angles), 1);
      // Animal: 0.74π a 0.9π
      expect(detectPlateSection(pointAt(0.82 * pi), size, angles), 2);
      // Grasas: 0.9π a π
      expect(detectPlateSection(pointAt(0.95 * pi), size, angles), 3);
      // Verduras & Frutas: π a 2π
      expect(detectPlateSection(pointAt(1.5 * pi), size, angles), 4);
      expect(detectPlateSection(pointAt(1.9 * pi), size, angles), 4);
    });

    test('el ángulo 0 (3 en punto) pertenece a Cereales', () {
      expect(
        detectPlateSection(center + const Offset(100, 0), size, angles),
        0,
      );
    });

    test('el punto más alto del plato es Verduras & Frutas', () {
      // 270° en pantalla = arriba.
      expect(
        detectPlateSection(center + const Offset(0, -100), size, angles),
        4,
      );
    });

    test('el ángulo π (9 en punto) inicia Verduras & Frutas', () {
      expect(
        detectPlateSection(center + const Offset(-100, 0), size, angles),
        4,
      );
    });

    test('un toque fuera del círculo devuelve null', () {
      expect(
        detectPlateSection(center + const Offset(0, 300), size, angles),
        isNull,
      );
      expect(detectPlateSection(const Offset(5, 5), size, angles), isNull);
    });

    test('el centro se resuelve a una sección válida', () {
      final section = detectPlateSection(center, size, angles);
      expect(section, isNotNull);
      expect(section, inInclusiveRange(0, 4));
    });

    test('es robusto ante ángulos inválidos o tamaño cero', () {
      expect(detectPlateSection(center, 0, angles), isNull);
      expect(detectPlateSection(center, size, const []), isNull);
    });
  });
}
