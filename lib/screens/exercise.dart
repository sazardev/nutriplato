import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:nutriplato/models/fitness.dart';

class ExerciseState extends StatefulWidget {
  final Fitness fitness;
  const ExerciseState({
    super.key,
    required this.fitness,
  });

  @override
  State<ExerciseState> createState() => _ExerciseState();
}

class _ExerciseState extends State<ExerciseState> {
  int indexExercise = 0;

  bool _timerCompleted = false;
  bool _restTimerCompleted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.fitness.name),
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!_restTimerCompleted) restTimer(5, 'Descansa'),
            if (_restTimerCompleted && !_timerCompleted)
              restTimer(3, '¿Listo?'),
            if (_timerCompleted) ...[
              const Spacer(),
              Center(
                child: Text(widget.fitness.exercises[indexExercise].name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                      'x${widget.fitness.exercises[indexExercise].quantity}',
                      style: const TextStyle(
                          fontSize: 48, fontWeight: FontWeight.bold)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42, right: 42, bottom: 32),
                child: indexExercise < widget.fitness.exercises.length - 1
                    ? FilledButton(
                        onPressed: () {
                          setState(() {
                            _restTimerCompleted = false;
                            indexExercise += 1;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:
                              Text('Siguiente', style: TextStyle(fontSize: 18)),
                        ),
                      )
                    : FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:
                              Text('Terminar', style: TextStyle(fontSize: 18)),
                        ),
                      ),
              ),
            ],
          ]),
    );
  }

  Widget restTimer(int time, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
        Center(
          child: CircularCountDownTimer(
            duration: time,
            initialDuration: 0,
            controller: CountDownController(),
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            ringColor: Colors.grey[300]!,
            ringGradient: null,
            fillColor: Colors.purpleAccent[100]!,
            fillGradient: null,
            backgroundGradient: null,
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: const TextStyle(
                fontSize: 33.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            textFormat: CountdownTextFormat.S,
            isReverse: true,
            isReverseAnimation: true,
            isTimerTextShown: true,
            autoStart: true,
            onStart: () {},
            onComplete: () {
              setState(() {
                _timerCompleted = true;
                _restTimerCompleted = true;
              });
            },
          ),
        ),
      ],
    );
  }
}
