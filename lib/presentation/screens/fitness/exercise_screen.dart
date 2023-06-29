import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:nutriplato/presentation/provider/fitness_provider.dart';
import 'package:nutriplato/presentation/screens/fitness/widgets/finished_exercise.dart';
import 'package:provider/provider.dart';

import '../../../infrastructure/entities/fitness/fitness.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({
    super.key,
  });

  @override
  State<ExerciseScreen> createState() => _ExerciseState();
}

class _ExerciseState extends State<ExerciseScreen> {
  int indexExercise = 0;
  final CountDownController _controller = CountDownController();
  bool _timerCompleted = false;
  bool _restTimerCompleted = true;

  @override
  Widget build(BuildContext context) {
    final Fitness? fitness = context.watch<FitnessProvider>().selectedExercise;

    return Scaffold(
      backgroundColor: _restTimerCompleted ? Colors.white : Colors.purple,
      appBar: AppBar(
          title: Text(fitness!.name),
          backgroundColor: _restTimerCompleted ? Colors.white : Colors.purple,
          foregroundColor: _restTimerCompleted ? Colors.black : Colors.white,
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
            if (!_restTimerCompleted)
              restTimer(fitness.rest, 'Descansa'),
            if (_restTimerCompleted && !_timerCompleted)
              restTimer(10, '¿Listo?'),
            if (_timerCompleted && _restTimerCompleted) ...[
              const Spacer(),
              Center(
                child: Text(fitness.exercises[indexExercise].name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: fitness.exercises[indexExercise].time == 0
                      ? Text(
                          'x${fitness.exercises[indexExercise].quantity}',
                          style: const TextStyle(
                              fontSize: 48, fontWeight: FontWeight.bold))
                      : Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularCountDownTimer(
                              duration:
                                  fitness.exercises[indexExercise].time +
                                      1,
                              initialDuration: 0,
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
                              isReverseAnimation: false,
                              isTimerTextShown: true,
                              autoStart: true,
                              onStart: () {},
                              onComplete: () {
                                if (!(indexExercise <
                                  fitness.exercises.length - 1)) {
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (builder) {
                                    return const FinishedExerciseScreen();
                                  }));
                                } else {
                                  setState(() {
                                    _restTimerCompleted = false;
                                    indexExercise += 1;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42, right: 42, bottom: 32),
                child: indexExercise < fitness.exercises.length - 1
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) {
                            return const FinishedExerciseScreen();
                          }));
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
    final Fitness? fitness = context.watch<FitnessProvider>().selectedExercise;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: _timerCompleted ? Colors.white : Colors.black,
          ),
        ),
        Center(
          child: CircularCountDownTimer(
            duration: time,
            initialDuration: 0,
            controller: _controller,
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            ringColor: Colors.grey[300]!,
            ringGradient: null,
            fillColor: Colors.purpleAccent[100]!,
            fillGradient: null,
            backgroundGradient: null,
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: TextStyle(
                fontSize: 33.0,
                color: _timerCompleted ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
            textFormat: CountdownTextFormat.S,
            isReverse: true,
            isReverseAnimation: false,
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
        _timerCompleted
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white.withAlpha(100),
                      ),
                      onPressed: () {
                        setState(() {
                          _controller.isPaused
                              ? _controller.resume()
                              : _controller.pause();
                        });
                      },
                      child: Text(
                        _controller.isPaused ? '  Reanudar  ' : '  Pausar  ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  const SizedBox(width: 10),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    onPressed: () {
                      setState(() {
                        _timerCompleted = true;
                        _restTimerCompleted = true;
                      });
                    },
                    child: const Text('  Saltar  '),
                  ),
                ],
              )
            : Container(),
        _timerCompleted
            ? Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 38, left: 32, right: 32),
                    child: Row(
                      children: [
                        Text(
                          'Siguiente ',
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' $indexExercise/${fitness?.exercises.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      children: [
                        Text(
                          fitness!.exercises[indexExercise].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 20,
                            )),
                        const Spacer(),
                        Text(
                            fitness.exercises[indexExercise].quantity ==
                                    0
                                ? '${fitness.exercises[indexExercise].time}s'
                                : 'x${fitness.exercises[indexExercise].quantity}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  )
                ],
              )
            : Container(),
      ],
    );
  }
}
