import 'smart_exercise.model.dart';

/// Banco ampliado de ejercicios inteligentes.
///
/// Se suma a la biblioteca base en [smartExercisesLibrary]
/// (ver `smart_exercise.data.dart`). Cubre cardio, fuerza, core,
/// flexibilidad, movilidad y HIIT con distintos equipamientos e intensidades.
const List<SmartExercise> smartExercisesExtra = [
  // ─── CARDIO ───────────────────────────────────────────────────────────────
  SmartExercise(
    id: 'sentadilla_salto',
    name: 'Sentadilla con salto (jump squat)',
    description:
        'Sentadilla explosiva con salto: cardio y fuerza de piernas a la vez.',
    category: ExerciseCategory.cardio,
    muscleGroups: [
      MuscleGroup.cuadriceps,
      MuscleGroup.gluteos,
      MuscleGroup.pantorrillas,
    ],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 8.0,
    maxBmiRecommended: 32,
    steps: [
      ExerciseStep(
        instruction: 'Párate con pies a ancho de hombros',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Baja en sentadilla y salta explosivamente',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Aterriza suave en cuclillas y repite',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: [
      'Aterriza con rodillas flexionadas',
      'Usa los brazos para impulsarte',
    ],
    contraindications: ['Problemas de rodilla o tobillo'],
  ),
  SmartExercise(
    id: 'skaters',
    name: 'Patinador (skaters)',
    description: 'Saltos laterales alternos que trabajan piernas y cadera.',
    category: ExerciseCategory.cardio,
    muscleGroups: [
      MuscleGroup.gluteos,
      MuscleGroup.cuadriceps,
      MuscleGroup.pantorrillas,
    ],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 16,
    metValue: 6.0,
    maxBmiRecommended: 34,
    steps: [
      ExerciseStep(
        instruction: 'Párate con el peso sobre una pierna, la otra atrás',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Salta lateralmente aterrizando en la otra pierna',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Alterna de un lado a otro con ritmo fluido',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Amplitud media, no te fuerces', 'Balancea los brazos al saltar'],
  ),
  SmartExercise(
    id: 'correr_escaleras',
    name: 'Subir escaleras',
    description: 'Cardio intenso de bajo impacto que fortalece piernas.',
    category: ExerciseCategory.cardio,
    muscleGroups: [
      MuscleGroup.cuadriceps,
      MuscleGroup.gluteos,
      MuscleGroup.pantorrillas,
    ],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.seconds,
    baseQuantity: 60,
    metValue: 9.0,
    equipment: Equipment.step,
    steps: [
      ExerciseStep(
        instruction: 'Colócate frente a unas escaleras o escalón firme',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Sube y baja de manera continua y controlada',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Apoya el pie completo y usa el pasamanos si es necesario',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Mantén un ritmo constante', 'Cuida la rodilla al bajar'],
  ),
  SmartExercise(
    id: 'sprint_lugar',
    name: 'Sprint en el lugar',
    description:
        'Corre a máxima velocidad en el sitio durante intervalos cortos.',
    category: ExerciseCategory.cardio,
    muscleGroups: [MuscleGroup.cuerpoCompleto, MuscleGroup.pantorrillas],
    intensity: IntensityLevel.muy_alta,
    metric: ExerciseMetric.seconds,
    baseQuantity: 20,
    metValue: 10.0,
    maxBmiRecommended: 30,
    steps: [
      ExerciseStep(
        instruction: 'Párate erguido en posición de carrera',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Corre lo más rápido posible en el lugar 20 segundos',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Descansa y repite los intervalos necesarios',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Brazos en ángulo de 90°', 'Aterriza con la punta del pie'],
    contraindications: ['Cardiopatía sin control médico'],
  ),
  SmartExercise(
    id: 'escalador_bajo',
    name: 'Escalador lento (bajo impacto)',
    description: 'Versión suave de mountain climbers para el core y el cardio.',
    category: ExerciseCategory.cardio,
    muscleGroups: [
      MuscleGroup.abdomen,
      MuscleGroup.cuadriceps,
      MuscleGroup.hombros,
    ],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 6.0,
    maxBmiRecommended: 36,
    steps: [
      ExerciseStep(
        instruction: 'Apoya manos y rodillas en el suelo',
        bodyPosition: BodyPosition.kneeling,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Alterna rodillas al pecho de forma lenta y controlada',
        bodyPosition: BodyPosition.kneeling,
      ),
      ExerciseStep(
        instruction: 'Mantén la espalda neutra y el abdomen activo',
        bodyPosition: BodyPosition.kneeling,
      ),
    ],
    tips: ['Movimiento lento = más control', 'No arquees la espalda'],
  ),
  SmartExercise(
    id: 'burpee_sin_flexion',
    name: 'Burpee sin flexión',
    description:
        'Burpee modificado sin lagartija, ideal para nivel intermedio.',
    category: ExerciseCategory.hiit,
    muscleGroups: [MuscleGroup.cuerpoCompleto],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 8,
    metValue: 8.0,
    maxBmiRecommended: 32,
    steps: [
      ExerciseStep(
        instruction: 'Párate erguido con pies juntos',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Baja en cuclillas y apoya las manos',
        bodyPosition: BodyPosition.kneeling,
      ),
      ExerciseStep(
        instruction: 'Salta los pies atrás a plancha y regresa saltando',
        bodyPosition: BodyPosition.plank,
      ),
      ExerciseStep(
        instruction: 'Salta hacia arriba y repite',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Controla la cadera al saltar atrás', 'Aterriza suave'],
  ),
  SmartExercise(
    id: 'zancada_salto',
    name: 'Zancada con salto (jumping lunge)',
    description: 'Zancadas explosivas alternadas que elevan el ritmo cardíaco.',
    category: ExerciseCategory.hiit,
    muscleGroups: [
      MuscleGroup.cuadriceps,
      MuscleGroup.gluteos,
      MuscleGroup.pantorrillas,
    ],
    intensity: IntensityLevel.muy_alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 8,
    metValue: 8.5,
    maxBmiRecommended: 30,
    steps: [
      ExerciseStep(
        instruction: 'Da una zancada al frente',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Salta cambiando la posición de las piernas en el aire',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Aterriza en zancada con la pierna opuesta al frente',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Rodilla trasera cerca del suelo', 'Ritmo constante'],
    contraindications: ['Lesiones de rodilla o tobillo'],
  ),
  SmartExercise(
    id: 'tuck_jump',
    name: 'Salto con rodillas al pecho (tuck jump)',
    description: 'Salto vertical llevando las rodillas al pecho.',
    category: ExerciseCategory.hiit,
    muscleGroups: [
      MuscleGroup.cuadriceps,
      MuscleGroup.abdomen,
      MuscleGroup.pantorrillas,
    ],
    intensity: IntensityLevel.muy_alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 8,
    metValue: 8.5,
    maxBmiRecommended: 28,
    steps: [
      ExerciseStep(
        instruction: 'Párate con pies juntos',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Salta hacia arriba llevando las rodillas al pecho',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Aterriza suave y repite inmediatamente',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Salta alto, no solo rápido', 'Absorbe el impacto con las rodillas'],
    contraindications: ['Hipertensión no controlada'],
  ),
  SmartExercise(
    id: 'star_jump',
    name: 'Salto estrella (star jump)',
    description: 'Salto con brazos y piernas abiertas en forma de estrella.',
    category: ExerciseCategory.hiit,
    muscleGroups: [MuscleGroup.cuerpoCompleto, MuscleGroup.hombros],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 8,
    metValue: 8.0,
    maxBmiRecommended: 30,
    steps: [
      ExerciseStep(
        instruction: 'Párate con pies juntos y brazos al lado',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Salta abriendo brazos y piernas en X',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Regresa cerrando al aterrizar',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Amplitud amplia pero controlada', 'Aterriza suave'],
  ),

  // ─── FUERZA ───────────────────────────────────────────────────────────────
  SmartExercise(
    id: 'hip_thrust',
    name: 'Empuje de cadera (hip thrust)',
    description: 'Fortalecimiento potente de glúteos con apoyo en el suelo.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.gluteos, MuscleGroup.isquiotibiales],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 15,
    metValue: 4.5,
    steps: [
      ExerciseStep(
        instruction:
            'Acuéstate boca arriba con la espalda alta apoyada en una silla o banca',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva la cadera hasta alinear con los hombros',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Aprieta los glúteos en la cima y baja controlado',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Barbilla ligeramente recogida', 'Talones firmes en el piso'],
  ),
  SmartExercise(
    id: 'press_hombro_botellas',
    name: 'Press de hombro con botellas',
    description: 'Empuja peso sobre la cabeza para trabajar hombros y brazos.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.hombros, MuscleGroup.triceps],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.5,
    equipment: Equipment.dumbbells,
    steps: [
      ExerciseStep(
        instruction:
            'Sostén una botella o mancuerna en cada mano a la altura del hombro',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Empuja el peso hacia arriba hasta extender los brazos',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Baja controlado a la posición inicial',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Core firme, no arquees la espalda', 'Exhala al subir'],
  ),
  SmartExercise(
    id: 'remo_toalla_fija',
    name: 'Remo con toalla fija',
    description:
        'Remo en dos tiempos contra una toalla anclada para la espalda.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.espalda, MuscleGroup.biceps],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.5,
    equipment: Equipment.towel,
    steps: [
      ExerciseStep(
        instruction: 'Ancla una toalla a una puerta firme o baranda',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Jala la toalla hacia el pecho juntando los omóplatos',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Extiende los brazos de forma controlada',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Torso erguido', 'Movimiento amplio y lento'],
  ),
  SmartExercise(
    id: 'aperturas_pecho_botellas',
    name: 'Aperturas de pecho con botellas',
    description: 'Abre los brazos con peso ligero para trabajar el pecho.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.pecho, MuscleGroup.hombros],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.0,
    equipment: Equipment.dumbbells,
    steps: [
      ExerciseStep(
        instruction:
            'Acuéstate boca arriba con una botella en cada mano al frente',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Abre los brazos en arco hasta sentir el estiramiento del pecho',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Junta las botellas sobre el pecho y repite',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Codos ligeramente flexionados', 'Movimiento lento'],
  ),
  SmartExercise(
    id: 'wall_sit',
    name: 'Sentadilla isométrica contra la pared (wall sit)',
    description: 'Mantén la posición de sentadilla contra la pared.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.cuadriceps, MuscleGroup.gluteos],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 3.5,
    equipment: Equipment.wall,
    steps: [
      ExerciseStep(
        instruction: 'Apoya la espalda en la pared con pies a ancho de hombros',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Desliza la espalda hasta que los muslos queden paralelos',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Mantén la posición respirando de forma continua',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Rodillas a 90°', 'Pies un poco adelante de la pared'],
  ),
  SmartExercise(
    id: 'peso_muerto_rumano',
    name: 'Peso muerto rumano',
    description:
        'Inclina el torso con piernas casi rectas para isquiotibiales.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [
      MuscleGroup.isquiotibiales,
      MuscleGroup.gluteos,
      MuscleGroup.espalda,
    ],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 4.0,
    steps: [
      ExerciseStep(
        instruction: 'Párate erguido con una botella o peso en cada mano',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Inclina el torso al frente deslizando el peso por las piernas',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Vuelve a erguirte apretando glúteos',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Espalda recta', 'Siente el estiramiento en los isquios'],
  ),
  SmartExercise(
    id: 'sentadilla_pistol_silla',
    name: 'Sentadilla a una pierna con apoyo (pistol con silla)',
    description: 'Sentadilla unilateral asistida con una silla.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.cuadriceps, MuscleGroup.gluteos],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 6,
    metValue: 4.5,
    equipment: Equipment.chair,
    minBmiRequired: 17.0,
    maxBmiRecommended: 34,
    steps: [
      ExerciseStep(
        instruction:
            'Párate frente a una silla y extiende una pierna al frente',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Baja sentándote en la silla con una sola pierna',
        bodyPosition: BodyPosition.sitting,
      ),
      ExerciseStep(
        instruction: 'Empuja con la pierna apoyada para subir y repite',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Usa los brazos para equilibrio', 'Cambia de pierna'],
  ),
  SmartExercise(
    id: 'fondos_banco',
    name: 'Fondos en banco para pecho (bench dips)',
    description: 'Fondos apoyados en un banco que enfatizan tríceps y pecho.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.triceps, MuscleGroup.pecho, MuscleGroup.hombros],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 4.5,
    equipment: Equipment.chair,
    minBmiRequired: 17.0,
    maxBmiRecommended: 34,
    steps: [
      ExerciseStep(
        instruction:
            'Apoya las manos en el borde de un banco, piernas extendidas',
        bodyPosition: BodyPosition.sitting,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Baja doblando los codos hasta los 90°',
        bodyPosition: BodyPosition.sitting,
      ),
      ExerciseStep(
        instruction: 'Empuja hacia arriba y repite',
        bodyPosition: BodyPosition.sitting,
      ),
    ],
    tips: ['Codos apuntando atrás', 'No bajes más de lo cómodo'],
  ),
  SmartExercise(
    id: 'curl_martillo',
    name: 'Curl martillo con botellas',
    description: 'Curl de bíceps con agarre neutro (palmas hacia adentro).',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.biceps],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.5,
    equipment: Equipment.dumbbells,
    steps: [
      ExerciseStep(
        instruction: 'Sostén una botella en cada mano con palmas hacia adentro',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Flexiona los codos subiendo el peso sin girar la muñeca',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Baja controlado y repite',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Codos pegados al torso', 'Sin balanceo'],
  ),
  SmartExercise(
    id: 'extension_triceps_press',
    name: 'Extensión de tríceps sobre la cabeza',
    description: 'Extiende los codos con peso sobre la cabeza.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.triceps],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.0,
    equipment: Equipment.dumbbells,
    steps: [
      ExerciseStep(
        instruction: 'Sostén una botella con ambas manos detrás de la cabeza',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Extiende los codos subiendo el peso',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Baja controlado detrás de la cabeza',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Codos apuntando al frente', 'Espalda recta'],
  ),
  SmartExercise(
    id: 'face_pull_toalla',
    name: 'Jalón facial con toalla',
    description: 'Trabaja hombros y trapecios con tracción controlada.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.hombros, MuscleGroup.espalda],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.0,
    equipment: Equipment.towel,
    steps: [
      ExerciseStep(
        instruction: 'Toma una toalla con ambas manos a la altura del pecho',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Jala hacia la cara separando los codos',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Regresa de forma controlada',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Junta los omóplatos', 'Movimiento en línea horizontal'],
  ),
  SmartExercise(
    id: 'encogimiento_hombros',
    name: 'Encogimiento de hombros (shrugs)',
    description: 'Eleva los hombros con peso para trapecios.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.hombros],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 15,
    metValue: 3.0,
    equipment: Equipment.dumbbells,
    steps: [
      ExerciseStep(
        instruction: 'Sostén una botella en cada mano al lado del cuerpo',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva los hombros hacia las orejas',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Mantén 1 segundo y baja controlado',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['No gires los hombros', 'Movimiento vertical'],
  ),
  SmartExercise(
    id: 'remo_banda',
    name: 'Remo con banda elástica',
    description: 'Jala una banda hacia el pecho para la espalda.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.espalda, MuscleGroup.biceps],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 4.0,
    equipment: Equipment.resistanceBand,
    steps: [
      ExerciseStep(
        instruction: 'Ancla la banda a un punto fijo y sostén cada extremo',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Jala los codos hacia atrás juntando los omóplatos',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Extiende los brazos contra la resistencia',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Torso erguido', 'Controla la vuelta'],
  ),
  SmartExercise(
    id: 'peso_muerto_sumo',
    name: 'Peso muerto sumo',
    description: 'Levanta el peso con postura ancha enfatizando glúteos.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [
      MuscleGroup.gluteos,
      MuscleGroup.isquiotibiales,
      MuscleGroup.cuadriceps,
    ],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 4.5,
    steps: [
      ExerciseStep(
        instruction: 'Párate con pies anchos y puntas hacia afuera',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Agacha con espalda recta y toma el peso',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Empuja el piso y erguete apretando glúteos',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Pecho arriba', 'Peso pegado al cuerpo'],
  ),
  SmartExercise(
    id: 'press_pecho_suelo',
    name: 'Press de pecho en el suelo',
    description: 'Press de pecho con botellas apoyado en el piso.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.pecho, MuscleGroup.triceps, MuscleGroup.hombros],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.5,
    equipment: Equipment.dumbbells,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate boca arriba con una botella en cada mano',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Empuja el peso hacia arriba extendiendo los brazos',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Baja controlado hasta tocar el pecho',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Codoss a 45° del torso', 'No rebotes'],
  ),
  SmartExercise(
    id: 'zancada_lateral',
    name: 'Zancada lateral',
    description: 'Zancada hacia los lados para glúteos y adductores.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.gluteos, MuscleGroup.cuadriceps],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 4.0,
    steps: [
      ExerciseStep(
        instruction: 'Párate con pies juntos',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Da un paso amplio al lado y baja en sentadilla',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Empuja para volver al centro y alterna',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Rodilla sigue la dirección del pie', 'Torso erguido'],
  ),
  SmartExercise(
    id: 'sentadilla_copa',
    name: 'Sentadilla copa (goblet squat)',
    description: 'Sentadilla sosteniendo un peso frente al pecho.',
    category: ExerciseCategory.fuerza,
    muscleGroups: [MuscleGroup.cuadriceps, MuscleGroup.gluteos],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 4.0,
    equipment: Equipment.dumbbells,
    steps: [
      ExerciseStep(
        instruction:
            'Sostén una botella o peso con ambas manos frente al pecho',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Baja en sentadilla manteniendo el pecho arriba',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Empuja con los talones para subir',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Codos dentro de las rodillas', 'Espalda recta'],
  ),
  SmartExercise(
    id: 'elevacion_gluteo_rodilla',
    name: 'Elevación de glúteo con rodilla extendida',
    description: 'Aisla glúteos extendiendo la pierna desde cuatro puntos.',
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
            'Extiende la pierna hacia atrás y arriba con la rodilla recta',
        bodyPosition: BodyPosition.kneeling,
      ),
      ExerciseStep(
        instruction: 'Baja sin tocar el suelo y alterna de pierna',
        bodyPosition: BodyPosition.kneeling,
      ),
    ],
    tips: ['Cadera quieta', 'Aprieta el glúteo en la cima'],
  ),

  // ─── CORE ─────────────────────────────────────────────────────────────────
  SmartExercise(
    id: 'bird_dog',
    name: 'Bird dog',
    description: 'Extiende brazo y pierna opuestos fortaleciendo el core.',
    category: ExerciseCategory.core,
    muscleGroups: [
      MuscleGroup.abdomen,
      MuscleGroup.espalda,
      MuscleGroup.gluteos,
    ],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 3.0,
    steps: [
      ExerciseStep(
        instruction: 'Apoya manos y rodillas en el suelo',
        bodyPosition: BodyPosition.kneeling,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Extiende el brazo derecho y la pierna izquierda',
        bodyPosition: BodyPosition.kneeling,
      ),
      ExerciseStep(
        instruction: 'Sostén 2 segundos y alterna lados',
        bodyPosition: BodyPosition.kneeling,
      ),
    ],
    tips: ['Cadera y hombros cuadrados', 'No arquees la espalda'],
  ),
  SmartExercise(
    id: 'hollow_hold',
    name: 'Hollow hold',
    description: 'Isométrico de core que fortalece el abdomen profundo.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.seconds,
    baseQuantity: 20,
    metValue: 3.5,
    steps: [
      ExerciseStep(
        instruction:
            'Acuéstate boca arriba y eleva hombros y piernas del suelo',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Mantén la espalda baja pegada al piso',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Sostén respirando de forma continua',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Brazos extendidos atrás', 'Activa el abdomen hacia adentro'],
  ),
  SmartExercise(
    id: 'crunch_reverso',
    name: 'Crunch inverso',
    description: 'Lleva las rodillas al pecho elevando la cadera.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 12,
    metValue: 3.5,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate boca arriba con rodillas flexionadas a 90°',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Lleva las rodillas al pecho elevando la cadera del suelo',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Baja controlado sin tocar el suelo',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Exhala al subir', 'Movimiento lento'],
  ),
  SmartExercise(
    id: 'flutter_kicks',
    name: 'Patadas de tijera (flutter kicks)',
    description: 'Patadas alternadas bajas para el abdomen inferior.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen, MuscleGroup.cuadriceps],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 3.8,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate boca arriba con las piernas elevadas a 45°',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Alterna patadas cortas y rápidas sin tocar el suelo',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Mantén la espalda baja pegada al piso',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Piernas casi rectas', 'Brazos bajo los glúteos'],
  ),
  SmartExercise(
    id: 'plancha_rodilla',
    name: 'Plancha con rodillas apoyadas',
    description: 'Plancha modificada con las rodillas en el suelo.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen, MuscleGroup.hombros],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 20,
    metValue: 3.0,
    steps: [
      ExerciseStep(
        instruction: 'Apoya antebrazos y rodillas en el suelo',
        bodyPosition: BodyPosition.kneeling,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva la cadera formando una línea recta',
        bodyPosition: BodyPosition.kneeling,
      ),
      ExerciseStep(
        instruction: 'Sostén respirando de forma continua',
        bodyPosition: BodyPosition.kneeling,
      ),
    ],
    tips: ['Cuida que la cadera no caiga', 'Menos tiempo, mejor forma'],
  ),
  SmartExercise(
    id: 'side_crunch',
    name: 'Crunch lateral',
    description: 'Fortalece los oblicuos con flexión lateral del torso.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 15,
    metValue: 3.5,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate de lado con una mano detrás de la cabeza',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva el torso llevando el codo hacia la cadera',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Baja controlado y repite, luego cambia de lado',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Movimiento lateral, no rotación', 'Codos abiertos'],
  ),
  SmartExercise(
    id: 'ab_wheel_toalla',
    name: 'Rueda abdominal con toalla',
    description: 'Estira el core deslizando una toalla bajo las manos.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen, MuscleGroup.hombros],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 8,
    metValue: 4.5,
    equipment: Equipment.towel,
    minBmiRequired: 17.0,
    maxBmiRecommended: 32,
    steps: [
      ExerciseStep(
        instruction: 'Arrodíllate con una toalla doblada bajo las manos',
        bodyPosition: BodyPosition.kneeling,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Desliza la toalla al frente extendiendo el cuerpo',
        bodyPosition: BodyPosition.kneeling,
      ),
      ExerciseStep(
        instruction: 'Regresa controlando con el abdomen',
        bodyPosition: BodyPosition.kneeling,
      ),
    ],
    tips: ['Cadera no se hunde', 'Movimiento corto al inicio'],
    contraindications: ['Dolor lumbar agudo'],
  ),
  SmartExercise(
    id: 'windshield_wiper',
    name: 'Limpiaparabrisas (windshield wiper)',
    description: 'Inclina las piernas de lado a lado para los oblicuos.',
    category: ExerciseCategory.core,
    muscleGroups: [MuscleGroup.abdomen],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 4.5,
    minBmiRequired: 17.0,
    maxBmiRecommended: 30,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate boca arriba con brazos en cruz',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction:
            'Baja las piernas dobladas hacia un lado sin tocar el suelo',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Sube y baja hacia el otro lado',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Hombros pegados al suelo', 'Controla el movimiento'],
  ),
  SmartExercise(
    id: 'mountain_climber_cruzado',
    name: 'Escalador cruzado',
    description: 'Lleva la rodilla al codo opuesto en plancha.',
    category: ExerciseCategory.core,
    muscleGroups: [
      MuscleGroup.abdomen,
      MuscleGroup.hombros,
      MuscleGroup.cuadriceps,
    ],
    intensity: IntensityLevel.moderada,
    metric: ExerciseMetric.reps,
    baseQuantity: 16,
    metValue: 6.0,
    maxBmiRecommended: 34,
    steps: [
      ExerciseStep(
        instruction: 'Posición de plancha alta',
        bodyPosition: BodyPosition.plank,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Lleva la rodilla derecha al codo izquierdo',
        bodyPosition: BodyPosition.plank,
      ),
      ExerciseStep(
        instruction: 'Alterna lados de forma controlada',
        bodyPosition: BodyPosition.plank,
      ),
    ],
    tips: ['Cadera estable', 'Más rotación que velocidad'],
  ),
  SmartExercise(
    id: 'plancha_equilibrio',
    name: 'Plancha con elevación de brazo',
    description: 'Plancha en la que extiendes un brazo al frente.',
    category: ExerciseCategory.core,
    muscleGroups: [
      MuscleGroup.abdomen,
      MuscleGroup.hombros,
      MuscleGroup.espalda,
    ],
    intensity: IntensityLevel.alta,
    metric: ExerciseMetric.seconds,
    baseQuantity: 20,
    metValue: 4.0,
    minBmiRequired: 17.0,
    steps: [
      ExerciseStep(
        instruction: 'Posición de plancha alta con manos bajo hombros',
        bodyPosition: BodyPosition.plank,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Extiende un brazo al frente manteniendo la cadera',
        bodyPosition: BodyPosition.plank,
      ),
      ExerciseStep(
        instruction: 'Alterna el brazo cada 5 segundos',
        bodyPosition: BodyPosition.plank,
      ),
    ],
    tips: ['No gires las caderas', 'Mirada al suelo'],
  ),

  // ─── FLEXIBILIDAD ──────────────────────────────────────────────────────────
  SmartExercise(
    id: 'postura_cobra',
    name: 'Postura de la cobra',
    description: 'Estira el abdomen y abre el pecho boca abajo.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [MuscleGroup.espalda, MuscleGroup.pecho],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.5,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate boca abajo con las manos bajo los hombros',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva el pecho empujando suavemente con las manos',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Mantén las caderas en el piso y respira',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Hombros lejos de las orejas', 'Sin dolor en la espalda baja'],
  ),
  SmartExercise(
    id: 'paloma',
    name: 'Postura de la paloma (yoga)',
    description: 'Estiramiento profundo de glúteos y cadera.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [MuscleGroup.gluteos, MuscleGroup.isquiotibiales],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 45,
    metValue: 2.0,
    steps: [
      ExerciseStep(
        instruction: 'Lleva una rodilla al frente y la otra pierna atrás',
        bodyPosition: BodyPosition.kneeling,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Baja la cadera y apoya el torso si puedes',
        bodyPosition: BodyPosition.kneeling,
      ),
      ExerciseStep(
        instruction: 'Sostén y cambia de lado',
        bodyPosition: BodyPosition.kneeling,
      ),
    ],
    tips: ['Cadera nivelada', 'Respira en el estiramiento'],
  ),
  SmartExercise(
    id: 'torsion_espinal_suelo',
    name: 'Torsión espinal acostado',
    description: 'Gira la espalda baja con las rodillas caídas a un lado.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [MuscleGroup.espalda, MuscleGroup.gluteos],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 45,
    metValue: 2.0,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate boca arriba con las rodillas dobladas',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Deja caer las rodillas hacia un lado',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Gira la cabeza al lado opuesto y sostén',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Hombros pegados al suelo', 'Sin forzar'],
  ),
  SmartExercise(
    id: 'estiramiento_dorsal_lado',
    name: 'Estiramiento de dorsal de lado',
    description: 'Inclina el torso al lado para estirar el dorsal.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [MuscleGroup.espalda, MuscleGroup.hombros],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.0,
    steps: [
      ExerciseStep(
        instruction: 'De pie, eleva un brazo sobre la cabeza',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Inclínate al lado opuesto sintiendo el estiramiento',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Sostén y cambia de lado',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Cadera estable', 'No te inclines al frente'],
  ),
  SmartExercise(
    id: 'postura_guerrero',
    name: 'Postura del guerrero (yoga)',
    description: 'Fortalecimiento y apertura de cadera en postura amplia.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [
      MuscleGroup.cuadriceps,
      MuscleGroup.gluteos,
      MuscleGroup.hombros,
    ],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.5,
    steps: [
      ExerciseStep(
        instruction: 'Da un paso amplio al frente con una pierna',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Gira la pierna trasera y extiende los brazos',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Mantén la postura y cambia de lado',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Rodilla delantera sobre el tobillo', 'Mirada al frente'],
  ),
  SmartExercise(
    id: 'estiramiento_biceps',
    name: 'Estiramiento de bíceps',
    description: 'Estira la parte frontal del brazo.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [MuscleGroup.biceps],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.0,
    steps: [
      ExerciseStep(
        instruction: 'Extiende el brazo con la palma hacia atrás',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Con la otra mano, jala los dedos suavemente',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Sostén y cambia de brazo',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Sin rebotes', 'Estira hasta la molestia leve'],
  ),
  SmartExercise(
    id: 'estiramiento_triceps',
    name: 'Estiramiento de tríceps',
    description: 'Estira la parte posterior del brazo sobre la cabeza.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [MuscleGroup.triceps],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.0,
    steps: [
      ExerciseStep(
        instruction: 'Lleva un brazo detrás de la cabeza',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Con la otra mano empuja el codo suavemente',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Sostén y cambia de brazo',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Codo apuntando al techo', 'Sin dolor agudo'],
  ),
  SmartExercise(
    id: 'media_luna',
    name: 'Flexión lateral de pie (media luna)',
    description: 'Estiramiento lateral de todo el torso.',
    category: ExerciseCategory.flexibilidad,
    muscleGroups: [
      MuscleGroup.espalda,
      MuscleGroup.hombros,
      MuscleGroup.abdomen,
    ],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.0,
    steps: [
      ExerciseStep(
        instruction: 'Párate con pies juntos y brazos sobre la cabeza',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Entrelaza los dedos e inclínate a un lado',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Sostén y alterna de lado',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Cadera quieta', 'Respira profundo'],
  ),

  // ─── MOVILIDAD ─────────────────────────────────────────────────────────────
  SmartExercise(
    id: 'balanceo_pierna',
    name: 'Balanceo de pierna (leg swings)',
    description: 'Balancea la pierna al frente y atrás para movilidad.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [
      MuscleGroup.isquiotibiales,
      MuscleGroup.cuadriceps,
      MuscleGroup.gluteos,
    ],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 2.5,
    steps: [
      ExerciseStep(
        instruction: 'Apóyate en una pared con una mano',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Balancea una pierna al frente y atrás con control',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Repite y cambia de pierna',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Torso erguido', 'Aumenta la amplitud poco a poco'],
  ),
  SmartExercise(
    id: 'marcha_rodilla_pecho',
    name: 'Marcha con rodilla al pecho',
    description: 'Camina llevando cada rodilla al pecho.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [MuscleGroup.gluteos, MuscleGroup.isquiotibiales],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 2.5,
    steps: [
      ExerciseStep(
        instruction: 'Párate erguido',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Lleva una rodilla al pecho sosteniéndola con las manos',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Baja y alterna de pierna',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Espalda recta', 'Excelente calentamiento'],
  ),
  SmartExercise(
    id: 'sentadilla_profunda_sostener',
    name: 'Sentadilla profunda sostenida',
    description:
        'Mantén la sentadilla profunda para movilidad de tobillo y cadera.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [
      MuscleGroup.cuadriceps,
      MuscleGroup.gluteos,
      MuscleGroup.pantorrillas,
    ],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 3.0,
    steps: [
      ExerciseStep(
        instruction: 'Baja a la sentadilla más profunda posible',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Junta los codos dentro de las rodillas',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Mantén la posición respirando',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Talones en el piso', 'Pecho arriba'],
  ),
  SmartExercise(
    id: 'movilidad_munecas',
    name: 'Movilidad de muñecas',
    description: 'Rota y flexiona las muñecas para calentar brazos.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [MuscleGroup.triceps, MuscleGroup.biceps],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.seconds,
    baseQuantity: 30,
    metValue: 2.0,
    steps: [
      ExerciseStep(
        instruction: 'Extiende los brazos al frente',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Dibuja círculos con las muñecas en un sentido',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Invierte el sentido y flexiona arriba y abajo',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Ideal antes de flexiones', 'Movimiento amplio'],
  ),
  SmartExercise(
    id: 'deslizamiento_pared',
    name: 'Deslizamiento contra la pared (wall slide)',
    description: 'Desliza los brazos por la pared para la postura de hombros.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [MuscleGroup.hombros, MuscleGroup.espalda],
    intensity: IntensityLevel.baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 2.5,
    equipment: Equipment.wall,
    steps: [
      ExerciseStep(
        instruction: 'Apoya la espalda y los brazos contra la pared',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Desliza los brazos hacia arriba sin despegar la pared',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Baja de forma controlada y repite',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Espalda baja pegada a la pared', 'Codos ligeramente flexionados'],
  ),
  SmartExercise(
    id: 'apertura_cadera_puente',
    name: 'Apertura de cadera con puente',
    description: 'Combina puente y apertura de rodilla para la cadera.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [MuscleGroup.gluteos, MuscleGroup.isquiotibiales],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 2.5,
    steps: [
      ExerciseStep(
        instruction: 'Acuéstate boca arriba con rodillas dobladas',
        bodyPosition: BodyPosition.lying,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Eleva la cadera y abre una rodilla hacia el lado',
        bodyPosition: BodyPosition.lying,
      ),
      ExerciseStep(
        instruction: 'Baja y alterna de lado',
        bodyPosition: BodyPosition.lying,
      ),
    ],
    tips: ['Controla el descenso', 'Glúteos activos'],
  ),
  SmartExercise(
    id: 'toque_talon_cuadriceps',
    name: 'Estiramiento dinámico de cuádriceps',
    description: 'Dobla la rodilla hacia atrás al caminar.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [MuscleGroup.cuadriceps],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 2.5,
    steps: [
      ExerciseStep(
        instruction: 'Camina mientras llevas un talón al glúteo',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Sostén el tobillo 1 segundo y suelta',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Alterna de pierna con cada paso',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Rodillas juntas', 'Avanza unos 10 metros'],
  ),
  SmartExercise(
    id: 'rotacion_torax',
    name: 'Rotación de tórax',
    description: 'Rota el torso con los brazos abiertos para la columna.',
    category: ExerciseCategory.movilidad,
    muscleGroups: [MuscleGroup.espalda, MuscleGroup.hombros],
    intensity: IntensityLevel.muy_baja,
    metric: ExerciseMetric.reps,
    baseQuantity: 10,
    metValue: 2.5,
    steps: [
      ExerciseStep(
        instruction: 'Párate con los brazos extendidos en cruz',
        bodyPosition: BodyPosition.standing,
        isStartPosition: true,
      ),
      ExerciseStep(
        instruction: 'Rota el torso de un lado a otro con la cadera fija',
        bodyPosition: BodyPosition.standing,
      ),
      ExerciseStep(
        instruction: 'Realiza el movimiento de forma pausada',
        bodyPosition: BodyPosition.standing,
      ),
    ],
    tips: ['Mirada siguiendo las manos', 'Cadera quieta'],
  ),
];
