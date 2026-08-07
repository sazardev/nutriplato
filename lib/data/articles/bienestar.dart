import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';
import 'package:nutriplato/infrastructure/entities/article/article_section.dart';

/// Artículos de bienestar, mitos y pautas generales.
List<Article> bienestarArticles() {
  return [
    Article(
      title: "Mitos de la nutrición: Verdades que debes saber",
      description:
          "Desmentimos los mitos alimentarios más populares con base científica",
      content:
          "Hay mucha desinformación sobre nutrición. Aquí separamos mito de realidad.",
      imageUrl: "lib/data/img/nutrition_balance.jpeg",
      color: Colors.purple,
      publishDate: DateTime.now().subtract(const Duration(days: 192)),
      tags: ["mitos", "verdad", "información"],
      sections: [
        ArticleSection(
          title: "Mito 1: 'El agua con limón desintoxica'",
          content:
              "LA VERDAD: El cuerpo ya se desintoxica solo a través del hígado y los riñones.\n\n• El agua con limón es una bebida refrescante y aporta vitamina C\n• Pero no 'expulsa toxinas' de forma especial\n• El término 'detox' es un marketing: ninguna bebida limpia tu cuerpo más de lo que tus órganos ya lo hacen\n\nLo que SÍ funciona: comer sano, beber agua y evitar toxinas reales (alcohol, tabaco).",
        ),
        ArticleSection(
          title: "Mito 2: 'El pan engorda'",
          content:
              "LA VERDAD: Ningún alimento engorda por sí solo; lo que importa es el exceso de calorías.\n\n• El pan (preferentemente integral) puede formar parte de una dieta equilibrada\n• Engorda comer pan EN EXCESO o acompañado de mantequilla, mermelada y embutidos\n• La tortilla de maíz y el pan pueden coexistir en la dieta\n\nLo importante es la porción y el balance general del día, no demonizar un alimento.",
        ),
        ArticleSection(
          title: "Mito 3: 'Comer de noche engorda'",
          content:
              "LA VERDAD: El horario de las comidas importa menos que el total de calorías del día.\n\n• Comer por la noche no convierte automáticamente las calorías en grasa\n• SÍ importa NO cenar pesado para dormir bien\n• Lo que sí engorda es comer MÁS de lo que gastas, a cualquier hora\n\nCena ligera y temprano (2-3 horas antes de dormir) por digestión y sueño, no por 'calorías nocturnas'.",
        ),
        ArticleSection(
          title: "Mito 4: 'Los alimentos light son saludables'",
          content:
              "LA VERDAD: 'Light' significa reducido en ALGO (grasa o azúcar), no que sea sano:\n\n• Un yogurt 'light' puede tener más azúcar para compensar la grasa\n• Un refresco 'zero' sigue siendo una bebida con aditivos\n• 'Light' no equivale a 'sin calorías'\n\nLee las etiquetas: compara sellos y tabla nutricional antes de confiar en la palabra 'light'.",
        ),
        ArticleSection(
          title: "Mito 5: 'Los suplementos sustituyen una buena alimentación'",
          content:
              "LA VERDAD: Los suplementos complementan, no reemplazan:\n\n• Ningún suplemento aporta la complejidad de nutrientes y fitoquímicos de los alimentos\n• Tomar vitaminas en exceso puede ser dañino\n• Los suplementos son útiles SOLO ante deficiencias reales (indicadas por un profesional)\n\nLa base siempre será una dieta variada y equilibrada. El suplemento es un apoyo, no la solución.",
        ),
      ],
    ),
    Article(
      title: "Peso saludable: Cómo lograrlo de forma sostenible",
      description:
          "El enfoque real para perder peso sin dietas milagrosas ni efecto rebote",
      content:
          "El peso saludable no es una dieta temporal: es un cambio de hábitos para siempre.",
      imageUrl: "lib/data/img/plato.png",
      color: Colors.blue,
      publishDate: DateTime.now().subtract(const Duration(days: 195)),
      tags: ["peso", "dieta", "hábitos"],
      sections: [
        ArticleSection(
          title: "Por qué fallan las dietas",
          content:
              "El 95% de las dietas restrictivas fracasan a largo plazo:\n\n• SON INSOStenibles: prohíben alimentos que disfrutas\n• CREAN EFECTO REBOTE: el cuerpo se defiende y recuperas el peso (y algo más)\n• CAUSAN CULPA Y ANSIEDAD\n• IGNORAN la conducta y las emociones\n\nLa alternativa no es una 'dieta perfecta' sino un estilo de vida que puedas mantener el resto de tu vida.",
        ),
        ArticleSection(
          title: "El déficit calórico sostenible",
          content:
              "La base es sencilla: comer un poco menos y moverse un poco más:\n\n• DÉFICIT MODERADO: 300-500 kcal al día\n• PIERDE 0.5-1kg por semana (velocidad segura y sostenible)\n• NO bajes de las calorías mínimas de salud\n\nLos déficits pequeños son los que se mantienen. Perder 0.5kg/semana durante 6 meses = 12kg, sin pasar hambre extrema.",
        ),
        ArticleSection(
          title: "La estrategia: cambios de hábitos, no sacrificios",
          content:
              "Enfócate en ACCIONES, no en restricciones:\n\n1. ELIMINA LAS CALORÍAS LÍQUIDAS: refresco, jugo, alcohol\n2. AUMENTA VERDURAS Y PROTEÍNA (saciabilidad)\n3. COME CONSCIENTE Y DESPACIO\n4. DUERME 7-8 HORAS (el mal sueño te hace comer más)\n5. MUÉVETE MÁS: camina 30 min al día\n6. SIRVE PORCIONES MÁS PEQUEÑAS\n\nEstos 6 cambios suman más que cualquier dieta milagrosa.",
        ),
        ArticleSection(
          title: "El papel de la proteína y la fibra",
          content:
              "Para no pasar hambre mientras bajas de peso:\n\n• PROTEÍNA en cada comida: da saciedad y preserva músculo (huevo, pollo, frijoles, yogurt)\n• FIBRA: llena con pocas calorías (verduras, frutas, leguminosas)\n• MUCHA AGUA: antes de comer reduce la ingesta\n• VOLUMEN: más verduras = estómago lleno con menos calorías\n\nUn plato con ½ verduras, ¼ proteína y ¼ carbohidrato es el diseño ideal para saciarte con menos.",
        ),
        ArticleSection(
          title: "Mide el progreso correctamente",
          content:
              "La báscula no lo dice todo:\n\n• EL PESO FLUCTÚA diariamente (agua, hormonas, digestión)\n• MIDE UNA VEZ POR SEMANA, a la misma hora\n• FÍJATE TAMBIÉN EN: cómo te queda la ropa, la energía, la cintura\n• NO TE CASTIGUES por semanas sin bajada (mesetas son normales)\n\nEl objetivo no es un número: es sentirte bien, con energía y sano. La báscula es solo una referencia.",
        ),
      ],
    ),
    Article(
      title: "Suplementos: Cuáles tienen evidencia y cuáles son innecesarios",
      description:
          "La guía honesta de los suplementos más populares y su respaldo científico",
      content:
          "Antes de gastar en suplementos, conoce qué dice la evidencia.",
      imageUrl: "lib/data/img/vegetables/brocoli.jpg",
      color: Colors.teal,
      publishDate: DateTime.now().subtract(const Duration(days: 198)),
      tags: ["suplementos", "vitaminas", "evidencia"],
      sections: [
        ArticleSection(
          title: "La regla de oro",
          content:
              "PRIMERO LA COMIDA, LUEGO EL SUPLEMENTO:\n\n• Los suplementos no sustituyen una buena alimentación\n• Solo se justifican ante deficiencias reales o necesidades específicas\n• La mayoría de las vitaminas sintéticas se eliminan por la orina (dinero perdido)\n• Algunos suplementos en exceso son dañinos\n\nConsulta a un profesional antes de iniciar cualquier suplemento: no todo lo que se vende es necesario.",
        ),
        ArticleSection(
          title: "Suplementos con buena evidencia",
          content:
              "Estos tienen respaldo cuando hay indicación:\n\n• VITAMINA D: el déficit es muy común en México; útil si tu análisis lo confirma\n• HIERRO Y ÁCIDO FÓLICO: en embarazo y anemia (bajo supervisión)\n• B12: en veganos y vegetarianos estrictos (obligatorio)\n• OMEGA-3: si no comes pescado\n• MAGNESIO: en deficiencia o calambres\n• PROTEÍNA EN POLVO: práctica para deportistas que no cubren requerimientos con comida\n\nEn todos los casos: indicados por un profesional, con dosis correctas y evaluando necesidad real.",
        ),
        ArticleSection(
          title: "Suplementos sobrevalorados",
          content:
              "Déjalo en la estantería si no tienes indicación:\n\n• VITAMINA C 'MEGADOSIS': el exceso se elimina; no previene gripes\n• MULTIVITAMÍNICOS GENÉRICOS: para la mayoría, innecesarios si comes variado\n• ANTIOXIDANTES AISLADOS (betacaroteno, vitamina E) en altas dosis: algunos estudios muestran que en exceso pueden ser contraproducentes\n• COLÁGENO EN POLVO: no hay evidencia sólida de que fortalezca articulaciones; el cuerpo fabrica su colágeno con proteína y vitamina C\n• QUEMADORES DE GRASA Y 'DETOX': sin evidencia y a veces peligrosos\n\nEl marketing de suplementos es enorme: la mejor 'píldora' es una dieta variada y ejercicio.",
        ),
        ArticleSection(
          title: "Precauciones y advertencias",
          content:
              "Los suplementos no son inofensivos:\n\n• PUEDEN INTERACTUAR con medicamentos (pregunta a tu médico)\n• ALGUNOS TÓXICOS en dosis altas (vitaminas liposolubles A, D, E, K se acumulan)\n• NO COMPRES en páginas no confiables ni 'milagros'\n• REPORTAR EN COFEPRIS: verifica que el producto esté registrado\n\nRegla final: duda de cualquier producto que prometa resultados milagrosos. Si fuera tan fácil, no existiría la obesidad.",
        ),
      ],
    ),
    Article(
      title: "Hábitos: Cómo construir una alimentación saludable que dure",
      description:
          "La ciencia de los hábitos aplicada a tu alimentación",
      content:
          "No necesitas fuerza de voluntad infinita: necesitas buenos sistemas y hábitos.",
      imageUrl: "lib/data/img/healthy_food_variety.jpeg",
      color: Colors.green,
      publishDate: DateTime.now().subtract(const Duration(days: 201)),
      tags: ["hábitos", "constancia", "cambio"],
      sections: [
        ArticleSection(
          title: "La ciencia del hábito",
          content:
              "Un hábito es un ciclo de 3 partes:\n\n• SEÑAL: disparador (hora, lugar, emoción)\n• RUTINA: la conducta\n• RECOMPENSA: lo que obtienes\n\nPara cambiar la alimentación, en lugar de 'decidir todos los días', crea SEÑALES y RUTINAS automáticas. Los hábitos automáticos no consumen fuerza de voluntad.",
        ),
        ArticleSection(
          title: "La regla de los 21 días (y el enfoque correcto)",
          content:
              "El famoso '21 días' es un mito: los hábitos tardan entre 2 y 8 meses según la persona.\n\nLo importante no es el número de días sino:\n\n• EMPEZAR PEQUEÑO: un cambio a la vez\n• SER CONSISTENTE: mejor poco todos los días que mucho una vez\n• AMARRAR CON HÁBITOS EXISTENTES: 'después del café, bebo un vaso de agua'\n\nEmpieza con UN cambio (por ejemplo, eliminar el refresco) y una vez que sea automático, agrega otro.",
        ),
        ArticleSection(
          title: "Diseña tu entorno para el éxito",
          content:
              "El entorno importa más que la voluntad:\n\n• NO TENGAS REFRESCO EN CASA (si no está, no se consume)\n• PON FRUTA A LA VISTA en la cocina\n• PREPARA SNACKS SALUDABLES listos\n• COME EN UN LUGAR DESTINADO (no frente a la TV)\n• HAZ LA COMPRA CON LISTA y con el estómago lleno\n\nTu cocina es tu aliado: haz que la opción saludable sea la más fácil de elegir.",
        ),
        ArticleSection(
          title: "Supera las recaídas",
          content:
              "Todos fallan a veces. La diferencia está en la respuesta:\n\n• UNA COMIDA 'mala' NO arruina tu progreso\n• VUELVE A LO SANO EN LA SIGUIENTE COMIDA (no esperes al lunes)\n• NO TE CASTIGUES: la culpa alimenta el ciclo\n• IDENTIFICA EL DISPARADOR: ¿qué te hizo recaer? adáptate\n\nEl objetivo no es la perfección, es la dirección. El 80% de buenas decisiones supera al 100% perfecto imposible.",
        ),
        ArticleSection(
          title: "Tu plan de 30 días",
          content:
              "SEMANA 1: Agua (1 vaso al despertar + eliminar refresco)\n\nSEMANA 2: Agrega 2 verduras más al día\n\nSEMANA 3: Comer sin pantallas y masticar despacio\n\nSEMANA 4: Cocinar 2 veces en casa\n\nConstruye cada semana un hábito sobre el anterior. En un mes tendrás 4 cambios reales y automáticos.\n\nRecuerda: la constancia gana a la perfección. Pequeños cambios sostenidos en el tiempo transforman tu salud.",
        ),
      ],
    ),
    Article(
      title: "Nutrición para deportistas aficionados: El fin de semana atleta",
      description:
          "Alimentación para quienes hacen ejercicio ocasional o entrenan fines de semana",
      content:
          "No necesitas ser atleta de élite para merecer una buena nutrición deportiva.",
      imageUrl: "lib/data/img/carbs_for_athletes.jpeg",
      color: Colors.indigo,
      publishDate: DateTime.now().subtract(const Duration(days: 204)),
      tags: ["deporte", "ejercicio", "aficionado"],
      sections: [
        ArticleSection(
          title: "El aficionado también necesita nutrición",
          content:
              "Quien corre 5km el fin de semana o va al gimnasio 2-3 veces también se beneficia de:\n\n• ENERGÍA disponible para rendir\n• HIDRATACIÓN adecuada\n• RECUPERACIÓN que evite lesiones\n\nNo necesitas suplementos de élite, pero sí buenos hábitos de comida alrededor del ejercicio.",
        ),
        ArticleSection(
          title: "Antes del ejercicio (aficionado)",
          content:
              "La regla simple: comer ligero y con tiempo:\n\n• 2-3 HORAS ANTES: comida normal con carbohidratos y proteína\n• 1 HORA ANTES: snack ligero (plátano, yogurt, galletas integrales)\n• NO entrenar con el estómago vacío ni recién comido\n\nEjemplos mexicanos: plátano con cacahuate, avena con leche, tostada con aguacate. Carbohidratos que no carguen el estómago.",
        ),
        ArticleSection(
          title: "Hidratación sencilla",
          content:
              "Para el aficionado:\n\n• BEBE AGUA ANTES, DURANTE Y DESPUÉS\n• Si entrenas >60 min o hace calor: agua con un toque de sal/azúcar, bebida isotónica o agua de coco\n• MIRA EL COLOR DE TU ORINA: oscura = deshidratado\n\nEn clima mexicano, la deshidratación llega rápido: llega al gimnasio ya hidratado, no esperes a tener sed.",
        ),
        ArticleSection(
          title: "Después del ejercicio",
          content:
              "Recupérate con comida real:\n\n• COME DENTRO DE LAS 2 HORAS: carbohidrato + proteína\n• OPCIONES: licuado de plátano con leche, yogurt con granola y fruta, atún con galletas, quesadilla de frijol con pollo\n• HIDRÁTATE BIEN\n\nUn vaso de leche con cacao (chocolate natural) es la recuperación perfecta del aficionado: barata, rica y completa.",
        ),
        ArticleSection(
          title: "La constancia por encima del evento",
          content:
              "La nutrición del 'domingo atleta' se juega entre semana:\n\n• LA COMIDA DIARIA importa más que lo que comes el día del ejercicio\n• NO uses el ejercicio como excusa para comer mal el resto de la semana\n• DESCANSAR y dormir es parte del rendimiento\n\nDisfruta tu ejercicio y aliméntalo bien: la constancia te dará más resultados que cualquier truco puntual.",
        ),
      ],
    ),
  ];
}
