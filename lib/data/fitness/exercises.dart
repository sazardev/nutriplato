import 'package:nutriplato/models/exercise.dart';
import 'package:nutriplato/models/fitness.dart';

List<Fitness> fitness = [
  Fitness(
      name: 'Novato',
      description: 'Ejercicio basico para principiantes.',
      difficulty: 'Facil',
      tags: ['Pierna', 'Hombro', 'Accesible'],
      sets: 1,
      rest: 120,
      exercises: [
        Exercise(name: 'Sentadilla', description: '', quantity: 5, images: []),
        Exercise(
            name: 'Desplazamientos', description: '', quantity: 10, images: []),
        Exercise(
            name: 'Levantamiento de pantorrillas',
            description: '',
            quantity: 5,
            images: []),
        Exercise(
            name: 'Tijera de brazos',
            description: '',
            quantity: 10,
            images: []),
        Exercise(
            name: 'Tijera de hombros',
            description: '',
            quantity: 10,
            images: []),
        Exercise(
            name: 'Extension de biceps',
            description: '',
            quantity: 10,
            images: []),
        Exercise(
            name: 'Rodilla al codo', description: '', quantity: 10, images: []),
      ]),
];
