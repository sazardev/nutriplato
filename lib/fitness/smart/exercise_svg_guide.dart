import 'package:flutter/material.dart';
import 'smart_exercise.model.dart';

/// Widget SVG flat que representa al cuerpo humano en distintas posiciones
/// con la animación de los músculos activos resaltados
class ExerciseSvgGuide extends StatelessWidget {
  final BodyPosition position;
  final List<MuscleGroup> activeMuscles;
  final double size;
  final Color primaryColor;
  final bool showLabel;

  const ExerciseSvgGuide({
    super.key,
    required this.position,
    required this.activeMuscles,
    this.size = 200,
    this.primaryColor = const Color(0xFF6C63FF),
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _BodyPainter(
              position: position,
              activeMuscles: activeMuscles,
              primaryColor: primaryColor,
            ),
          ),
        ),
        if (showLabel) ...[
          const SizedBox(height: 8),
          Text(
            _positionLabel(position),
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  static String _positionLabel(BodyPosition pos) {
    switch (pos) {
      case BodyPosition.standing:
        return 'De pie';
      case BodyPosition.lying:
        return 'Acostado';
      case BodyPosition.sitting:
        return 'Sentado';
      case BodyPosition.kneeling:
        return 'Arrodillado';
      case BodyPosition.plank:
        return 'Plancha';
    }
  }
}

class _BodyPainter extends CustomPainter {
  final BodyPosition position;
  final List<MuscleGroup> activeMuscles;
  final Color primaryColor;

  _BodyPainter({
    required this.position,
    required this.activeMuscles,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    switch (position) {
      case BodyPosition.standing:
        _drawStanding(canvas, size);
        break;
      case BodyPosition.lying:
        _drawLying(canvas, size);
        break;
      case BodyPosition.sitting:
        _drawSitting(canvas, size);
        break;
      case BodyPosition.kneeling:
        _drawKneeling(canvas, size);
        break;
      case BodyPosition.plank:
        _drawPlank(canvas, size);
        break;
    }
  }

  // ── Colores ─────────────────────────────────────────────────────────────
  Color get _bodyColor => const Color(0xFFE8D5C4);
  Color get _activeColor => primaryColor;
  Color get _outlineColor => const Color(0xFF8B6F6F);
  Color get _inactiveColor => const Color(0xFFD4B896);

  Paint _bodyPaint() => Paint()
    ..color = _bodyColor
    ..style = PaintingStyle.fill;

  Paint _activePaint() => Paint()
    ..color = _activeColor.withValues(alpha: 0.85)
    ..style = PaintingStyle.fill;

  Paint _outlinePaint() => Paint()
    ..color = _outlineColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5
    ..strokeCap = StrokeCap.round;

  bool _isActive(MuscleGroup group) =>
      activeMuscles.contains(group) ||
      activeMuscles.contains(MuscleGroup.cuerpoCompleto);

  // ── STANDING ────────────────────────────────────────────────────────────
  void _drawStanding(Canvas canvas, Size s) {
    final cx = s.width / 2;
    final sc = s.height / 220;

    // Cabeza
    canvas.drawCircle(Offset(cx, 18 * sc), 14 * sc, _bodyPaint());
    canvas.drawCircle(Offset(cx, 18 * sc), 14 * sc, _outlinePaint());
    // Cara — puntos mínimos
    canvas.drawCircle(
        Offset(cx - 4 * sc, 16 * sc), 1.5 * sc, Paint()..color = _outlineColor);
    canvas.drawCircle(
        Offset(cx + 4 * sc, 16 * sc), 1.5 * sc, Paint()..color = _outlineColor);

    // Cuello
    final neckR = Rect.fromCenter(
        center: Offset(cx, 35 * sc), width: 10 * sc, height: 12 * sc);
    canvas.drawOval(neckR, _bodyPaint());

    // Torso
    final torso = RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(cx, 68 * sc), width: 46 * sc, height: 52 * sc),
        const Radius.circular(8));
    final torsoP = _isActive(MuscleGroup.pecho) ||
            _isActive(MuscleGroup.espalda) ||
            _isActive(MuscleGroup.hombros)
        ? _activePaint()
        : _bodyPaint();
    canvas.drawRRect(torso, torsoP);
    canvas.drawRRect(torso, _outlinePaint());

    // Abdomen
    final abdo = RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(cx, 106 * sc), width: 40 * sc, height: 28 * sc),
        const Radius.circular(6));
    final abdoP =
        _isActive(MuscleGroup.abdomen) ? _activePaint() : _bodyPaint();
    canvas.drawRRect(abdo, abdoP);
    canvas.drawRRect(abdo, _outlinePaint());

