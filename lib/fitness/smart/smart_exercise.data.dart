import 'smart_exercise.model.dart';
import 'smart_exercise_extra.data.dart';

/// Biblioteca completa de ejercicios inteligentes (base + banco ampliado).
const List<SmartExercise> smartExercisesLibrary = [
  ..._smartExercisesBase,
  ...smartExercisesExtra,
];

const List<SmartExercise> _smartExercisesBase = [
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
      MuscleGroup.cuerpoCompleto,
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Levanta la rodilla derecha hasta la cadera, baja y repite con la izquierda',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction:
            'Mantén el torso erguido y los brazos oscilando naturalmente',
        bodyPosition: BodyPosition.standing,
      ),
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
      MuscleGroup.isquiotibiales,
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Inclínate ligeramente al frente y empuja con los talones para pararte',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Controla el descenso hasta casi tocar la silla y repite',
        bodyPosition: BodyPosition.sitting,
      ),
    ],
    tips: [
      'Usa los brazos extendidos para equilibrio',
      'Mantén las rodillas alineadas con los pies',
    ],
    contraindications: [
      'Lesión en rodilla aguda',
      'Cirugía reciente de cadera',
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Inclina la cabeza a la derecha acercando la oreja al hombro, mantén 15 segundos',
        bodyPosition: BodyPosition.sitting,
      ),
      ExerciseStep(
        instruction: 'Repite hacia la izquierda',
        bodyPosition: BodyPosition.sitting,
      ),
    ],
    tips: [
      'No fuerces el movimiento',
      'Respira profundamente durante el estiramiento',
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
      MuscleGroup.isquiotibiales,
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Lleva las caderas hacia atrás y abajo como si fueras a sentarte',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Baja hasta que los muslos queden paralelos al suelo',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Empuja con los talones para subir, expirando al subir',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: [
      'Rodillas no deben sobrepasar los pies',
      'Pecho arriba, mirada al frente',
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Dobla los codos y acerca el pecho a la pared lentamente',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Empuja para volver a la posición inicial, exhalando',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: [
      'Cuerpo recto como tabla',
      'Mientras más lejos de la pared, más difícil',
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Baja el pecho hacia el suelo doblando los codos',
        bodyPosition: BodyPosition.kneeling,
      ),
      ExerciseStep(
        instruction: 'Empuja para subir, manteniendo el core activo',
        bodyPosition: BodyPosition.kneeling,
      ),
    ],
    tips: [
      'Mantén la cadera alineada, sin subirla',
      'Cabeza en posición neutra',
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
      MuscleGroup.abdomen,
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Baja el pecho cerca del suelo doblando codos a 45°',
        bodyPosition: BodyPosition.plank,
      ),
      ExerciseStep(
        instruction: 'Empuja explosivamente hacia arriba exhalando',
        bodyPosition: BodyPosition.plank,
      ),
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
      MuscleGroup.isquiotibiales,
    ],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 4.5,
    steps: [
      ExerciseStep(
        instruction: 'Párate erguido, manos en caderas',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Da un paso grande al frente con el pie derecho',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Baja la rodilla trasera hacia el suelo sin tocarlo',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Regresa al inicio y repite con la pierna izquierda',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: [
      'Rodilla delantera no sobrepasa el pie',
      'Torso recto durante todo el movimiento',
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
      MuscleGroup.hombros,
    ],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 4.0,
    steps: [
      ExerciseStep(
        instruction: 'Apoya antebrazos y puntas de pies en el suelo',
        bodyPosition: BodyPosition.plank,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Mantén el cuerpo recto como tabla, sin subir ni bajar caderas',
        bodyPosition: BodyPosition.plank,
      ),
      ExerciseStep(
        instruction: 'Activa el abdomen hacia adentro durante todo el tiempo',
        bodyPosition: BodyPosition.plank,
      ),
    ],
    tips: [
      'Respira normal durante la plancha',
      'Si fallas la forma, reduce el tiempo',
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Eleva únicamente los hombros del suelo contrayendo el abdomen',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Baja controladamente sin dejar caer la espalda',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: [
      'No jales el cuello con las manos',
      'La barbilla ligeramente elevada',
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Extiende la pierna derecha mientras llevas el codo derecho a la rodilla izquierda',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Alterna lados en movimiento de pedaleo controlado',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: [
      'Movimiento lento y controlado para mayor activación',
      'Exhala al rotar',
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
      MuscleGroup.abdomen,
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Empuja con los talones y eleva las caderas hasta formar una línea recta',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Aprieta glúteos en la cima, baja controladamente',
        bodyPosition: BodyPosition.lying,
      ),
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Salta abriendo pies a ancho de hombros mientras elevas los brazos sobre la cabeza',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction:
            'Salta regresando a la posición inicial en un movimiento fluido',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: [
      'Aterriza suavemente en la punta de los pies',
      'Mantén el ritmo constante',
    ],
    contraindications: [
      'Problemas de rodilla o tobillo',
      'BMI > 35 sin acondicionamiento previo',
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
      MuscleGroup.cuerpoCompleto,
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Lleva la rodilla derecha hacia el pecho de forma explosiva',
        bodyPosition: BodyPosition.plank,
      ),
      ExerciseStep(
        instruction: 'Alterna piernas rápidamente como si escalaras',
        bodyPosition: BodyPosition.plank,
      ),
    ],
    tips: [
      'Caderas bajas todo el tiempo',
      'Más rápido = más cardio; más lento = más core',
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Baja en cuclillas y apoya las manos en el suelo',
        bodyPosition: BodyPosition.kneeling,
      ),
      ExerciseStep(
        instruction: 'Salta los pies hacia atrás llegando a plancha',
        bodyPosition: BodyPosition.plank,
      ),
      ExerciseStep(
        instruction: 'Haz una flexión (opcional para avanzados)',
        bodyPosition: BodyPosition.plank,
      ),
      ExerciseStep(
        instruction:
            'Salta los pies al frente y salta explosivamente hacia arriba',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: [
      'Comienza lento y aumenta el ritmo',
      'Modifica omitiendo el salto final si es necesario',
    ],
    contraindications: [
      'Hipertensión no controlada',
      'Lesiones articulares',
      'BMI > 30 sin base cardio',
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
      MuscleGroup.pantorrillas,
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Sube el pie derecho al escalón, luego el izquierdo',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction:
            'Baja el pie derecho, luego el izquierdo, alternando el pie líder cada vuelta',
        bodyPosition: BodyPosition.standing,
      ),
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Dobla la rodilla derecha llevando el talón al glúteo',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction:
            'Sujeta el tobillo con la mano, mantén 30 segundos y repite con la izquierda',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: [
      'Rodillas juntas durante el estiramiento',
      'Tira suavemente sin rebotes',
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Inclínate al frente extendiendo los brazos sobre el suelo',
        bodyPosition: BodyPosition.kneeling,
      ),
      ExerciseStep(
        instruction: 'Descansa la frente en el suelo y relaja completamente',
        bodyPosition: BodyPosition.kneeling,
      ),
    ],
    tips: [
      'Respira profundamente',
      'Excelente para después de un entrenamiento intenso',
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
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Dibuja círculos amplios con las caderas, 10 en sentido horario',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Repite 10 círculos en sentido antihorario',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Movimiento lento y amplio', 'Excelente como calentamiento'],
  ),

  // ─── ESPALDA ───────────────────────────────────────────────────────────────
  SmartExercise(
    id: 'superman',
    name: 'Superman',
    description:
        'Fortalece la espalda baja y glúteos elevando brazos y piernas boca abajo.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.espalda, MuscleGroup.gluteos],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.5,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate boca abajo con brazos y piernas extendidos',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva brazos, pecho y piernas del suelo simultáneamente',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Sostén 2 segundos en la cima y baja controladamente',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['No arquees el cuello, mira al suelo', 'Controla el descenso'],
    contraindications: ['Dolor lumbar agudo'],
  ),

  SmartExercise(
    id: 'remo_invertido',
    name: 'Remo invertido (mesa)',
    description:
        'Trabaja la espalda media jalando el pecho hacia una mesa firme.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.espalda, MuscleGroup.biceps],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 4.0,
    steps: [
      ExerciseStep(
        instruction:
            'Acuéstate debajo de una mesa firme y toma el borde con las manos',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Jala el pecho hacia la mesa manteniendo el cuerpo recto',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Baja controladamente hasta casi extender los brazos',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Cuerpo rígido como tabla', 'Junta los omóplatos al subir'],
    contraindications: ['Mesa poco estable'],
  ),

  SmartExercise(
    id: 'natacion_piso',
    name: 'Natación en el suelo',
    description:
        'Alterna brazos y piernas boca abajo activando la espalda completa.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.espalda, MuscleGroup.gluteos],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 4.0,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate boca abajo con brazos extendidos al frente',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Eleva el brazo derecho y la pierna izquierda, alterna en movimiento de natación',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Mantén el ritmo constante y el abdomen activo',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Movimiento controlado', 'Mira al piso para proteger el cuello'],
  ),

  // ─── BÍCEPS ────────────────────────────────────────────────────────────────
  SmartExercise(
    id: 'curl_botellas',
    name: 'Curl de bíceps con botellas',
    description:
        'Fortalece bíceps usando botellas de agua o mancuernas ligeras.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.biceps],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.5,
    equipment: Equipment.dumbbells,
    steps: [
      ExerciseStep(
        instruction:
            'Párate con una botella o mancuerna en cada mano, palmas al frente',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Flexiona los codos subiendo el peso al hombro',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Baja controladamente sin balancear el torso',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Codos pegados al cuerpo', 'Exhala al subir'],
  ),

  SmartExercise(
    id: 'curl_toalla',
    name: 'Curl de bíceps con toalla',
    description:
        'Ejercita bíceps usando una toalla como resistencia (fricción o banda).',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.biceps],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.0,
    equipment: Equipment.towel,
    steps: [
      ExerciseStep(
        instruction: 'Toma una toalla con ambas manos y pisa el centro',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Flexiona los codos jalando la toalla hacia el pecho',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Baja controladamente sintiendo la resistencia',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Cuanto más pises la toalla, más resistencia'],
  ),

  // ─── TRÍCEPS ───────────────────────────────────────────────────────────────
  SmartExercise(
    id: 'fondos_silla',
    name: 'Fondos en silla (tríceps)',
    description:
        'Fortalece tríceps y hombros bajando el cuerpo con apoyo en una silla.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.triceps, MuscleGroup.hombros],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 4.0,
    equipment: Equipment.chair,
    steps: [
      ExerciseStep(
        instruction: 'Apoya las manos en el borde de una silla firme',
        bodyPosition: BodyPosition.sitting,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Desliza las caderas al frente y baja doblando los codos',
        bodyPosition: BodyPosition.sitting,
      ),
      ExerciseStep(
        instruction: 'Empuja hacia arriba hasta extender los brazos',
        bodyPosition: BodyPosition.sitting,
      ),
    ],
    tips: ['Espalda cerca de la silla', 'No bajes más de lo cómodo'],
  ),

  SmartExercise(
    id: 'lagartija_diamante',
    name: 'Lagartija diamante',
    description:
        'Flexión con manos juntas que intensifica el trabajo de tríceps.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.triceps, MuscleGroup.pecho],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 8,
    metValue: 6.0,
    minBmiRequired: 18.0,
    maxBmiRecommended: 30,
    steps: [
      ExerciseStep(
        instruction:
            'Forma un rombo con pulgar e índice bajo el pecho, cuerpo en plancha',
        bodyPosition: BodyPosition.plank,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Baja el pecho hacia las manos doblando los codos',
        bodyPosition: BodyPosition.plank,
      ),
      ExerciseStep(
        instruction: 'Empuja hacia arriba exhalando',
        bodyPosition: BodyPosition.plank,
      ),
    ],
    tips: ['Codos pegados al cuerpo', 'Núcleo firme'],
    contraindications: ['Dolor de muñecas o codos'],
  ),

  SmartExercise(
    id: 'kickbacks_toalla',
    name: 'Extensión de tríceps con toalla',
    description: 'Aisla tríceps con una toalla como peso o banda.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.triceps],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.0,
    equipment: Equipment.towel,
    steps: [
      ExerciseStep(
        instruction: 'Sujeta una toalla por sus extremos formando un bucle',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Lleva las manos a la nuca con los codos apuntando arriba',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Extiende los codos jalando la toalla, vuelve a la nuca',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Codos fijos al lado de la cabeza'],
  ),

  // ─── HOMBROS ───────────────────────────────────────────────────────────────
  SmartExercise(
    id: 'elevaciones_laterales',
    name: 'Elevaciones laterales',
    description:
        'Fortalece el hombro medio elevando los brazos hacia los lados.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.hombros],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.0,
    steps: [
      ExerciseStep(
        instruction: 'Párate con brazos a los lados, palmas hacia el cuerpo',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva los brazos a la altura de los hombros',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Baja controladamente sin golpear',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Sin impulso, movimiento pausado', 'Codos ligeramente flexionados'],
  ),

  SmartExercise(
    id: 'pike_pushup',
    name: 'Flexión pica (pike push-up)',
    description:
        'Flexión con caderas elevadas que enfatiza hombros y parte alta del pecho.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.hombros, MuscleGroup.triceps],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 8,
    metValue: 5.0,
    minBmiRequired: 18.0,
    maxBmiRecommended: 32,
    steps: [
      ExerciseStep(
        instruction:
            'Forma una V invertida con el cuerpo, manos en el suelo y caderas arriba',
        bodyPosition: BodyPosition.plank,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Dobla los codos bajando la cabeza hacia el suelo',
        bodyPosition: BodyPosition.plank,
      ),
      ExerciseStep(
        instruction: 'Empuja hasta extender los brazos',
        bodyPosition: BodyPosition.plank,
      ),
    ],
    tips: ['Mirada al piso', 'Cadera siempre elevada'],
  ),

  SmartExercise(
    id: 'circulos_brazos',
    name: 'Círculos de brazos',
    description:
        'Calienta y moviliza los hombros con círculos amplios de brazos.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [MuscleGroup.hombros],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.0,
    steps: [
      ExerciseStep(
        instruction: 'Párate con brazos extendidos a los lados',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Dibuja círculos pequeños hacia adelante durante 15 seg',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Invierte el sentido otros 15 segundos',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Aumenta el tamaño del círculo progresivamente'],
  ),

  // ─── GLÚTEOS ───────────────────────────────────────────────────────────────
  SmartExercise(
    id: 'patada_gluteo',
    name: 'Patada de glúteo (4 puntos)',
    description:
        'Aisla los glúteos elevando una pierna desde la posición de cuatro puntos.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.gluteos, MuscleGroup.isquiotibiales],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.5,
    steps: [
      ExerciseStep(
        instruction: 'Apoya manos y rodillas en el suelo, espalda neutra',
        bodyPosition: BodyPosition.kneeling,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Eleva una pierna con la rodilla doblada empujando el talón al techo',
        bodyPosition: BodyPosition.kneeling,
      ),
      ExerciseStep(
        instruction: 'Baja sin tocar el suelo y repite, luego cambia de pierna',
        bodyPosition: BodyPosition.kneeling,
      ),
    ],
    tips: ['Cadera cuadrada, sin girar', 'Aprieta el glúteo en la cima'],
  ),

  SmartExercise(
    id: 'abduccion_lateral',
    name: 'Abducción de cadera de lado',
    description: 'Fortalece el glúteo medio mejorando estabilidad de cadera.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.gluteos],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.0,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate de lado con las piernas extendidas',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva la pierna superior sin inclinar el torso',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Baja controladamente y repite, luego cambia de lado',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Movimiento vertical, sin balanceo'],
  ),

  SmartExercise(
    id: 'sentadilla_sumo',
    name: 'Sentadilla sumo',
    description:
        'Sentadilla con postura ancha que activa glúteos y adductores.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [
      MuscleGroup.gluteos,
      MuscleGroup.cuadriceps,
      MuscleGroup.isquiotibiales,
    ],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 5.0,
    steps: [
      ExerciseStep(
        instruction:
            'Párate con pies más anchos que los hombros y puntas hacia afuera',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Baja como si te sentaras manteniendo el pecho arriba',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Empuja con todo el pie para subir',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Rodillas siguiendo la dirección de las puntas'],
  ),

  // ─── ISQUIOTIBIALES ────────────────────────────────────────────────────────
  SmartExercise(
    id: 'peso_muerto_una_pierna',
    name: 'Peso muerto a una pierna',
    description: 'Fortalece isquiotibiales y glúteos mejorando el equilibrio.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.isquiotibiales, MuscleGroup.gluteos],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 8,
    metValue: 4.0,
    steps: [
      ExerciseStep(
        instruction: 'Párate sobre una pierna con leve flexión de rodilla',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Inclina el torso al frente llevando la otra pierna atrás',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Regresa erguido apretando el glúteo',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Espalda recta', 'Apóyate en una pared si pierdes el equilibrio'],
  ),

  SmartExercise(
    id: 'puente_una_pierna',
    name: 'Puente de glúteo a una pierna',
    description:
        'Puente con una pierna elevada para intensificar glúteos e isquios.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.gluteos, MuscleGroup.isquiotibiales],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 4.0,
    steps: [
      ExerciseStep(
        instruction:
            'Acuéstate boca arriba con una pierna flexionada y la otra extendida',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva la cadera empujando con el talón apoyado',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Baja controladamente y repite, luego cambia de pierna',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Cadera recta, sin desnivel', 'Aprieta glúteo en la cima'],
  ),

  SmartExercise(
    id: 'curl_femoral_deslizante',
    name: 'Curl femoral deslizante',
    description:
        'Con una toalla bajo los talones, desliza los pies hacia el glúteo.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.isquiotibiales],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 3.5,
    equipment: Equipment.towel,
    steps: [
      ExerciseStep(
        instruction:
            'Acuéstate boca arriba con una toalla bajo los talones, rodillas extendidas',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Desliza los pies hacia los glúteos doblando las rodillas',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Desliza de regreso a la posición inicial',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Cadera elevada durante todo el movimiento'],
  ),

  // ─── PANTORRILLAS ──────────────────────────────────────────────────────────
  SmartExercise(
    id: 'elevacion_pantorrillas',
    name: 'Elevación de pantorrillas',
    description: 'Fortalece las pantorrillas subiendo y bajando de puntas.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.pantorrillas],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 20,
    metValue: 3.0,
    steps: [
      ExerciseStep(
        instruction: 'Párate con los pies a ancho de caderas',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva los talones quedando de puntas',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Baja lentamente y repite',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Sostén 1 segundo arriba', 'Apóyate en una pared si es necesario'],
  ),

  SmartExercise(
    id: 'saltar_cuerda',
    name: 'Saltar la cuerda',
    description:
        'Cardio intenso de bajo costo que quema muchas calorías por minuto.',
    category: ExerciseCategory.cardio,
    muscleGroups: [MuscleGroup.pantorrillas, MuscleGroup.cuerpoCompleto],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 10.0,
    equipment: Equipment.rope,
    steps: [
      ExerciseStep(
        instruction: 'Sostén la cuerda con los codos pegados al cuerpo',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Salta apenas para que la cuerda pase bajo los pies',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction:
            'Aterriza suave en la punta de los pies manteniendo el ritmo',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Salta bajo, no rebotes de más', 'Alterna pies si te cansa'],
    contraindications: ['Problemas severos de rodilla o tobillo'],
  ),

  // ─── CORE AVANZADO ─────────────────────────────────────────────────────────
  SmartExercise(
    id: 'v_ups',
    name: 'V-ups (toque de pies)',
    description:
        'Eleva simultáneamente torso y piernas formando una V con el cuerpo.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 4.5,
    minBmiRequired: 17.0,
    maxBmiRecommended: 32,
    steps: [
      ExerciseStep(
        instruction:
            'Acuéstate boca arriba con brazos extendidos atrás de la cabeza',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva piernas y torso tocando los pies con las manos',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Baja controladamente sin tocar el suelo',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Exhala al subir', 'Si es difícil, dobla las rodillas'],
  ),

  SmartExercise(
    id: 'russian_twist',
    name: 'Russian twist',
    description: 'Rotaciones de tronco que activan los oblicuos.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 16,
    metValue: 4.0,
    steps: [
      ExerciseStep(
        instruction:
            'Siéntate con rodillas flexionadas y torso ligeramente atrás',
        bodyPosition: BodyPosition.sitting,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Rota el torso de un lado al otro tocando el suelo',
        bodyPosition: BodyPosition.sitting,
      ),
      ExerciseStep(
        instruction: 'Mantén los pies despegados si puedes',
        bodyPosition: BodyPosition.sitting,
      ),
    ],
    tips: ['Movimiento desde la cintura, no desde los brazos'],
  ),

  SmartExercise(
    id: 'plancha_lateral',
    name: 'Plancha lateral',
    description: 'Fortalece oblicuos y estabilizadores del core.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen, MuscleGroup.hombros],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 3.5,
    steps: [
      ExerciseStep(
        instruction: 'Apoya un antebrazo y el costado del pie en el suelo',
        bodyPosition: BodyPosition.plank,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva la cadera formando una línea recta',
        bodyPosition: BodyPosition.plank,
      ),
      ExerciseStep(
        instruction: 'Mantén sin que la cadera caiga y cambia de lado',
        bodyPosition: BodyPosition.plank,
      ),
    ],
    tips: ['Hombro alineado bajo el codo', 'Core tenso'],
  ),

  SmartExercise(
    id: 'dead_bug',
    name: 'Dead bug',
    description:
        'Ejercicio de core que extiende brazo y pierna opuestos sin arquear la espalda.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen, MuscleGroup.espalda],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.5,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate boca arriba, rodillas a 90° y brazos al techo',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Extiende el brazo derecho y la pierna izquierda sin tocar el suelo',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Regresa al centro y alterna lados',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Espalda baja pegada al suelo en todo momento'],
  ),

  SmartExercise(
    id: 'elevacion_piernas',
    name: 'Elevación de piernas',
    description: 'Fortalece el abdomen inferior elevando las piernas.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.8,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate boca arriba con las piernas extendidas',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva las piernas hasta los 90° sin arquear la espalda',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Baja lentamente casi hasta tocar el suelo',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Espalda baja apoyada', 'Baja lento para mayor activación'],
  ),

  // ─── CARDIO ADICIONAL ──────────────────────────────────────────────────────
  SmartExercise(
    id: 'rodillas_altas',
    name: 'Rodillas altas',
    description: 'Corre en el lugar elevando las rodillas hasta la cadera.',
    category: ExerciseCategory.cardio,
    muscleGroups: [MuscleGroup.cuadriceps, MuscleGroup.cuerpoCompleto],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 8.0,
    maxBmiRecommended: 36,
    steps: [
      ExerciseStep(
        instruction: 'Párate erguido y comienza a correr en el lugar',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva cada rodilla hasta la altura de la cadera',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Mueve los brazos al ritmo y mantén la velocidad',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Sube los brazos también', 'Aterriza suave'],
  ),

  SmartExercise(
    id: 'talones_gluteos',
    name: 'Talones a glúteos',
    description: 'Corre en el lugar llevando los talones hacia los glúteos.',
    category: ExerciseCategory.cardio,
    muscleGroups: [MuscleGroup.isquiotibiales, MuscleGroup.pantorrillas],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 8.0,
    maxBmiRecommended: 36,
    steps: [
      ExerciseStep(
        instruction: 'Párate erguido y corre en el lugar',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Lleva el talón derecho al glúteo, luego el izquierdo',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Alterna rápido y mantén el torso erguido',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Ritmo rápido y continuo'],
  ),

  SmartExercise(
    id: 'boxeo_sombra',
    name: 'Boxeo de sombra',
    description:
        'Golpea al aire combinando jab, cross y esquives para cardio total.',
    category: ExerciseCategory.cardio,
    muscleGroups: [MuscleGroup.hombros, MuscleGroup.cuerpoCompleto],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.seconds,
    baseQuantity: 45,
    metValue: 7.5,
    steps: [
      ExerciseStep(
        instruction: 'Párate con los puños en guardia',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Lanza golpes rectos alternando manos con pequeños giros de cadera',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Añade esquives y desplazamientos laterales',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Mantén el ritmo', 'Gira la cadera en cada golpe'],
  ),

  SmartExercise(
    id: 'esqui_nordico',
    name: 'Esquí de fondo (en el lugar)',
    description: 'Simula esquiar con saltos laterales de pies juntos.',
    category: ExerciseCategory.cardio,
    muscleGroups: [MuscleGroup.cuerpoCompleto, MuscleGroup.pantorrillas],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 6.0,
    maxBmiRecommended: 34,
    steps: [
      ExerciseStep(
        instruction: 'Párate con pies juntos y brazos al frente',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Salta llevando ambos pies juntos hacia la derecha y la izquierda',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Balancea los brazos como si usaras bastones',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Saltos pequeños y continuos'],
  ),

  // ─── FLEXIBILIDAD / YOGA ADICIONAL ─────────────────────────────────────────
  SmartExercise(
    id: 'perro_boca_abajo',
    name: 'Perro boca abajo (yoga)',
    description:
        'Postura de yoga que estira espalda, hombros e isquiotibiales.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [
      MuscleGroup.espalda,
      MuscleGroup.isquiotibiales,
      MuscleGroup.hombros,
    ],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 45,
    metValue: 2.5,
    steps: [
      ExerciseStep(
        instruction: 'Apoya manos y pies, formando una V invertida',
        bodyPosition: BodyPosition.plank,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Empuja el suelo con las manos y estira la espalda',
        bodyPosition: BodyPosition.plank,
      ),
      ExerciseStep(
        instruction:
            'Alterna pedalear con los talones para estirar pantorrillas',
        bodyPosition: BodyPosition.plank,
      ),
    ],
    tips: [
      'Mantén la respiración fluida',
      'Los talones no tienen que tocar el suelo',
    ],
  ),

  SmartExercise(
    id: 'postura_arbol',
    name: 'Postura del árbol (yoga)',
    description:
        'Postura de equilibrio que mejora la estabilidad y la concentración.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [MuscleGroup.cuadriceps, MuscleGroup.cuerpoCompleto],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.5,
    steps: [
      ExerciseStep(
        instruction:
            'Párate sobre una pierna y apoya la planta del otro pie en el muslo',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Junta las palmas frente al pecho',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction:
            'Mantén el equilibrio respirando profundo, cambia de pierna',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Fija la mirada en un punto', 'No apoyes el pie en la rodilla'],
  ),

  SmartExercise(
    id: 'gato_vaca',
    name: 'Gato-vaca (yoga)',
    description: 'Moviliza la columna alternando arqueo y redondeo.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [MuscleGroup.espalda, MuscleGroup.abdomen],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 2.5,
    steps: [
      ExerciseStep(
        instruction: 'Apoya manos y rodillas con la espalda neutra',
        bodyPosition: BodyPosition.kneeling,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Arquea la espalda hacia abajo levantando la mirada (vaca)',
        bodyPosition: BodyPosition.kneeling,
      ),
      ExerciseStep(
        instruction:
            'Redondea la espalda hacia arriba metiendo el ombligo (gato)',
        bodyPosition: BodyPosition.kneeling,
      ),
    ],
    tips: ['Coordina con la respiración', 'Movimiento lento y fluido'],
  ),

  SmartExercise(
    id: 'estiramiento_isquios',
    name: 'Estiramiento de isquiotibiales',
    description: 'Estira la parte posterior del muslo sentado.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [MuscleGroup.isquiotibiales],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 45,
    metValue: 2.0,
    steps: [
      ExerciseStep(
        instruction: 'Siéntate con una pierna extendida y la otra doblada',
        bodyPosition: BodyPosition.sitting,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Inclínate al frente desde la cadera alcanzando el pie',
        bodyPosition: BodyPosition.sitting,
      ),
      ExerciseStep(
        instruction: 'Mantén 45 segundos y cambia de pierna',
        bodyPosition: BodyPosition.sitting,
      ),
    ],
    tips: ['Espalda recta', 'No rebotes, mantén la posición'],
  ),

  SmartExercise(
    id: 'estiramiento_pecho',
    name: 'Estiramiento de pecho',
    description: 'Abre el pecho y alivia la tensión de hombros.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [MuscleGroup.pecho, MuscleGroup.hombros],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 45,
    metValue: 2.0,
    steps: [
      ExerciseStep(
        instruction: 'Párate y junta las manos detrás de la espalda',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Extiende los brazos y abre el pecho',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Mantén y respira profundamente',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: [
      'No levantes los hombros',
      'Aumenta el estiramiento uniendo los omóplatos',
    ],
  ),

  SmartExercise(
    id: 'torsion_sentado',
    name: 'Torsión espinal sentado',
    description: 'Moviliza la columna y alivia la tensión lumbar.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [MuscleGroup.espalda],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.0,
    steps: [
      ExerciseStep(
        instruction: 'Siéntate con la espalda recta',
        bodyPosition: BodyPosition.sitting,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Gira el torso hacia la derecha apoyando la mano contraria en la rodilla',
        bodyPosition: BodyPosition.sitting,
      ),
      ExerciseStep(
        instruction: 'Mantén 30 segundos y repite al otro lado',
        bodyPosition: BodyPosition.sitting,
      ),
    ],
    tips: ['Inhala para crecer, exhala para girar'],
  ),

  SmartExercise(
    id: 'movilidad_tobillo',
    name: 'Movilidad de tobillo',
    description: 'Mejora el rango de movimiento del tobillo.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [MuscleGroup.pantorrillas],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 2.5,
    steps: [
      ExerciseStep(
        instruction: 'Párate frente a una pared apoyando las manos',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Desliza una rodilla hacia la pared sin levantar el talón',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Vuelve y alterna, 10 por cada tobillo',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Talón siempre en el suelo', 'Aumenta la cercanía a la pared'],
  ),

  SmartExercise(
    id: 'movilidad_hombro_toalla',
    name: 'Movilidad de hombro con toalla',
    description: 'Mejora la movilidad del hombro con una toalla.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [MuscleGroup.hombros],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.0,
    equipment: Equipment.towel,
    steps: [
      ExerciseStep(
        instruction: 'Toma una toalla con ambas manos por detrás de la espalda',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Sube una mano y baja la otra alternando la posición',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Mantén 30 segundos y cambia de lado',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Sin dolor, movimientos suaves'],
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
