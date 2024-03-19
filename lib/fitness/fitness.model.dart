import 'package:flutter/material.dart';
import 'package:nutriplato/fitness/exercise/exercise.model.dart';

class Fitness {
  String name;
  String description;
  String difficulty;
  List<String> tags;
  int sets;
  int rest;
  List<Exercise> exercises;
  IconData icon;
  List<Color> gradients;

  Fitness({
    required this.name,
    required this.description,
    required this.difficulty,
    required this.tags,
    required this.sets,
    required this.rest,
    required this.exercises,
    required this.icon,
    this.gradients = const [],
  });
}