    // Hombro izquierdo
    canvas.drawCircle(Offset(cx - 27 * sc, 52 * sc), 9 * sc,
        _isActive(MuscleGroup.hombros) ? _activePaint() : _bodyPaint());
    canvas.drawCircle(Offset(cx - 27 * sc, 52 * sc), 9 * sc, _outlinePaint());

    // Hombro derecho
    canvas.drawCircle(Offset(cx + 27 * sc, 52 * sc), 9 * sc,
        _isActive(MuscleGroup.hombros) ? _activePaint() : _bodyPaint());
    canvas.drawCircle(Offset(cx + 27 * sc, 52 * sc), 9 * sc, _outlinePaint());

    // Brazo izquierdo (biceps)
    final leftArm = RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 42 * sc, 56 * sc, 14 * sc, 42 * sc),
        const Radius.circular(6));
    final armLP =
        _isActive(MuscleGroup.biceps) || _isActive(MuscleGroup.triceps)
            ? _activePaint()
            : _bodyPaint();
    canvas.drawRRect(leftArm, armLP);
    canvas.drawRRect(leftArm, _outlinePaint());

    // Brazo derecho
    final rightArm = RRect.fromRectAndRadius(
        Rect.fromLTWH(cx + 28 * sc, 56 * sc, 14 * sc, 42 * sc),
        const Radius.circular(6));
    canvas.drawRRect(rightArm, armLP);
    canvas.drawRRect(rightArm, _outlinePaint());

    // Antebrazo izquierdo
    final leftFore = RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 41 * sc, 100 * sc, 12 * sc, 34 * sc),
        const Radius.circular(5));
    canvas.drawRRect(leftFore, _bodyPaint());
    canvas.drawRRect(leftFore, _outlinePaint());

    // Antebrazo derecho
    final rightFore = RRect.fromRectAndRadius(
        Rect.fromLTWH(cx + 29 * sc, 100 * sc, 12 * sc, 34 * sc),
        const Radius.circular(5));
    canvas.drawRRect(rightFore, _bodyPaint());
    canvas.drawRRect(rightFore, _outlinePaint());

    // Glúteos / cadera
    final hip = RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(cx, 132 * sc), width: 44 * sc, height: 20 * sc),
        const Radius.circular(6));
    final hipP = _isActive(MuscleGroup.gluteos) ? _activePaint() : _bodyPaint();
    canvas.drawRRect(hip, hipP);
    canvas.drawRRect(hip, _outlinePaint());

    // Cuádriceps izquierdo
    final leftQuad = RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 22 * sc, 142 * sc, 18 * sc, 44 * sc),
        const Radius.circular(7));
    final quadP = _isActive(MuscleGroup.cuadriceps) ||
            _isActive(MuscleGroup.isquiotibiales)
        ? _activePaint()
        : _bodyPaint();
    canvas.drawRRect(leftQuad, quadP);
    canvas.drawRRect(leftQuad, _outlinePaint());

    // Cuádriceps derecho
    final rightQuad = RRect.fromRectAndRadius(
        Rect.fromLTWH(cx + 4 * sc, 142 * sc, 18 * sc, 44 * sc),
        const Radius.circular(7));
    canvas.drawRRect(rightQuad, quadP);
    canvas.drawRRect(rightQuad, _outlinePaint());

    // Pantorrilla izquierda
    final leftCalf = RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 20 * sc, 188 * sc, 15 * sc, 26 * sc),
        const Radius.circular(6));
    final calfP =
        _isActive(MuscleGroup.pantorrillas) ? _activePaint() : _bodyPaint();
    canvas.drawRRect(leftCalf, calfP);
    canvas.drawRRect(leftCalf, _outlinePaint());

    // Pantorrilla derecha
    final rightCalf = RRect.fromRectAndRadius(
        Rect.fromLTWH(cx + 5 * sc, 188 * sc, 15 * sc, 26 * sc),
        const Radius.circular(6));
    canvas.drawRRect(rightCalf, calfP);
    canvas.drawRRect(rightCalf, _outlinePaint());
  }

  // ── LYING ────────────────────────────────────────────────────────────────
  void _drawLying(Canvas canvas, Size s) {
    final cy = s.height / 2;
    final p = Paint()
      ..color = _bodyColor
      ..style = PaintingStyle.fill;

    // Cabeza
    canvas.drawCircle(Offset(16, cy), 13, p);
    canvas.drawCircle(Offset(16, cy), 13, _outlinePaint());

    // Torso
    final torsoP = _isActive(MuscleGroup.pecho) ||
            _isActive(MuscleGroup.abdomen) ||
            _isActive(MuscleGroup.espalda)
        ? _activePaint()
        : p;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(30, cy - 14, 80, 28), const Radius.circular(8)),
        torsoP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(30, cy - 14, 80, 28), const Radius.circular(8)),
        _outlinePaint());

    // Glúteos
    final hipP = _isActive(MuscleGroup.gluteos) ? _activePaint() : p;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(110, cy - 14, 24, 28), const Radius.circular(6)),
        hipP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(110, cy - 14, 24, 28), const Radius.circular(6)),
        _outlinePaint());

    // Muslos
    final quadP = _isActive(MuscleGroup.cuadriceps) ||
            _isActive(MuscleGroup.isquiotibiales)
        ? _activePaint()
        : p;
    // muslo arriba
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(134, cy - 22, 50, 20), const Radius.circular(6)),
        quadP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(134, cy - 22, 50, 20), const Radius.circular(6)),
        _outlinePaint());
    // muslo abajo
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(134, cy + 2, 50, 20), const Radius.circular(6)),
        quadP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(134, cy + 2, 50, 20), const Radius.circular(6)),
        _outlinePaint());

    // Rodillas
    canvas.drawCircle(Offset(187, cy - 12), 7, p);
    canvas.drawCircle(Offset(187, cy - 12), 7, _outlinePaint());
    canvas.drawCircle(Offset(187, cy + 12), 7, p);
    canvas.drawCircle(Offset(187, cy + 12), 7, _outlinePaint());

    // Pantorrillas
    final calfP = _isActive(MuscleGroup.pantorrillas) ? _activePaint() : p;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(194, cy - 20, 36, 16), const Radius.circular(5)),
        calfP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(194, cy - 20, 36, 16), const Radius.circular(5)),
        _outlinePaint());
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(194, cy + 4, 36, 16), const Radius.circular(5)),
        calfP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(194, cy + 4, 36, 16), const Radius.circular(5)),
        _outlinePaint());
  }

  // ── SITTING ──────────────────────────────────────────────────────────────
  void _drawSitting(Canvas canvas, Size s) {
    final cx = s.width / 2;
    final baseLine = s.height * 0.85;
    final p = Paint()
      ..color = _bodyColor
      ..style = PaintingStyle.fill;

    // Cabeza
    canvas.drawCircle(Offset(cx, baseLine - 170), 16, p);
    canvas.drawCircle(Offset(cx, baseLine - 170), 16, _outlinePaint());

    // Torso
    final torsoP = _isActive(MuscleGroup.pecho) ? _activePaint() : p;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx, baseLine - 115), width: 50, height: 60),
            const Radius.circular(8)),
        torsoP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx, baseLine - 115), width: 50, height: 60),
            const Radius.circular(8)),
        _outlinePaint());

    // Cadera (horizontal)
    final hipP = _isActive(MuscleGroup.gluteos) ? _activePaint() : p;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx, baseLine - 72), width: 58, height: 22),
            const Radius.circular(6)),
        hipP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx, baseLine - 72), width: 58, height: 22),
            const Radius.circular(6)),
        _outlinePaint());

    // Muslos (horizontales)
    final quadP = _isActive(MuscleGroup.cuadriceps) ? _activePaint() : p;
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cx - 54, baseLine - 65, 46, 18),
            const Radius.circular(6)),
        quadP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cx + 8, baseLine - 65, 46, 18),
            const Radius.circular(6)),
        _outlinePaint());
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cx + 8, baseLine - 65, 46, 18),
            const Radius.circular(6)),
        quadP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cx + 8, baseLine - 65, 46, 18),
            const Radius.circular(6)),
        _outlinePaint());

    // Rodillas
    canvas.drawCircle(Offset(cx - 8, baseLine - 46), 8, p);
    canvas.drawCircle(Offset(cx - 8, baseLine - 46), 8, _outlinePaint());
    canvas.drawCircle(Offset(cx + 8, baseLine - 46), 8, p);
    canvas.drawCircle(Offset(cx + 8, baseLine - 46), 8, _outlinePaint());

    // Pantorrillas (verticales)
    final calfP = _isActive(MuscleGroup.pantorrillas) ? _activePaint() : p;
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cx - 18, baseLine - 42, 16, 38),
            const Radius.circular(5)),
        calfP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cx - 18, baseLine - 42, 16, 38),
            const Radius.circular(5)),
        _outlinePaint());
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cx + 2, baseLine - 42, 16, 38),
            const Radius.circular(5)),
        calfP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cx + 2, baseLine - 42, 16, 38),
            const Radius.circular(5)),
        _outlinePaint());
  }

  // ── KNEELING ─────────────────────────────────────────────────────────────
  void _drawKneeling(Canvas canvas, Size s) {
    final cx = s.width / 2;
    final baseLine = s.height * 0.92;
    final p = Paint()
      ..color = _bodyColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(cx, baseLine - 165), 15, p);
    canvas.drawCircle(Offset(cx, baseLine - 165), 15, _outlinePaint());

    final torsoP =
        _isActive(MuscleGroup.pecho) || _isActive(MuscleGroup.espalda)
            ? _activePaint()
            : p;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx, baseLine - 110), width: 48, height: 56),
            const Radius.circular(7)),
        torsoP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx, baseLine - 110), width: 48, height: 56),
            const Radius.circular(7)),
        _outlinePaint());

    // Muslos (verticales, más cortos)
    final quadP =
        _isActive(MuscleGroup.cuadriceps) || _isActive(MuscleGroup.gluteos)
            ? _activePaint()
            : p;
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cx - 24, baseLine - 78, 18, 40),
            const Radius.circular(5)),
        quadP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cx - 24, baseLine - 78, 18, 40),
            const Radius.circular(5)),
        _outlinePaint());
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cx + 6, baseLine - 78, 18, 40),
            const Radius.circular(5)),
        quadP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cx + 6, baseLine - 78, 18, 40),
            const Radius.circular(5)),
        _outlinePaint());

    // Rodillas en suelo
    canvas.drawCircle(Offset(cx - 15, baseLine - 40), 10, p);
    canvas.drawCircle(Offset(cx - 15, baseLine - 40), 10, _outlinePaint());
    canvas.drawCircle(Offset(cx + 15, baseLine - 40), 10, p);
    canvas.drawCircle(Offset(cx + 15, baseLine - 40), 10, _outlinePaint());
  }

  // ── PLANK ────────────────────────────────────────────────────────────────
  void _drawPlank(Canvas canvas, Size s) {
    final cy = s.height / 2 + 20;
    final p = Paint()
      ..color = _bodyColor
      ..style = PaintingStyle.fill;

    // Cabeza
    canvas.drawCircle(Offset(26, cy - 22), 14, p);
    canvas.drawCircle(Offset(26, cy - 22), 14, _outlinePaint());

    // Cuerpo diagonal (plancha)
    final bodyP = _isActive(MuscleGroup.abdomen) ||
            _isActive(MuscleGroup.pecho) ||
            _isActive(MuscleGroup.hombros)
        ? _activePaint()
        : p;
    canvas.save();
    canvas.translate(s.width / 2 + 10, cy);
    canvas.rotate(-0.12); // Ligera inclinación
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: 130, height: 26),
            const Radius.circular(8)),
        bodyP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: 130, height: 26),
            const Radius.circular(8)),
        _outlinePaint());
    canvas.restore();

    // Brazos (apoyando)
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(20, cy - 12, 14, 26), const Radius.circular(5)),
        p);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(20, cy - 12, 14, 26), const Radius.circular(5)),
        _outlinePaint());

    // Piernas
    final legP =
        _isActive(MuscleGroup.cuadriceps) || _isActive(MuscleGroup.gluteos)
            ? _activePaint()
            : p;
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(s.width - 66, cy - 14, 40, 20),
            const Radius.circular(5)),
        legP);
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(s.width - 66, cy - 14, 40, 20),
            const Radius.circular(5)),
        _outlinePaint());
  }

  @override
  bool shouldRepaint(covariant _BodyPainter old) =>
      old.position != position ||
      old.activeMuscles != activeMuscles ||
      old.primaryColor != primaryColor;
}

