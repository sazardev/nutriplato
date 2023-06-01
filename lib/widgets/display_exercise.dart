import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/fitness.dart';
import '../screens/exercise.dart';
import 'info/exercise_info.dart';

class DisplayExercise extends StatelessWidget {
  final Fitness fitness;

  const DisplayExercise({super.key, required this.fitness});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      appBar: AppBar(
        title: Text(fitness.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (builder) {
                      return Exercise(
                        fitness: fitness,
                      );
                    });
              },
              icon: const Icon(Icons.info_outline))
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(
                    FontAwesomeIcons.stopwatch,
                    color: Colors.purple,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${fitness.exercises.length ~/ 2} minutos',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    FontAwesomeIcons.fire,
                    color: Colors.purple,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${(fitness.exercises.length ~/ 2) * 20} calorias',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ]),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: fitness.exercises.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  leading: fitness.exercises[index].images.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(FontAwesomeIcons.dumbbell),
                        )
                      : fitness.exercises[index].images[0],
                  title: Text(
                    fitness.exercises[index].name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  subtitle: Text(
                    fitness.exercises[index].quantity == 0
                        ? '${fitness.exercises[index].time} segundos'
                        : 'x${fitness.exercises[index].quantity} repeticiones',
                    style: const TextStyle(),
                  ),
                  onTap: () {},
                );
              })),
        ))
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) {
            return ExerciseState(
              fitness: fitness,
            );
          }));
        },
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        label: const Padding(
          padding: EdgeInsets.only(left: 40.0, right: 40),
          child: Text(
            'Empezar entrenamiento',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
