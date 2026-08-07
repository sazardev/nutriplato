import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';
import 'package:nutriplato/infrastructure/entities/article/article_section.dart';

/// Artículos de estilo de vida, hábitos y comportamiento alimentario.
List<Article> estiloVidaArticles() {
  return [
    Article(
      title: "Mindful eating: El arte de comer consciente",
      description:
          "Aprende a comer con atención plena para mejorar tu relación con la comida",
      content:
          "Comer consciente te ayuda a disfrutar más y comer mejor, sin dietas complicadas.",
      imageUrl: "lib/data/img/fruits/kiwi.jpg",
      color: Colors.teal,
      publishDate: DateTime.now().subtract(const Duration(days: 123)),
      tags: ["mindful", "conciencia", "hábitos"],
      sections: [
        ArticleSection(
          title: "¿Qué es el mindful eating?",
          content:
              "El mindful eating (alimentación consciente) es prestar atención plena al acto de comer:\n\n• Con todos los sentidos: vista, olfato, sabor, textura\n• Sin distracciones (TV, celular, computadora)\n• Escuchando las señales de hambre y saciedad\n• Sin juzgar ni culparte por lo que comes\n\nEs lo opuesto al 'comer automático': el sándwich devorado frente a la computadora o la bolsa de papitas vacía sin darte cuenta.",
        ),
        ArticleSection(
          title: "Los beneficios comprobados",
          content:
              "La ciencia respalda el mindful eating:\n\n• MENOS ATRACONES y comida emocional\n• MAYOR DISFRUTE con menos comida\n• MEJOR DIGESTIÓN (comer despacio y masticar)\n• MEJOR RELACIÓN CON LA COMIDA, sin culpa\n• APOYO EN EL CONTROL DE PESO sostenible\n\nEstudios muestran que la práctica reduce el comer compulsivo y ayuda a mantener un peso saludable a largo plazo, sin prohibiciones.",
        ),
        ArticleSection(
          title: "Ejercicios prácticos de atención",
          content:
              "Prácticas para comenzar:\n\n1. LA PASA O EL ANTOJO: observa, huele, toca, saborea lentamente (2-3 min)\n2. PAUSA ANTES DE COMER: 3 respiraciones profundas antes del primer bocado\n3. APAGA LAS PANTALLAS durante la comida\n4. MASTICA 15-20 veces por bocado\n5. BAJA EL TENEDOR entre bocados\n6. PRUEBA LA 'ESCALA DE HAMBRE' (del 1 al 10: ¿cuándo empezar y cuándo parar?)\n\nLa escala de hambre es clave: empieza a comer alrededor del 3-4 (hambre moderada) y para en 6-7 (satisfecho, no lleno).",
        ),
        ArticleSection(
          title: "Distinguir hambre física vs emocional",
          content:
              "No todo 'hambre' es hambre:\n\nHambre FÍSICA:\n• Aparece gradualmente\n• Se satisface con cualquier comida\n• Se ubica en el estómago\n• Pasa al comer\n\nHambre EMOCIONAL:\n• Aparece de golpe (estrés, aburrimiento, tristeza)\n• Pide algo específico (dulce, frito)\n• Se 'ubica' en la cabeza\n• No se satisface, da culpa\n\nPregúntate: '¿Comería una manzana ahora?'. Si no, probablemente no tienes hambre física.",
        ),
        ArticleSection(
          title: "Cómo hacerlo un hábito diario",
          content:
              "Empieza pequeño y sé constante:\n\n• ELIGE 1 COMIDA AL DÍA para comer consciente (desayuno es buena opción)\n• COME EN UN LUGAR DESTINADO (no de pie ni en el auto)\n• SIRVE PORCIONES EN PLATO, no de la bolsa\n• AGRADECE el alimento antes de comer\n• SÉ COMPASIVO: si un día comes de más, no te castigues, retoma la práctica\n\nEl mindful eating no es una dieta: es una habilidad que mejora con la práctica. Los pequeños momentos conscientes se acumulan.",
        ),
      ],
    ),
    Article(
      title: "Comer en restaurantes: Elige sano sin complicarte",
      description:
          "Guía para pedir platillos saludables cuando comes fuera de casa",
      content:
          "Comer fuera no tiene que sabotear tu alimentación si sabes cómo pedir.",
      imageUrl: "lib/data/img/vegetables/tomate.jpg",
      color: Colors.red,
      publishDate: DateTime.now().subtract(const Duration(days: 126)),
      tags: ["restaurantes", "comer fuera", "consejos"],
      sections: [
        ArticleSection(
          title: "La regla de oro: pide primero la opción más verde",
          content:
              "Antes de decidir, pregúntate:\n\n• ¿Cuál platillo tiene más verduras?\n• ¿Cuál es a la plancha/al horno/al vapor en lugar de frito?\n• ¿Cuál tiene salsa o aderezo aparte?\n• ¿Cuál no es bebida azucarada?\n\nEl método del plato aplica también en restaurantes: busca que la mitad sea verduras.",
        ),
        ArticleSection(
          title: "Palabras clave en el menú",
          content:
              "BÚS CALOSAS: al horno, a la parrilla, a la plancha, al vapor, asado, a la veracruzana, en salsa verde/roja\n\nSEÑALES DE ALERTA: frito, empanizado, capeado, gratinado, cremoso, bañado en mantequilla, a la mantequilla, relleno, crujiente, enchilado con queso\n\nConsejo: no tengas miedo de personalizar. '¿Me puede hacer el pollo a la plancha en lugar de empanizado?' es una pregunta válida en casi cualquier restaurante.",
        ),
        ArticleSection(
          title: "Cómo enfrentar las porciones grandes",
          content:
              "Los restaurantes sirven porciones hasta 3 veces más grandes que las caseras:\n\n• PIDE MEDIA PORCIÓN o porción infantil si existe\n• COMPARTE el platillo con alguien\n• PIDE QUE ENVUELVAN LA MITAD ANTES de empezar (perra/para llevar)\n• COME PRIMERO la ensalada o verduras del platillo\n\nNo comas 'para aprovechar': la comida que sobra se puede llevar. Tu saciedad vale más que el plato vacío.",
        ),
        ArticleSection(
          title: "Bebidas y extras",
          content:
              "Las bebidas pueden arruinar la comida más sana:\n\n• REFRESCO: ~250 kcal vacías. Pide agua o agua de fruta sin azúcar\n• CERVEZA/ALCOHOL: modera\n• PAN DE LA MESA Y BOTANAS: solo un par de piezas\n• ADEREZOS: pide aparte y usa la mitad\n• POSTRE: comparte o elige fruta\n\nUn refresco con una comida 'light' anula el beneficio. El agua con limón o agua mineral son aliados.",
        ),
        ArticleSection(
          title: "Estrategias para cada tipo de restaurante",
          content:
              "• TAQUERÍA: elige de bistec, suadero (sin exceso) o pastor con tortilla de maíz; agrega nopales, cebolla, cilantro y salsa. Evita los dorados y las tortillas de harina\n• FONDA/COMIDA CORRIDA: el guiso más verde, arroz en poca cantidad, frijoles y agua natural\n• ITALIANO: pasta integral con verduras, o proteína a la parrilla; salsas de tomate sobre cremosas\n• CHINO: al vapor, salteados con verduras; pide salsa aparte\n• PIZZA: una o dos rebanadas con vegetales, y una ensalada al lado\n\nComer fuera es parte de la vida social: el equilibrio no es la perfección, sino elegir mejor la mayoría de las veces.",
        ),
      ],
    ),
    Article(
      title: "Antojos: Por qué aparecen y cómo manejarlos",
      description:
          "Estrategias psicológicas y nutricionales para dominar el antojo",
      content:
          "Los antojos son normales. La clave está en saber manejarlos sin culpa.",
      imageUrl: "lib/data/img/fruits/ciruelapasa.jpg",
      color: Colors.deepOrange,
      publishDate: DateTime.now().subtract(const Duration(days: 129)),
      tags: ["antojos", "anhelos", "control"],
      sections: [
        ArticleSection(
          title: "¿Qué es un antojo y por qué aparece?",
          content:
              "Un antojo es un deseo intenso y específico por un alimento:\n\nCausas comunes:\n• BAJÓN DE GLUCOSA: comer carbohidratos simples causa picos y caídas que disparan antojos\n• ESTRÉS Y EMOCIONES: buscar confort en comida\n• HÁBITO: 'siempre como dulce a las 4pm'\n• PRIVACIÓN: prohibir un alimento aumenta el deseo\n• FACTORES HORMONALES: ciclo menstrual, embarazo\n• FALTA DE SUEÑO: la falta de sueño aumenta grelina (hormona del hambre)",
        ),
        ArticleSection(
          title: "La regla 90/10 y el principio de no prohibición",
          content:
              "La flexibilidad es clave:\n\n• PERMITIR el 10% de 'comida de gusto' reduce los atracones\n• Prohibir por completo aumenta el deseo (efecto prohibido)\n• El chocolate negro y el café sin azúcar reducen los antojos de dulce\n\nEstrategia: en lugar de 'nunca', di 'a veces'. El antojo pierde poder cuando sabes que puedes satisfacerlo sin culpa, en su momento.",
        ),
        ArticleSection(
          title: "Estrategias prácticas contra el antojo",
          content:
              "Cuando llegue un antojo:\n\n1. ESPERA 10 MINUTOS: la mayoría de los antojos pasa en 10-15 min\n2. BEBE UN VASO DE AGUA: a veces confundimos sed con hambre\n3. SALE A CAMINAR 10 MIN: distrae y cambia el estado de ánimo\n4. COME ALGO SALUDABLE PRIMERO: si aún quieres el antojo después, cómelo en porción pequeña\n5. IDENTIFICA LA EMOCIÓN: ¿estrés? ¿aburrimiento? atiende la causa\n\nNo luches contra el antojo, negócialo: primero algo nutritivo, luego la porción pequeña del gusto.",
        ),
        ArticleSection(
          title: "Cómo PREVENIR los antojos",
          content:
              "La prevención es más fácil que el control:\n\n• COME PROTEÍNA Y FIBRA EN CADA COMIDA (saciabilidad)\n• NO SALTES COMIDAS\n• DUERME 7-8 HORAS\n• MANEJA EL ESTRÉS con ejercicio, meditación o pasatiempos\n• COME DULCE EN EL MOMENTO DEL ANTOJO (no después de la comida si no lo quieres)\n• MANTÉN BOTANAS SALUDABLES A LA MANO\n\nLa base de los antojos es el hambre fisiológica mal manejada + la emoción. Cobertos ambos frentes.",
        ),
        ArticleSection(
          title: "El antojo y el ciclo hormonal",
          content:
              "En muchas mujeres, el antojo aumenta en la fase premenstrual:\n\n• Es normal el deseo de dulce o chocolate en esta etapa\n• Estrategias: magnesio (chocolate oscuro lo aporta), comer carbohidratos complejos, no autoflagelarse\n• El chocolate oscuro (>70%) satisface con menos azúcar\n\nComprender tu ciclo te ayuda a planear: ten a la mano opciones saludables en los días de mayor antojo.",
        ),
      ],
    ),
    Article(
      title: "Deja el refresco: Guía para librarte del azúcar líquida",
      description:
          "El refresco es la principal fuente de calorías vacías en México. Aquí cómo dejarlo",
      content:
          "México es uno de los mayores consumidores de refresco del mundo. Dejarlo transforma tu salud.",
      imageUrl: "lib/data/img/fruits/limon.jpg",
      color: Colors.cyan,
      publishDate: DateTime.now().subtract(const Duration(days: 132)),
      tags: ["refresco", "azúcar", "cambio"],
      sections: [
        ArticleSection(
          title: "El impacto real del refresco",
          content:
              "México consume en promedio 163 litros de refresco por persona al año, el mayor de América Latina:\n\n• Un refresco de 600ml: ~250 kcal de azúcar pura\n• La fructosa del refresco va directo al hígado (hígado graso)\n• Aumenta riesgo de diabetes, obesidad y caries\n• Eleva triglicéridos y ácido úrico\n\nSe estima que eliminar el refresco de la dieta diaria puede ahorrar 1-2kg al mes sin otros cambios.",
        ),
        ArticleSection(
          title: "Las primeras 2 semanas",
          content:
              "Los primeros días son los más difíciles, pero también los más importantes:\n\n• DÍAS 1-3: posible dolor de cabeza y antojo intenso (retirada de cafeína y azúcar)\n• DÍAS 4-7: el antojo comienza a ceder\n• DÍAS 8-14: el paladar se adapta; la comida sabe más dulce natural\n\nTips: ten agua siempre a la mano, sustituye con agua mineral con limón, y evita el pasillo de refrescos.",
        ),
        ArticleSection(
          title: "Alternativas saludables al refresco",
          content:
              "Sustitutos con sabor:\n\n• AGUA MINERAL CON LIMÓN Y HIELO\n• AGUA DE JAMAICA O LIMÓN SIN AZÚCAR (o con poca miel)\n• AGUA DE FRUTA NATURAL SIN AZÚCAR\n• TÉ FRÍO O CALIENTE SIN AZÚCAR\n• AGUA INFUSIONADA (pepino-limón, naranja-hierbabuena)\n• CAFÉ SOLO O CON LECHE SIN AZÚCAR\n\nLa jamaica es antioxidante; el agua de limón, refrescante. Prepara tus bebidas en casa y llévalas contigo.",
        ),
        ArticleSection(
          title: "¿Y el refresco light o cero?",
          content:
              "Es una alternativa de transición útil, pero no ideal:\n\n• CERO calorías y cero azúcar: mejor que el regular\n• El etiquetado mexicano obliga a declarar edulcorantes\n• No se recomienda en niños ni embarazadas\n• Algunos estudios sugieren que los edulcorantes pueden alterar la microbiota y el antojo de dulce\n\nÚsalo como puente para reducir, no como destino final. El agua sigue siendo la mejor bebida.",
        ),
        ArticleSection(
          title: "Los beneficios que notarás",
          content:
              "Al dejar el refresco verás cambios:\n\n• 1-2 semanas: mejor sueño, menos inflamación\n• 1 mes: piel más limpia, menos acidez\n• 2-3 meses: pérdida de peso (sin dieta), menos riesgo cardiovascular\n• A largo plazo: menor riesgo de diabetes y hígado graso\n\nInvolucra a la familia: si el refresco no está en casa, no se consume. Sustituye el 'refresco de la comida' por agua con hielo. Tu cuerpo te lo agradecerá.",
        ),
      ],
    ),
    Article(
      title: "Dieta vegetariana en México: Guía completa",
      description:
          "Cómo llevar una alimentación vegetariana sana, variada y muy mexicana",
      content:
          "Ser vegetariano en México es fácil gracias a nuestra riqueza de leguminosas y verduras.",
      imageUrl: "lib/data/img/leguminosas/lentejas.jpg",
      color: Colors.green,
      publishDate: DateTime.now().subtract(const Duration(days: 135)),
      tags: ["vegetariano", "proteína vegetal", "estilo de vida"],
      sections: [
        ArticleSection(
          title: "Tipos de vegetarianismo",
          content:
              "Define tu estilo:\n\n• LACTO-OVO VEGETARIANO: incluye lácteos y huevo (el más común en México)\n• LACTO-VEGETARIANO: incluye lácteos\n• OVO-VEGETARIANO: incluye huevo\n• VEGANO: nada de origen animal\n\nEs importante definir el tipo para planear los nutrientes que necesitas cuidar. El cambio debe ser gradual y bien planeado.",
        ),
        ArticleSection(
          title: "Nutrientes a vigilar",
          content:
              "En una dieta vegetariana, presta atención a:\n\n• PROTEÍNA: cubrir con leguminosas + cereales\n• HIERRO: frijoles, lentejas, amaranto, quelites (con vitamina C)\n• VITAMINA B12: SOLO en productos animales; los vegetarianos (sobre todo veganos) necesitan suplemento\n• CALCIO: lácteos, tortilla nixtamalizada, brócoli, ajonjolí\n• ZINC: semillas, leguminosas, cacahuate\n• OMEGA-3: chía, linaza, nueces\n\nLa B12 es la única vitamina que no existe en el mundo vegetal: sin suplemento (o alimentos fortificados) habrá déficit, sin excepciones.",
        ),
        ArticleSection(
          title: "Platillos vegetarianos mexicanos",
          content:
              "La cocina mexicana está llena de opciones vegetarianas:\n\n• ENFRJOLADAS Y TACOS DE FRIJOL\n• QUESADILLAS DE FLOR DE CALABAZA, HONGOS O PAPA\n• SOPA DE ELOTE, CREMA DE CALABAZA\n• TORTITAS DE QUELITE\n• CHILAQUILES CON HUEVO\n• MOLETES DE FRIJOL\n• TACOS DE SOYA TEXTURIZADA\n• POZOLE VERDE VEGETARIANO (sin carne)\n• TLAQUEROS O HUARACHES DE FRIJOL\n\nNota: los tacos 'de pastor' veganos usan soya texturizada con achiote. La soya texturizada (proteína texturizada de soya) es una gran aliada.",
        ),
        ArticleSection(
          title: "Menú vegetariano de un día",
          content:
              "DESAYUNO: avena con leche (o leche de almendra), plátano y nueces\n\nCOMIDA: enfrijoladas con queso fresco + ensalada de nopales con aguacate\n\nCENA: sopa de verduras + quesadillas de hongos con salsa verde\n\nCOLACIONES: fruta, semillas de calabaza, yogurt natural\n\nCon un plato de frijoles + tortillas + verduras ya tienes una comida completa, nutritiva y 100% mexicana.",
        ),
        ArticleSection(
          title: "Vegetarianismo en todas las etapas",
          content:
              "Una dieta vegetariana bien planeada es saludable para todas las etapas de la vida:\n\n• NIÑOS: requiere planeación cuidadosa y supervisión\n• EMBARAZADAS: cubrir hierro, folato y B12\n• DEPORTISTAS: la proteína se cubre fácil con leguminosas y suplementos si es necesario\n• ADULTOS MAYORES: cuidar la facilidad de masticación y la densidad nutricional\n\nConsulta a un nutriólogo si dudas: una dieta vegetariana mal planeada puede generar deficiencias, pero bien hecha es una de las más saludables.",
        ),
      ],
    ),
    Article(
      title: "Ayuno intermitente: ¿Qué dice la ciencia?",
      description:
          "Beneficios, riesgos y cómo hacerlo correctamente (si decides intentarlo)",
      content:
          "El ayuno intermitente es una tendencia con evidencia, pero no es para todos.",
      imageUrl: "lib/data/img/leguminosas/garbanzos.jpg",
      color: Colors.blueGrey,
      publishDate: DateTime.now().subtract(const Duration(days: 138)),
      tags: ["ayuno", "intermitente", "peso"],
      sections: [
        ArticleSection(
          title: "¿Qué es el ayuno intermitente?",
          content:
              "El ayuno intermitente no dice QUÉ comer, sino CUÁNDO:\n\n• 16:8 (más común): 16 horas de ayuno, 8 de comida (ej: comer entre 12pm y 8pm)\n• 5:2: 5 días normales + 2 días de bajo consumo (500-600 kcal)\n• COMER-DETENER: comer normal 1 día, ayunar al siguiente\n\nDurante el ayuno solo se permiten bebidas sin calorías (agua, café y té sin azúcar).",
        ),
        ArticleSection(
          title: "Beneficios con evidencia",
          content:
              "La investigación muestra:\n\n• CONTROL DE PESO: el ayuno ayuda a reducir calorías sin contar (ventana de alimentación más corta)\n• MEJORA DE SENSIBILIDAD A LA INSULINA\n• REDUCCIÓN DE LA INFLAMACIÓN\n• EN ANIMALES: prolonga la vida y mejora salud metabólica (aún pendiente confirmar en humanos)\n\nImportante: no es 'mejor' que una dieta tradicional para bajar de peso. Ambas funcionan si hay déficit calórico.",
        ),
        ArticleSection(
          title: "Riesgos y quién NO debería ayunar",
          content:
              "NO hagas ayuno intermitente si:\n\n• EMBARAZO O LACTANCIA\n• DIABETES TIPO 1 o descontrolada (riesgo de hipoglucemia)\n• HISTORIAL DE TRASTORNOS ALIMENTARIOS\n• DESNUTRICIÓN O BAJO PESO\n• NIÑOS Y ADOLESCENTES EN CRECIMIENTO\n• PERSONAS QUE TOMAN MEDICAMENTOS CON COMIDA\n\nAntes de ayunar, consulta a tu médico, especialmente si tienes alguna condición crónica.",
        ),
        ArticleSection(
          title: "Errores comunes del ayuno",
          content:
              "El ayuno mal hecho es peor que no ayunar:\n\n• ATRAVERSAR la ventana de comida con comida chatarra\n• NO HIDRATARSE durante el ayuno\n• DESAYUNO (o comida) excesivamente grande\n• NO DORMIR (la falta de sueño estropea las hormonas del hambre)\n• ESPERAR resultados inmediatos\n\nEl ayuno no es un permiso para comer mal en la ventana: la calidad de lo que comes sigue importando.",
        ),
        ArticleSection(
          title: "Cómo empezar (si es para ti)",
          content:
              "Pasos graduales:\n\n1. EMPIEZA CON 12 HORAS (cenar a las 8pm, desayunar a las 8am)\n2. EXTENDE a 14 y luego 16 horas gradualmente\n3. DURANTE EL AYUNO: agua, café y té sin azúcar\n4. EN LA VENTANA: comida completa y saludable (método del plato)\n5. ESCUCHA A TU CUERPO: si te sientes mal, no es para ti\n\nRegla de oro: el ayuno es una herramienta, no una obligación. Si no te funciona o no lo disfrutas, una dieta equilibrada con horarios regulares es igualmente saludable.",
        ),
      ],
    ),
    Article(
      title: "Nutrición y ejercicio: Qué comer antes y después de entrenar",
      description:
          "El combustible correcto para rendir mejor y recuperarte más rápido",
      content:
          "Lo que comes alrededor del ejercicio determina tu rendimiento y recuperación.",
      imageUrl: "lib/data/img/fitness_food.jpeg",
      color: Colors.blue,
      publishDate: DateTime.now().subtract(const Duration(days: 141)),
      tags: ["ejercicio", "rendimiento", "recuperación"],
      sections: [
        ArticleSection(
          title: "La regla del timing nutricional",
          content:
              "El cuerpo necesita combustible según el momento:\n\n• ANTES: energía disponible para el ejercicio\n• DURANTE: hidratación y (a veces) carbohidratos\n• DESPUÉS: recuperación y reconstrucción muscular\n\nLos 3 momentos importan, pero para la mayoría de personas (ejercicio moderado) lo más importante es una buena alimentación general + comida después del ejercicio.",
        ),
        ArticleSection(
          title: "Qué comer antes del ejercicio",
          content:
              "Come 1-3 horas antes (depende del tamaño):\n\n• 2-3 HORAS ANTES: comida completa (carbohidratos + proteína + poca grasa)\n• 1 HORA ANTES: colación ligera (plátano, yogurt, tostada con mermelada)\n• MENOS DE 30 MIN: solo líquido (agua, jugo natural pequeño)\n\nEjemplos mexicanos:\n• Plátano + cacahuates\n• Avena con leche y canela\n• Tostada de aguacate\n• Fruta con un puño de almendras\n\nEvita antes: comidas muy grasosas o muy abundantes (digestión lenta).",
        ),
        ArticleSection(
          title: "Qué comer después del ejercicio",
          content:
              "La ventana de recuperación (primeras 4 horas):\n\n• COMBINA CARBOHIDRATO + PROTEÍNA (proporción 3:1 aprox)\n• Carbohidrato repone glucógeno; proteína repara músculo\n\nEjemplos:\n• Licuado de plátano con leche y amaranto\n• Yogurt griego con fruta y granola\n• Quesadilla de frijol con pollo\n• Batido de leche con cacao (chocolate natural)\n• Atún con galletas integrales\n\nUn vaso de leche con chocolate NATURAL es una recuperación casi perfecta: carbohidratos + proteína + agua + electrolitos.",
        ),
        ArticleSection(
          title: "Hidratación para el ejercicio",
          content:
              "En el clima mexicano, la hidratación es crítica:\n\n• ANTES: 400-600ml 2 horas antes\n• DURANTE: 150-250ml cada 15-20 min\n• DESPUÉS: reponer 1.5L por cada kg perdido\n\nPara ejercicios >60 min o calor intenso, considera bebidas con electrolitos o agrega una pizca de sal y azúcar a tu agua (o bebe agua de coco natural).",
        ),
        ArticleSection(
          title: "Mitos del fitness nutricional",
          content:
              "Desmintamos:\n\n• MITO: 'Entrenar en ayunas quema más grasa' — La diferencia es mínima y puede afectar el rendimiento\n• MITO: 'Necesitas batidos de proteína caros' — Un vaso de leche o yogurt funciona igual\n• MITO: 'Comer de noche engorda' — El total diario importa\n• MITO: 'Mientras más proteína, mejor' — El exceso no se convierte en músculo\n• REALIDAD: La proteína total del día importa más que el timing\n\nLa constancia en el entrenamiento y la alimentación supera a cualquier truco puntual.",
        ),
      ],
    ),
    Article(
      title: "Comer emocional: Cuando la comida es tu refugio",
      description:
          "Identifica el hambre emocional y construye una relación sana con la comida",
      content:
          "Muchas veces comemos no por hambre, sino por emociones. Aprende a diferenciarlo.",
      imageUrl: "lib/data/img/fruits/frambruesa.jpg",
      color: Colors.pink,
      publishDate: DateTime.now().subtract(const Duration(days: 144)),
      tags: ["emocional", "psicología", "bienestar"],
      sections: [
        ArticleSection(
          title: "¿Qué es el comer emocional?",
          content:
              "El comer emocional es usar la comida para manejar emociones, en lugar de hambre:\n\n• ESTRÉS: comer para calmar la ansiedad\n• ABURRIMIENTO: comer para llenar el tiempo\n• TRISTEZA: buscar consuelo\n• FELICIDAD/CELEBRACIÓN: comer para premiar\n• FRUSTRACIÓN: comer para desahogarse\n\nEs un mecanismo común y humano, pero cuando se vuelve el principal recurso emocional, causa sobrepeso, culpa y una relación dañina con la comida.",
        ),
        ArticleSection(
          title: "Hambre física vs hambre emocional",
          content:
              "Claves para diferenciarlas:\n\nHambre FÍSICA:\n• Gradual, en el estómago\n• Se satisface con cualquier comida\n• Pasa al estar satisfecho\n• No causa culpa\n\nHambre EMOCIONAL:\n• Súbita, en la cabeza\n• Pide comida específica (dulce, frito)\n• No se satisface (comes de más)\n• Deja culpa y vergüenza\n\nCuando sientas un 'hambre' repentino de algo específico en medio del estrés, es casi seguro emocional.",
        ),
        ArticleSection(
          title: "El ciclo de la culpa",
          content:
              "El comer emocional se alimenta a sí mismo:\n\n1. EMOCIÓN DISPARADORA (estrés)\n2. ANTOJO (algo dulce)\n3. ATRACÓN o exceso\n4. CULPA Y VERGÜENZA\n5. MÁS ESTRÉS → vuelve a empezar\n\nRomper el ciclo requiere romper el paso 4: deja de castigarte. La culpa perpetúa el problema; la compasión lo corta.",
        ),
        ArticleSection(
          title: "Estrategias para interrumpir el patrón",
          content:
              "Herramientas prácticas:\n\n1. LA REGLA DE LOS 10 MINUTOS: espera antes de comer el antojo\n2. IDENTIFICA LA EMOCIÓN: nombre lo que sientes ('esto es aburrimiento, no hambre')\n3. SUSTITUYE LA ACCIÓN: caminar, llamar a alguien, respirar profundo, escribir\n4. HAZ UN PLAN DE EMERGENCIAS: lista de actividades no alimentarias para emociones difíciles\n5. SIRVE UNA PORCIÓN PEQUEÑA y come lento\n\nNo tienes que eliminar el gusto: solo desactivarlo de ser tu único recurso.",
        ),
        ArticleSection(
          title: "Cuándo buscar ayuda profesional",
          content:
              "El comer emocional es serio cuando:\n\n• ATRACONES frecuentes (comer en exceso en poco tiempo)\n• SENTIMIENTOS DE CULPA Y VERGÜENZA recurrentes\n• EVITAR situaciones sociales por la comida\n• USAR vómito, laxantes o ejercicio extremo como compensación\n\nSi sientes que pierdes el control, un psicólogo especializado en conducta alimentaria y un nutriólogo pueden ayudarte. No es debilidad pedir ayuda: es fortaleza.",
        ),
      ],
    ),
    Article(
      title: "Comer de forma económica y sostenible: Alimenta tu salud y el planeta",
      description:
          "Estrategias para comer sano cuidando tu bolsillo y el medio ambiente",
      content:
          "Tu plato también puede ayudar al planeta. Aquí cómo lograrlo sin gastar de más.",
      imageUrl: "lib/data/img/vegetables/pepino.jpg",
      color: Colors.green,
      publishDate: DateTime.now().subtract(const Duration(days: 147)),
      tags: ["sostenible", "ambiente", "economía"],
      sections: [
        ArticleSection(
          title: "El impacto ambiental de tu plato",
          content:
              "La producción de alimentos genera hasta 1/3 de las emisiones globales de gases de efecto invernadero:\n\n• LA CARNE (sobre todo vacuna) tiene la mayor huella\n• EL DESPERDICIO de comida es responsable de 8-10% de las emisiones\n• Los productos de temporada y locales viajan menos\n\nComer más vegetales, reducir el desperdicio y elegir local son las 3 acciones más efectivas desde tu cocina.",
        ),
        ArticleSection(
          title: "Comer más plantas: La regla flexitariana",
          content:
              "No necesitas volverte vegano para impactar:\n\n• 2-3 días a la semana SIN carne (lunes sin carne)\n• MENOS PERO MEJOR carne: porciones pequeñas de carne de calidad\n• MÁS LEGUMINOSAS: frijoles, lentejas, garbanzos (proteína barata y verde)\n• MÁS FRUTA Y VERDURA DE TEMPORADA\n\nLa dieta mexicana tradicional ya era 'flexitariana': la milpa (maíz + frijol + calabaza) es de los sistemas alimentarios más sostenibles del mundo.",
        ),
        ArticleSection(
          title: "Reduce el desperdicio alimentario",
          content:
              "En México se desperdician ~20 millones de toneladas de comida al año:\n\n• PLANIFICA el menú y haz lista de compras\n• COMPRA SOLO lo necesario\n• USA SOBRAS creativamente (sopas, guisos, salsas)\n• CONGELA lo que no usarás pronto\n• APROVECHA tallos, cáscaras y hojas en caldos\n• RECOMPOSTA lo orgánico\n\nCada comida desperdiciada es dinero perdido y recursos gastados (agua, tierra, energía) en vano.",
        ),
        ArticleSection(
          title: "Compra local y de temporada",
          content:
              "Beneficios de comprar en mercado o tianguis:\n\n• MENOR HUELLA DE TRANSPORTE\n• APOYAS A LA ECONOMÍA LOCAL\n• PRODUCTOS MÁS FRESCOS (y nutritivos)\n• GENERALMENTE MÁS BARATOS\n\nComprar local en México es fácil: tianguis y mercados abundan y ofrecen lo de temporada a mejor precio.",
        ),
        ArticleSection(
          title: "Cambios pequeños, impacto grande",
          content:
              "Empieza hoy:\n\n1. 1 DÍA SIN CARNE a la semana\n2. COMPRA EN TIANGUIS o mercado local\n3. HAZ LISTA Y PLANIFICA para no desperdiciar\n4. LLEVA TU BOLSA y evita plásticos de un solo uso\n5. PREPARA CALDOS con sobras\n\nLa alimentación sostenible no es una moda: es comer mejor para ti, para tu bolsillo y para las futuras generaciones.",
        ),
      ],
    ),
    Article(
      title: "Cocinar en casa: El hábito que cambia tu vida",
      description:
          "Los beneficios de cocinar y estrategias para hacerlo fácil y rápido",
      content:
          "Cocinar en casa es la forma más poderosa de comer sano. Aquí cómo hacerlo simple.",
      imageUrl: "lib/data/img/vegetables/cebolla.jpg",
      color: Colors.amber,
      publishDate: DateTime.now().subtract(const Duration(days: 150)),
      tags: ["cocinar", "hábitos", "casa"],
      sections: [
        ArticleSection(
          title: "Por qué cocinar en casa cambia todo",
          content:
              "Los beneficios son enormes:\n\n• CONTROLAS INGREDIENTES: menos sodio, azúcar y grasas malas\n• PORCIONES REALISTAS (no las 'supersized' de restaurantes)\n• AHORRO ECONÓMICO: una comida casera cuesta fracción de una de restaurante\n• CONEXIÓN FAMILIAR\n• HABILIDAD PARA TODA LA VIDA\n\nEstudios muestran que quienes cocinan en casa consumen más verduras, menos calorías y tienen menor riesgo de obesidad y diabetes.",
        ),
        ArticleSection(
          title: "Simplifica con la olla grande",
          content:
              "El método más eficiente:\n\n1. COCINA 1 VEZ, COME VARIAS VECES\n2. Prepara frijoles, arroz, pollo o verduras salteadas en grandes cantidades\n3. GUARDA EN PORCIONES (tuppers/bolsas congelables)\n4. COMBINA durante la semana: frijoles hoy en tacos, mañana en sopa\n\nCocinar 'a granel' domingo toma 1.5-2 horas y te da comidas para casi toda la semana.",
        ),
        ArticleSection(
          title: "Tus 10 ingredientes base mexicanos",
          content:
              "Con estos en tu despensa, nunca estás sin opciones:\n\n1. FRIJOLES (de olla, enlatados sin exceso de sal)\n2. TORTILLAS DE MAÍZ\n3. HUEVO\n4. JITOMATE Y CEBOLLA\n5. NOPALES\n6. AVENA\n7. ARROZ\n8. POLLO (pechuga)\n9. AGUACATE\n10. LIMÓN Y HIERBAS\n\nCon estos puedes armar tacos, sopas, revoltillos, ensaladas y guisos: la base de la cocina mexicana saludable.",
        ),
        ArticleSection(
          title: "Herramientas que valen la pena",
          content:
              "No necesitas una cocina profesional:\n\n• SARTÉN ANTIADHERENTE BUENO\n• OLLA DE PRESIÓN (para frijoles y caldos en minutos)\n• LICUADORA (salsas, licuados)\n• CUTTER/CUCHILLO BUENO\n• TABLAS DE CORTAR\n• COMAL O PLANCHA (tortillas, asados)\n• TAPPERES para meal prep\n\nLa olla de presión es la reina de la cocina mexicana: frijoles listos en 40 minutos en lugar de horas.",
        ),
        ArticleSection(
          title: "Supera las excusas más comunes",
          content:
              "'NO TENGO TIEMPO' — El meal prep y los guisos de olla resuelven. 'NO SÉ COCINAR' — Empieza con 3 recetas y crece. 'ES TARDE PARA COMER SANO' — Nunca es tarde.\n\nEmpieza pequeño: cocina 2 veces por semana y aumenta. La habilidad se construye con práctica, no con perfección.\n\nRecuerda: cocinar es un acto de autocuidado. Te estás nutriendo a ti y a los que amas.",
        ),
      ],
    ),
    Article(
      title: "Café: ¿Aliado o enemigo de tu salud?",
      description:
          "Lo que dice la ciencia sobre el café y cómo consumirlo sin caer en excesos",
      content:
          "El café es una de las bebidas más consumidas de México. La ciencia tiene buenas noticias.",
      imageUrl: "lib/data/img/cereales/amaranto.jpg",
      color: Colors.brown,
      publishDate: DateTime.now().subtract(const Duration(days: 153)),
      tags: ["café", "cafeína", "salud"],
      sections: [
        ArticleSection(
          title: "¿Qué contiene tu taza de café?",
          content:
              "El café es más que cafeína:\n\n• CAFEÍNA: estimulante del sistema nervioso (mejora alerta y concentración)\n• ANTIOXIDANTES: ácido clorogénico (poderoso antioxidante)\n• VITAMINAS B: pequeñas cantidades\n• MINERALES: potasio, magnesio\n\nMéxico es un gran productor de café de altura (Chiapas, Veracruz, Puebla, Oaxaca), de calidad mundial.",
        ),
        ArticleSection(
          title: "Los beneficios con evidencia",
          content:
              "La investigación asocia el consumo moderado con:\n\n• MENOR RIESGO DE DIABETES TIPO 2\n• MENOR RIESGO DE ENFERMEDAD HEPÁTICA (incluido hígado graso)\n• MENOR RIESGO DE ALGUNOS TIPOS DE CÁNCER\n• MEJOR RENDIMIENTO COGNITIVO Y DEPORTIVO\n• MENOR RIESGO DE PARKINSON Y ALZHEIMER\n\nEl consumo moderado (2-4 tazas/día) se considera seguro y beneficioso en personas sanas.",
        ),
        ArticleSection(
          title: "Los riesgos y cuándo moderarlo",
          content:
              "El café no es para todos:\n\n• EMBARAZADAS: limitar a 200mg de cafeína/día (1-2 tazas)\n• ANSIEDAD E INSOMNIO: la cafeína puede empeorarlos\n• ACIDEZ Y REFLUJO: el café puede irritar\n• PERSONAS SENSIBLES: palpitaciones, temblor, nerviosismo\n• EXCESO (>4-5 tazas): ansiedad, insomnio, taquicardia\n\nPresta atención a tu respuesta individual: la tolerancia a la cafeína varía mucho de persona a persona.",
        ),
        ArticleSection(
          title: "El café 'mexicano' saludable",
          content:
              "La forma en que lo preparas importa:\n\n• CAFÉ DE OLLA: canela y piloncillo; usa menos piloncillo o endulza con canela\n• ESPRESSO O AMERICANO: bajos en calorías\n• CAFÉ CON LECHE: moderado\n• CAFÉ CON CREMA BATIDA + SIROPE + CARAMELO: una bomba de azúcar (el 'frappuccino' puede tener 400+ kcal)\n\nEl café en su forma básica tiene casi cero calorías. Son los agregados (azúcar, cremas, siropes) los que lo convierten en postre.",
        ),
        ArticleSection(
          title: "Horario y calidad",
          content:
              "Consejos finales:\n\n• EVITA CAFEÍNA DESPUÉS DE LAS 2-4 PM (la vida media es 5-6 horas; puede arruinar tu sueño)\n• NO USES EL CAFÉ PARA SUSTITUIR SUEÑO\n• EL CAFÉ NO HIDRATA mal: aunque es levemente diurético, la cantidad de agua de la taza compensa\n• PREFIERE CAFÉ DE ALTURA MEXICANO, de comercio justo cuando puedas\n\nDisfruta tu café con moderación, sin azúcar y a horas razonables. Es una bebida que, bien consumida, aporta más de lo que daña.",
        ),
      ],
    ),
    Article(
      title: "Alcohol y nutrición: Todo con medida",
      description:
          "El impacto del alcohol en tu cuerpo y cómo disfrutarlo de forma responsable",
      content:
          "El alcohol es una realidad social. Conocer su efecto nutricional te permite decidir mejor.",
      imageUrl: "lib/data/img/animal/codorniz.jpg",
      color: Colors.indigo,
      publishDate: DateTime.now().subtract(const Duration(days: 156)),
      tags: ["alcohol", "medida", "salud"],
      sections: [
        ArticleSection(
          title: "El alcohol y sus calorías",
          content:
              "El alcohol aporta 7 kcal por gramo, casi tanto como la grasa:\n\n• UNA CERVEZA (355ml): 150 kcal\n• UNA COP A DE VINO (150ml): 125 kcal\n• UN TRAGO DE TEQUILA (45ml): 100 kcal\n• UN COCTEL (margarita, mojito): 200-500 kcal (azúcar + alcohol)\n\nLas calorías del alcohol son 'vacías': no aportan nutrientes. El alcohol además se metaboliza primero, posponiendo la quema de grasa.",
        ),
        ArticleSection(
          title: "Efectos nutricionales del alcohol",
          content:
              "Más allá de las calorías:\n\n• INTERFIERE CON LA ABSORCIÓN DE NUTRIENTES (B12, folato, zinc)\n• AUMENTA TRIGLICÉRIDOS\n• DESHIDRATA (efecto diurético)\n• DAÑA EL SUEÑO (aunque dé sueño, fragmenta el descanso)\n• AUMENTA EL ANTOJO (alcohol y comida alta en grasa van juntos)\n• SOBRECARGA AL HÍGADO\n\nEl alcohol se asocia a aumento de peso, sobre todo grasa abdominal (la 'panza cervecera' no es solo mito).",
        ),
        ArticleSection(
          title: "La moderación recomendada",
          content:
              "Guías oficiales:\n\n• MUJERES: máximo 1 bebida estándar al día\n• HOMBRES: máximo 2 bebidas al día\n• UNA BEBIDA = 355ml cerveza, 150ml vino, 45ml destilado\n\nMás importante que el límite: los días libres de alcohol. Al menos 2-3 días sin beber a la semana permiten al hígado recuperarse.",
        ),
        ArticleSection(
          title: "Consejos para beber 'inteligente'",
          content:
              "Si decides beber:\n\n• NO BEBAS CON EL ESTÓMAGO VACÍO (come antes, reduce la absorción)\n• ALTERNA cada bebida alcohólica con agua\n• EVITA COCTELES AZUCARADOS: prefiere bebidas simples\n• ELIGE CERVEZA LIGHT o vino tinto (menos calorías)\n• NO BEBAS PARA DORMIR: el alcohol arruina el sueño profundo\n• CONDUCIR JAMÁS: planea transporte seguro\n\nLa hidratación con agua entre bebidas reduce la resaca y las calorías totales.",
        ),
        ArticleSection(
          title: "Cuándo decir NO al alcohol",
          content:
              "Evita por completo en:\n\n• EMBARAZO Y LACTANCIA (ninguna cantidad es segura)\n• TOMA DE MEDICAMENTOS (antibióticos, ansiolíticos, entre otros)\n• ENFERMEDAD HEPÁTICA O PANCREATITIS\n• HISTORIAL DE ALCOHOLISMO\n• CONDUCCIÓN\n\nEl mejor consumo de alcohol para la salud es el mínimo. Si no bebes, no necesitas empezar: ningún beneficio justifica el riesgo.",
        ),
      ],
    ),
  ];
}