// ── Widget de músculos activados (leyenda) ───────────────────────────────────
class ActivatedMusclesLegend extends StatelessWidget {
  final List<MuscleGroup> muscles;
  final Color activeColor;

  const ActivatedMusclesLegend({
    super.key,
    required this.muscles,
    required this.activeColor,
  });

  static const _labels = {
    MuscleGroup.pecho: 'Pecho',
    MuscleGroup.espalda: 'Espalda',
    MuscleGroup.hombros: 'Hombros',
    MuscleGroup.biceps: 'Bíceps',
    MuscleGroup.triceps: 'Tríceps',
    MuscleGroup.abdomen: 'Abdomen',
    MuscleGroup.gluteos: 'Glúteos',
    MuscleGroup.cuadriceps: 'Cuádriceps',
    MuscleGroup.isquiotibiales: 'Isquiotibiales',
    MuscleGroup.pantorrillas: 'Pantorrillas',
    MuscleGroup.cuerpoCompleto: 'Cuerpo completo',
  };

  @override
  Widget build(BuildContext context) {
    final display = muscles.contains(MuscleGroup.cuerpoCompleto)
        ? [MuscleGroup.cuerpoCompleto]
        : muscles;

    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: display.map((m) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: activeColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: activeColor.withValues(alpha: 0.4)),
          ),
          child: Text(
            _labels[m] ?? m.name,
            style: TextStyle(
              fontSize: 10,
              color: activeColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }
}
