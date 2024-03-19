import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nutriplato/fitness/exercise/exercise.screen.dart';
import 'package:nutriplato/fitness/fitness.model.dart';

class ExerciseViewScreen extends StatelessWidget {
  const ExerciseViewScreen({super.key, required this.selectedFitness});

  final Fitness selectedFitness;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      appBar: AppBar(
        title: Text(selectedFitness.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (builder) => AlertDialog(
                  title: Text(selectedFitness.name),
                  content: Text(selectedFitness.description),
                  actions: [
                    FilledButton(
                      onPressed: () => Get.back(),
                      child: const Text('Aceptar'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.info_outline),
          ),
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
                    '${selectedFitness.exercises.length ~/ 2} minutos',
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
                    '${(selectedFitness.exercises.length ~/ 2) * 20} calorias',
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
              itemCount: selectedFitness.exercises.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  leading: selectedFitness.exercises[index].images.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(FontAwesomeIcons.dumbbell),
                        )
                      : selectedFitness.exercises[index].images[0],
                  title: Text(
                    selectedFitness.exercises[index].name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  subtitle: Text(
                    selectedFitness.exercises[index].quantity == 0
                        ? '${selectedFitness.exercises[index].time} segundos'
                        : 'x${selectedFitness.exercises[index].quantity} repeticiones',
                    style: const TextStyle(),
                  ),
                  onTap: () {},
                );
              })),
        ))
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(
          () => ExerciseScreen(
            selectedFitness: selectedFitness,
          ),
        ),
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
