import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/fitness/smart/smart_exercise.model.dart';

class MoodTrackerDialog extends StatefulWidget {
  const MoodTrackerDialog({super.key});

  @override
  State<MoodTrackerDialog> createState() => _MoodTrackerDialogState();
}

class _MoodTrackerDialogState extends State<MoodTrackerDialog> {
  int _energia = 3;
  int _esfuerzo = 3;
  int _competencia = 3;
  int _variedad = 3;
  int _potencia = 3;

  static const _moodDefs = [
    {
      'label': 'Energía',
      'emojis': ['😴', '😐', '🙂', '💪', '🔥'],
    },
    {
      'label': 'Esfuerzo',
      'emojis': ['🥱', '😊', '😤', '💦', '🏆'],
    },
    {
      'label': 'Competencia',
      'emojis': ['😟', '😐', '🙂', '😎', '🏅'],
    },
    {
      'label': 'Variedad',
      'emojis': ['🥱', '🙂', '😊', '🤩', '⭐'],
    },
    {
      'label': 'Potencia',
      'emojis': ['🐌', '🚶', '🏃', '⚡', '🚀'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '¿Cómo fue tu entrenamiento?',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            MoodRow(
              label: _moodDefs[0]['label'] as String,
              emojis: _moodDefs[0]['emojis'] as List<String>,
              value: _energia,
              onChanged: (v) => setState(() => _energia = v),
            ),
            MoodRow(
              label: _moodDefs[1]['label'] as String,
              emojis: _moodDefs[1]['emojis'] as List<String>,
              value: _esfuerzo,
              onChanged: (v) => setState(() => _esfuerzo = v),
            ),
            MoodRow(
              label: _moodDefs[2]['label'] as String,
              emojis: _moodDefs[2]['emojis'] as List<String>,
              value: _competencia,
              onChanged: (v) => setState(() => _competencia = v),
            ),
            MoodRow(
              label: _moodDefs[3]['label'] as String,
              emojis: _moodDefs[3]['emojis'] as List<String>,
              value: _variedad,
              onChanged: (v) => setState(() => _variedad = v),
            ),
            MoodRow(
              label: _moodDefs[4]['label'] as String,
              emojis: _moodDefs[4]['emojis'] as List<String>,
              value: _potencia,
              onChanged: (v) => setState(() => _potencia = v),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: NutriDesign.success,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.pop(
                  context,
                  WorkoutMood(
                    energia: _energia,
                    esfuerzo: _esfuerzo,
                    competencia: _competencia,
                    variedad: _variedad,
                    potencia: _potencia,
                  ),
                ),
                child: Text(
                  'Guardar',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Omitir',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: NutriDesign.grey700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoodRow extends StatelessWidget {
  final String label;
  final List<String> emojis;
  final int value; // 1-5
  final ValueChanged<int> onChanged;

  const MoodRow({
    super.key,
    required this.label,
    required this.emojis,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 86,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...List.generate(5, (i) {
            final level = i + 1;
            final selected = value == level;
            return Semantics(
              button: true,
              selected: selected,
              label: '$label nivel $level',
              excludeSemantics: true,
              child: GestureDetector(
                onTap: () => onChanged(level),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: const EdgeInsets.only(right: 4),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: selected
                        ? NutriDesign.success.withValues(alpha: 0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: selected
                          ? NutriDesign.success
                          : Colors.transparent,
                    ),
                  ),
                  child: ExcludeSemantics(
                    child: Text(
                      emojis[i],
                      style: TextStyle(fontSize: selected ? 22 : 18),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
