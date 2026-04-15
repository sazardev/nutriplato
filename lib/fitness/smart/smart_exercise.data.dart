import 'smart_exercise.model.dart';

/// Biblioteca completa de ejercicios inteligentes
const List<SmartExercise> smartExercisesLibrary = [
  // ─── MOVILIDAD / BAJO IMPACTO (BMI alto, principiantes) ───────────────────
  SmartExercise(
    id: 'marcha_lugar',
    name: 'Marcha en el lugar',
    description:
        'Levanta las rodillas alternadamente mientras marchas sin moverte del sitio.',
    category: ExerciseCategory.cardio,
    muscleGroups: [
      MuscleGroup.cuadriceps,
      MuscleGroup.pantorrillas,
      MuscleGroup.cuerpoCompleto
    ],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 60,
    metValue: 3.5,
    maxBmiRecommended: 40,
    steps: [
      ExerciseStep(
          instruction: 'Párate con los pies a ancho de caderas',
          bodyPosition: BodyPosition.standing,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Levanta la rodilla derecha hasta la cadera, baja y repite con la izquierda',
          bodyPosition: BodyPosition.standing),
      ExerciseStep(
          instruction:
              'Mantén el torso erguido y los brazos oscilando naturalmente',
          bodyPosition: BodyPosition.standing),
    ],
    tips: ['Respira de forma continua', 'Aumenta el ritmo poco a poco'],
    contraindications: ['Dolor agudo en rodillas'],
  ),

  SmartExercise(
    id: 'sentadilla_silla',
    name: 'Sentadilla con silla',
    description:
        'Siéntate y párate de una silla para trabajar piernas con apoyo seguro.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [
      MuscleGroup.cuadriceps,
      MuscleGroup.gluteos,
      MuscleGroup.isquiotibiales
    ],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 3.5,
    maxBmiRecommended: 38,
    steps: [
      ExerciseStep(
          instruction:
              'Siéntate en el borde de una silla firme con espalda recta',
          bodyPosition: BodyPosition.sitting,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Inclínate ligeramente al frente y empuja con los talones para pararte',
          bodyPosition: BodyPosition.standing),
      ExerciseStep(
          instruction:
              'Controla el descenso hasta casi tocar la silla y repite',
          bodyPosition: BodyPosition.sitting),
    ],
    tips: [
      'Usa los brazos extendidos para equilibrio',
      'Mantén las rodillas alineadas con los pies'
    ],
    contraindications: [
      'Lesión en rodilla aguda',
      'Cirugía reciente de cadera'
    ],
  ),

  SmartExercise(
    id: 'estiramiento_cuello',
    name: 'Estiramiento de cuello y hombros',
    description:
        'Alivia tensión cervical con movimientos suaves y controlados.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [MuscleGroup.hombros],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.0,
    steps: [
      ExerciseStep(
          instruction: 'Siéntate o párate con espalda recta',
          bodyPosition: BodyPosition.sitting,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Inclina la cabeza a la derecha acercando la oreja al hombro, mantén 15 segundos',
          bodyPosition: BodyPosition.sitting),
      ExerciseStep(
          instruction: 'Repite hacia la izquierda',
          bodyPosition: BodyPosition.sitting),
    ],
    tips: [
      'No fuerces el movimiento',
      'Respira profundamente durante el estiramiento'
    ],
  ),

  // ─── FUERZA MODERADA ───────────────────────────────────────────────────────
  SmartExercise(
    id: 'sentadilla_basica',
    name: 'Sentadilla básica',
    description:
        'El ejercicio rey para piernas. Activa cuádriceps, glúteos e isquiotibiales.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [
      MuscleGroup.cuadriceps,
      MuscleGroup.gluteos,
      MuscleGroup.isquiotibiales
    ],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 15,
    metValue: 5.0,
    steps: [
      ExerciseStep(
          instruction:
              'Párate con pies a ancho de hombros, puntas ligeramente abiertas',
          bodyPosition: BodyPosition.standing,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Lleva las caderas hacia atrás y abajo como si fueras a sentarte',
          bodyPosition: BodyPosition.standing),
      ExerciseStep(
          instruction: 'Baja hasta que los muslos queden paralelos al suelo',
          bodyPosition: BodyPosition.standing),
      ExerciseStep(
          instruction: 'Empuja con los talones para subir, expirando al subir',
          bodyPosition: BodyPosition.standing),
    ],
    tips: [
      'Rodillas no deben sobrepasar los pies',
      'Pecho arriba, mirada al frente'
    ],
    contraindications: ['Dolor agudo de rodilla o cadera'],
  ),

  SmartExercise(
    id: 'flexiones_pared',
    name: 'Flexiones en la pared',
    description:
        'Versión accesible de las flexiones — ideal para comenzar a trabajar el pecho.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.pecho, MuscleGroup.hombros, MuscleGroup.triceps],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.8,
    maxBmiRecommended: 35,
    steps: [
      ExerciseStep(
          instruction:
              'Párate frente a una pared y coloca las palmas a la altura del pecho',
          bodyPosition: BodyPosition.standing,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Dobla los codos y acerca el pecho a la pared lentamente',
          bodyPosition: BodyPosition.standing),
      ExerciseStep(
          instruction: 'Empuja para volver a la posición inicial, exhalando',
          bodyPosition: BodyPosition.standing),
    ],
    tips: [
      'Cuerpo recto como tabla',
      'Mientras más lejos de la pared, más difícil'
    ],
  ),

  SmartExercise(
    id: 'flexiones_rodillas',
    name: 'Flexiones en rodillas',
    description:
        'Flexiones apoyadas en rodillas — excelente transición hacia flexiones completas.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.pecho, MuscleGroup.hombros, MuscleGroup.triceps],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 4.0,
    steps: [
      ExerciseStep(
          instruction:
              'Apoya rodillas y manos en el suelo, manos bajo los hombros',
          bodyPosition: BodyPosition.kneeling,
          isStartPosition: true),
      ExerciseStep(
          instruction: 'Baja el pecho hacia el suelo doblando los codos',
          bodyPosition: BodyPosition.kneeling),
      ExerciseStep(
          instruction: 'Empuja para subir, manteniendo el core activo',
          bodyPosition: BodyPosition.kneeling),
    ],
    tips: [
      'Mantén la cadera alineada, sin subirla',
      'Cabeza en posición neutra'
    ],
  ),

  SmartExercise(
    id: 'flexiones_completas',
    name: 'Flexiones completas',
    description:
        'Ejercicio clásico de fuerza superior para pecho, hombros y tríceps.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [
      MuscleGroup.pecho,
      MuscleGroup.hombros,
      MuscleGroup.triceps,
      MuscleGroup.abdomen
    ],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 6.0,
    minBmiRequired: 17.0,
    steps: [
      ExerciseStep(
          instruction:
              'Posición de plancha: manos bajo hombros, cuerpo recto de cabeza a talones',
          bodyPosition: BodyPosition.plank,
          isStartPosition: true),
      ExerciseStep(
          instruction: 'Baja el pecho cerca del suelo doblando codos a 45°',
          bodyPosition: BodyPosition.plank),
      ExerciseStep(
          instruction: 'Empuja explosivamente hacia arriba exhalando',
          bodyPosition: BodyPosition.plank),
    ],
    tips: ['Core tenso en todo momento', 'No dejes caer las caderas'],
    contraindications: ['Lesión de muñeca o hombro'],
  ),

  SmartExercise(
    id: 'zancada',
    name: 'Zancada (Lunge)',
    description:
        'Trabaja cada pierna de forma independiente, mejorando equilibrio y fuerza.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [
      MuscleGroup.cuadriceps,
      MuscleGroup.gluteos,
      MuscleGroup.isquiotibiales
    ],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 4.5,
    steps: [
      ExerciseStep(
          instruction: 'Párate erguido, manos en caderas',
          bodyPosition: BodyPosition.standing,
          isStartPosition: true),
      ExerciseStep(
          instruction: 'Da un paso grande al frente con el pie derecho',
          bodyPosition: BodyPosition.standing),
      ExerciseStep(
          instruction: 'Baja la rodilla trasera hacia el suelo sin tocarlo',
          bodyPosition: BodyPosition.standing),
      ExerciseStep(
          instruction: 'Regresa al inicio y repite con la pierna izquierda',
          bodyPosition: BodyPosition.standing),
    ],
    tips: [
      'Rodilla delantera no sobrepasa el pie',
      'Torso recto durante todo el movimiento'
    ],
  ),

  SmartExercise(
    id: 'plancha',
    name: 'Plancha',
    description:
        'Ejercicio isométrico que activa todo el core y estabilizadores.',
    category: ExerciseCategory.core,
    muscleGroups: [
      MuscleGroup.abdomen,
      MuscleGroup.espalda,
      MuscleGroup.hombros
    ],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 4.0,
    steps: [
      ExerciseStep(
          instruction: 'Apoya antebrazos y puntas de pies en el suelo',
          bodyPosition: BodyPosition.plank,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Mantén el cuerpo recto como tabla, sin subir ni bajar caderas',
          bodyPosition: BodyPosition.plank),
      ExerciseStep(
          instruction: 'Activa el abdomen hacia adentro durante todo el tiempo',
          bodyPosition: BodyPosition.plank),
    ],
    tips: [
      'Respira normal durante la plancha',
      'Si fallas la forma, reduce el tiempo'
    ],
    contraindications: ['Dolor lumbar agudo'],
  ),

  SmartExercise(
    id: 'crunch_abdominal',
    name: 'Crunch abdominal',
    description:
        'Ejercicio clásico para fortalecer y definir el abdomen superior.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 15,
    metValue: 3.5,
    steps: [
      ExerciseStep(
          instruction:
              'Acuéstate boca arriba, rodillas dobladas, manos detrás de la cabeza',
          bodyPosition: BodyPosition.lying,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Eleva únicamente los hombros del suelo contrayendo el abdomen',
          bodyPosition: BodyPosition.lying),
      ExerciseStep(
          instruction: 'Baja controladamente sin dejar caer la espalda',
          bodyPosition: BodyPosition.lying),
    ],
    tips: [
      'No jales el cuello con las manos',
      'La barbilla ligeramente elevada'
    ],
  ),

  SmartExercise(
    id: 'bicicleta_suelo',
    name: 'Bicicleta en el suelo',
    description: 'Activa oblicuos y recto abdominal con movimiento cíclico.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 20,
    metValue: 4.0,
    steps: [
      ExerciseStep(
          instruction:
              'Acuéstate boca arriba, manos detrás de la cabeza, piernas elevadas a 90°',
          bodyPosition: BodyPosition.lying,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Extiende la pierna derecha mientras llevas el codo derecho a la rodilla izquierda',
          bodyPosition: BodyPosition.lying),
      ExerciseStep(
          instruction: 'Alterna lados en movimiento de pedaleo controlado',
          bodyPosition: BodyPosition.lying),
    ],
    tips: [
      'Movimiento lento y controlado para mayor activación',
      'Exhala al rotar'
    ],
  ),

  SmartExercise(
    id: 'puente_gluteos',
    name: 'Puente de glúteos',
    description:
        'Activa glúteos e isquiotibiales — ideal para fortalecer la cadena posterior.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [
      MuscleGroup.gluteos,
      MuscleGroup.isquiotibiales,
      MuscleGroup.abdomen
    ],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 15,
    metValue: 3.8,
    steps: [
      ExerciseStep(
          instruction:
              'Acuéstate boca arriba, rodillas dobladas, pies planos en el suelo',
          bodyPosition: BodyPosition.lying,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Empuja con los talones y eleva las caderas hasta formar una línea recta',
          bodyPosition: BodyPosition.lying),
      ExerciseStep(
          instruction: 'Aprieta glúteos en la cima, baja controladamente',
          bodyPosition: BodyPosition.lying),
    ],
    tips: ['Rodillas alineadas con los pies durante todo el movimiento'],
    contraindications: ['Dolor lumbar agudo'],
  ),

  // ─── CARDIO INTENSO ───────────────────────────────────────────────────────
  SmartExercise(
    id: 'jumping_jacks',
    name: 'Jumping Jacks',
    description:
        'Cardio clásico que activa el cuerpo completo y eleva la frecuencia cardíaca.',
    category: ExerciseCategory.cardio,
    muscleGroups: [MuscleGroup.cuerpoCompleto, MuscleGroup.pantorrillas],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 8.0,
    maxBmiRecommended: 32,
    steps: [
      ExerciseStep(
          instruction: 'Párate con pies juntos y brazos a los lados',
          bodyPosition: BodyPosition.standing,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Salta abriendo pies a ancho de hombros mientras elevas los brazos sobre la cabeza',
          bodyPosition: BodyPosition.standing),
      ExerciseStep(
          instruction:
              'Salta regresando a la posición inicial en un movimiento fluido',
          bodyPosition: BodyPosition.standing),
    ],
    tips: [
      'Aterriza suavemente en la punta de los pies',
      'Mantén el ritmo constante'
    ],
    contraindications: [
      'Problemas de rodilla o tobillo',
      'BMI > 35 sin acondicionamiento previo'
    ],
  ),

  SmartExercise(
    id: 'mountain_climbers',
    name: 'Mountain Climbers',
    description:
        'Cardio + core en uno — simula escalar en posición de plancha.',
    category: ExerciseCategory.hiit,
    muscleGroups: [
      MuscleGroup.abdomen,
      MuscleGroup.cuadriceps,
      MuscleGroup.hombros,
      MuscleGroup.cuerpoCompleto
    ],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 8.0,
    steps: [
      ExerciseStep(
          instruction:
              'Posición de plancha alta: brazos extendidos, manos bajo hombros',
          bodyPosition: BodyPosition.plank,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Lleva la rodilla derecha hacia el pecho de forma explosiva',
          bodyPosition: BodyPosition.plank),
      ExerciseStep(
          instruction: 'Alterna piernas rápidamente como si escalaras',
          bodyPosition: BodyPosition.plank),
    ],
    tips: [
      'Caderas bajas todo el tiempo',
      'Más rápido = más cardio; más lento = más core'
    ],
    contraindications: ['Dolor en muñecas o hombros'],
  ),

  SmartExercise(
    id: 'burpees',
    name: 'Burpees',
    description:
        'El ejercicio de mayor demanda metabólica — cardio, fuerza y agilidad combinados.',
    category: ExerciseCategory.hiit,
    muscleGroups: [MuscleGroup.cuerpoCompleto],
    intensity: IntensityLevel.muy_alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 8,
    metValue: 10.0,
    maxBmiRecommended: 28,
    steps: [
      ExerciseStep(
          instruction: 'Párate erguido',
          bodyPosition: BodyPosition.standing,
          isStartPosition: true),
      ExerciseStep(
          instruction: 'Baja en cuclillas y apoya las manos en el suelo',
          bodyPosition: BodyPosition.kneeling),
      ExerciseStep(
          instruction: 'Salta los pies hacia atrás llegando a plancha',
          bodyPosition: BodyPosition.plank),
      ExerciseStep(
          instruction: 'Haz una flexión (opcional para avanzados)',
          bodyPosition: BodyPosition.plank),
      ExerciseStep(
          instruction:
              'Salta los pies al frente y salta explosivamente hacia arriba',
          bodyPosition: BodyPosition.standing),
    ],
    tips: [
      'Comienza lento y aumenta el ritmo',
      'Modifica omitiendo el salto final si es necesario'
    ],
    contraindications: [
      'Hipertensión no controlada',
      'Lesiones articulares',
      'BMI > 30 sin base cardio'
    ],
  ),

  SmartExercise(
    id: 'step_up',
    name: 'Step-up (subir escalón)',
    description:
        'Sube y baja de un escalón — cardio suave que fortalece piernas sin impacto fuerte.',
    category: ExerciseCategory.cardio,
    muscleGroups: [
      MuscleGroup.cuadriceps,
      MuscleGroup.gluteos,
      MuscleGroup.pantorrillas
    ],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 20,
    metValue: 5.0,
    steps: [
      ExerciseStep(
          instruction:
              'Párate frente a un escalón o superficie estable de 15-20cm',
          bodyPosition: BodyPosition.standing,
          isStartPosition: true),
      ExerciseStep(
          instruction: 'Sube el pie derecho al escalón, luego el izquierdo',
          bodyPosition: BodyPosition.standing),
      ExerciseStep(
          instruction:
              'Baja el pie derecho, luego el izquierdo, alternando el pie líder cada vuelta',
          bodyPosition: BodyPosition.standing),
    ],
    tips: ['Apoya el pie completo en el escalón', 'Mantén el torso erguido'],
  ),

  // ─── FLEXIBILIDAD / YOGA ──────────────────────────────────────────────────
  SmartExercise(
    id: 'estiramiento_cuadriceps',
    name: 'Estiramiento de cuádriceps',
    description: 'Mejora la flexibilidad de muslos y previene lesiones.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [MuscleGroup.cuadriceps],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.5,
    steps: [
      ExerciseStep(
          instruction: 'Párate junto a una pared para apoyo',
          bodyPosition: BodyPosition.standing,
          isStartPosition: true),
      ExerciseStep(
          instruction: 'Dobla la rodilla derecha llevando el talón al glúteo',
          bodyPosition: BodyPosition.standing),
      ExerciseStep(
          instruction:
              'Sujeta el tobillo con la mano, mantén 30 segundos y repite con la izquierda',
          bodyPosition: BodyPosition.standing),
    ],
    tips: [
      'Rodillas juntas durante el estiramiento',
      'Tira suavemente sin rebotes'
    ],
  ),

  SmartExercise(
    id: 'postura_nino',
    name: 'Postura del niño (yoga)',
    description:
        'Estiramiento profundo de espalda baja y cadera — ideal para recuperación.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [MuscleGroup.espalda, MuscleGroup.gluteos],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 45,
    metValue: 2.0,
    steps: [
      ExerciseStep(
          instruction:
              'Arrodíllate con los pies juntos y siéntate sobre los talones',
          bodyPosition: BodyPosition.kneeling,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Inclínate al frente extendiendo los brazos sobre el suelo',
          bodyPosition: BodyPosition.kneeling),
      ExerciseStep(
          instruction: 'Descansa la frente en el suelo y relaja completamente',
          bodyPosition: BodyPosition.kneeling),
    ],
    tips: [
      'Respira profundamente',
      'Excelente para después de un entrenamiento intenso'
    ],
  ),

  SmartExercise(
    id: 'rotacion_cadera',
    name: 'Rotación de cadera',
    description:
        'Moviliza la articulación de la cadera — esencial para movimientos del día a día.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [MuscleGroup.gluteos, MuscleGroup.isquiotibiales],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 2.5,
    steps: [
      ExerciseStep(
          instruction: 'Párate con pies a ancho de hombros',
          bodyPosition: BodyPosition.standing,
          isStartPosition: true),
      ExerciseStep(
          instruction:
              'Dibuja círculos amplios con las caderas, 10 en sentido horario',
          bodyPosition: BodyPosition.standing),
      ExerciseStep(
          instruction: 'Repite 10 círculos en sentido antihorario',
          bodyPosition: BodyPosition.standing),
    ],
    tips: ['Movimiento lento y amplio', 'Excelente como calentamiento'],
  ),
];

/// Filtra ejercicios por categoría
List<SmartExercise> getExercisesByCategory(ExerciseCategory category) =>
    smartExercisesLibrary.where((e) => e.category == category).toList();

/// Obtiene un ejercicio por ID
SmartExercise? getExerciseById(String id) {
  try {
    return smartExercisesLibrary.firstWhere((e) => e.id == id);
  } catch (_) {
    return null;
  }
}
