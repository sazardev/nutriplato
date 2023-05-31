import 'package:flutter/material.dart';

import '../data/fitness/exercises.dart';
import 'exercise.dart';

class Fitness extends StatefulWidget {
  const Fitness({super.key});

  @override
  State<Fitness> createState() => _FitnessState();
}

class _FitnessState extends State<Fitness> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Recomendado para ti',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: constraints.maxWidth,
                child: Card(
                  elevation: 0,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.pink,
                        ],
                        stops: [
                          0.0,
                          1.0,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 3,
                            children:
                                List.generate(fitness[0].tags.length, (index) {
                              return FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                    backgroundColor: Colors.purple.shade800),
                                child: Text(
                                  fitness[0].tags[index],
                                ),
                              );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              fitness[0].name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              fitness[0].description,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                  backgroundColor: Colors.pink.shade900),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (builder) {
                                  return ExerciseState(
                                    fitness: fitness[0],
                                  );
                                }));
                              },
                              child: const Text('Comenzar ejercicio'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      );
    });
  }
}
