import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../infrastructure/entities/exercise/exercise.dart';
import '../../infrastructure/entities/fitness/fitness.dart';

List<Fitness> fitness = [
  Fitness(
    name: 'Novato',
    description: 'Ejercicio basico para principiantes.',
    difficulty: 'Facil',
    tags: ['Pierna', 'Hombro', 'Accesible'],
    sets: 1,
    rest: 15,
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
          name: 'Tijera de brazos', description: '', quantity: 10, images: []),
      Exercise(
          name: 'Tijera de hombros', description: '', quantity: 10, images: []),
      Exercise(
          name: 'Extension de biceps',
          description: '',
          quantity: 10,
          images: []),
      Exercise(
          name: 'Rodilla al codo', description: '', quantity: 10, images: []),
    ],
    icon: FontAwesomeIcons.dumbbell,
  ),
  Fitness(
    name: 'HIIT principiante',
    description: 'Entrenamiento para fortalecer el corazon.',
    difficulty: 'Facil',
    tags: ['HIIT', 'Accesible', 'Cuerpo Completo'],
    sets: 1,
    rest: 10,
    gradients: [
      Colors.indigo,
      Colors.blue,
    ],
    exercises: [
      Exercise(
        name: 'Marcha en el lugar',
        description: '',
        images: [],
        time: 15,
      ),
      Exercise(
        name: 'Levantamiento de rodillas',
        description: '',
        images: [],
        time: 15,
      ),
      Exercise(
        name: 'Circulos con hombros',
        description: '',
        images: [],
        time: 15,
      ),
      Exercise(
        name: 'Levantamiento de rodillas',
        description: '',
        images: [],
        time: 15,
      ),
      Exercise(
        name: 'Extencion de Biceps',
        description: '',
        images: [],
        time: 15,
      ),
      Exercise(
        name: 'Levantamiento de rodillas',
        description: '',
        images: [],
        time: 15,
      ),
    ],
    icon: FontAwesomeIcons.personRunning,
  ),
  Fitness(
      name: 'Abdominales sencillas',
      description: '',
      difficulty: 'Facil',
      tags: ['Core', 'Abdomen', 'Accesible'],
      sets: 0,
      rest: 10,
      exercises: [
        Exercise(
          name: 'Crunches',
          description: '',
          quantity: 10,
          images: [],
        ),
        Exercise(
          name: 'Bicicletas',
          description: '',
          images: [],
          quantity: 10,
        ),
        Exercise(
          name: 'Giros sentado',
          description: '',
          images: [],
          quantity: 10,
        ),
        Exercise(
          name: 'Levantamiento de piernas',
          description: '',
          images: [],
          quantity: 10,
        ),
        Exercise(
          name: 'Plancha',
          description: '',
          images: [],
          time: 10,
        ),
        Exercise(
          name: 'Elevacion de piernas en plancha',
          description: '',
          images: [],
          quantity: 10,
        ),
      ],
      icon: FontAwesomeIcons.heartPulse),
  Fitness(
    name: 'Abdominales sencillas II',
    description: '',
    difficulty: 'Facil',
    tags: ['Core', 'Abdomen', 'Accesible'],
    sets: 0,
    rest: 5,
    exercises: [
      Exercise(
        name: 'Crunches',
        description: '',
        quantity: 12,
        images: [],
      ),
      Exercise(
        name: 'Bicicletas',
        description: '',
        images: [],
        quantity: 12,
      ),
      Exercise(
        name: 'Giros sentado',
        description: '',
        images: [],
        quantity: 12,
      ),
      Exercise(
        name: 'Levantamiento de piernas',
        description: '',
        images: [],
        quantity: 15,
      ),
      Exercise(
        name: 'Plancha',
        description: '',
        images: [],
        time: 20,
      ),
      Exercise(
        name: 'Elevacion de piernas en plancha',
        description: '',
        images: [],
        quantity: 12,
      ),
    ],
    icon: FontAwesomeIcons.heartPulse,
  )
];
