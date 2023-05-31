import 'package:nutriplato/models/exercise.dart';

class Fitness {
  String name;
  String description;
  String difficulty;
  List<String> tags;
  int sets;
  int rest;
  List<Exercise> exercises;

  Fitness({
    required this.name,
    required this.description,
    required this.difficulty,
    required this.tags,
    required this.sets,
    required this.rest,
    required this.exercises,
  });
}
