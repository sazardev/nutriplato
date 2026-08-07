import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';
import 'package:nutriplato/infrastructure/entities/article/article_section.dart';

/// Artículos de salud y condiciones específicas.
List<Article> saludArticles() {
  return [
    Article(
      title: "Colesterol alto: Guía para bajarlo con alimentación",
      description:
          "Entiende tu colesterol y aprende a controlarlo sin medicamentos (cuando es posible)",
      content:
          "El colesterol alto es una de las condiciones más comunes en México, pero es manejable.",
      imageUrl: "lib/data/img/animal/salmon.jpg",
      color: Colors.red,
      publishDate: DateTime.now().subtract(const Duration(days: 87)),
      tags: ["colesterol", "corazón", "salud"],
      sections: [
        ArticleSection(
          title: "Colesterol bueno y malo: la diferencia",
          content:
              "El colesterol es una grasa necesaria para el cuerpo, pero en exceso daña las arterias:\n\n• LDL ('malo'): Transporta colesterol y puede acumularse en arterias\n• HDL ('bueno'): Recoge el exceso y lo lleva al hígado\n• TRIGLICÉRIDOS: Otra grasa en sangre que se eleva con azúcar y alcohol\n\nValores deseables:\n• Colesterol total: <200 mg/dL\n• LDL: <100 mg/dL\n• HDL: >40 mg/dL (hombres), >50 mg/dL (mujeres)\n• Triglicéridos: <150 mg/dL",
        ),
        ArticleSection(
          title: "Alimentos que bajan el LDL",
          content:
              "Estos alimentos han demostrado reducir el colesterol:\n\n• AVENA Y CEBADA: Betaglucanos que atrapan el colesterol\n• FRIJOLES Y LEGUMINOSAS: Fibra soluble\n• NUEVES: Especialmente almendras y nuez de Castilla\n• AGUACATE: Grasas monoinsaturadas\n• ACEITE DE OLIVA: Reemplaza grasas malas\n• PESCADO GRASO: Omega-3 (salmón, sardina)\n• FRUTAS: Manzana, uva, cítricos (pectina)\n• SOYA: Baja el LDL moderadamente\n\nUn desayuno de avena con frutas y un toque de nuez es un potente 'bajacolesterol'.",
        ),
        ArticleSection(
          title: "Alimentos que elevan el colesterol",
          content:
              "Limita estos:\n\n• GRASAS TRANS: frituras, galletas, pasteles (las más dañinas)\n• CARNES GRASOSAS: cortes con grasa visible, tocino, embutidos\n• LÁCTEOS ENTEROS EN EXCESO: mantequilla, crema, quesos maduros\n• FRITURAS\n• ALIMENTOS CON SELLO DE EXCESO GRASAS SATURADAS\n• AZÚCAR Y ALCOHOL: elevan triglicéridos\n\nLa NOM-051 (etiquetado frontal) te ayuda: evita productos con sello de exceso de grasas saturadas o trans.",
        ),
        ArticleSection(
          title: "Hábitos complementarios",
          content:
              "La alimentación es la mitad de la batalla:\n\n• EJERCICIO: 150 min/semana sube el HDL y baja triglicéridos\n• PERDER PESO: cada 1% de pérdida mejora tu perfil lipídico\n• DEJAR DE FUMAR: El tabaco baja el HDL\n• MODERAR ALCOHOL\n• CONTROLAR EL AZÚCAR: el azúcar también dispara triglicéridos\n\nEl ejercicio es el único 'fármaco' que sube el colesterol bueno (HDL) de forma significativa.",
        ),
        ArticleSection(
          title: "¿Cuándo se necesita medicamento?",
          content:
              "La dieta puede no ser suficiente en algunos casos:\n\n• ANTECEDENTES FAMILIARES de colesterol alto o infarto\n• COLESTEROL MUY ALTO (LDL >190 mg/dL)\n• DIABETES O ENFERMEDAD CARDIOVASCULAR establecida\n\nNunca suspendas un medicamento recetado sin consultar. La alimentación y los fármacos son complementarios: la dieta puede permitir dosis menores, pero el médico decide.",
        ),
      ],
    ),
    Article(
      title: "Presión arterial alta: La dieta DASH explicada",
      description:
          "El plan de alimentación respaldado por la ciencia para bajar tu presión",
      content:
          "La hipertensión afecta a uno de cada tres mexicanos y la dieta es tu primera medicina.",
      imageUrl: "lib/data/img/vegetables/tomatescherry.jpg",
      color: Colors.blue,
      publishDate: DateTime.now().subtract(const Duration(days: 90)),
      tags: ["hipertensión", "presión", "DASH"],
      sections: [
        ArticleSection(
          title: "¿Qué es la dieta DASH?",
          content:
              "DASH = Dietary Approaches to Stop Hypertension. Es el plan que más ha demostrado bajar la presión arterial:\n\n• RICO en frutas, verduras, cereales integrales y lácteos bajos en grasa\n• MODERADO en proteínas magras y nueces\n• BAJO en sodio, grasas saturadas y azúcares\n\nLos estudios muestran que la dieta DASH reduce la presión sistólica 8-14 mmHg, comparable a un medicamento, sin efectos secundarios.",
        ),
        ArticleSection(
          title: "El sodio: tu enemigo principal",
          content:
              "La DASH tiene versiones de sodio:\n\n• ESTÁNDAR: máximo 2300mg de sodio al día (1 cucharadita de sal)\n• BAJA: máximo 1500mg (recomendada para hipertensos)\n\nFuentes ocultas de sodio:\n• Pan y tortillas industriales\n• Embutidos\n• Quesos y productos enlatados\n• Salsas y aderezos comerciales\n• Sopas instantáneas\n\nEl 75% del sodio viene de procesados, no del salero.",
        ),
        ArticleSection(
          title: "Potasio: el mineral que contrarresta la sal",
          content:
              "El potasio ayuda a eliminar el exceso de sodio y relaja las arterias:\n\n• PLÁTANO: 420mg\n• AGUACATE: 485mg\n• JITOMATE: 292mg\n• PAPA: 421mg\n• FRIJOLES: 600mg por taza\n• ESPINACA: 558mg\n• NARANJA: 237mg\n\nNota: Si tienes enfermedad renal avanzada, el potasio excesivo puede ser peligroso. Consulta a tu médico antes de aumentarlo.",
        ),
        ArticleSection(
          title: "El método del plato DASH",
          content:
              "Cómo armar cada comida según DASH:\n\n• ½ plato: verduras y frutas\n• ¼ plato: cereales integrales\n• ¼ plato: proteína magra\n• + lácteos bajos en grasa en colaciones\n• + nueces y semillas con moderación\n• Evita azúcares y refrescos\n\nUn guiso mexicano compatible: pescado a la veracruzana con arroz integral y ensalada de verduras. Delicioso y cardioprotegido.",
        ),
        ArticleSection(
          title: "Más allá de la dieta",
          content:
              "La presión arterial responde a varios frentes:\n\n• PESO: Bajar 5kg reduce la presión notablemente\n• EJERCICIO: 30 min diarios de caminata\n• ALCOHOL: reducir drásticamente\n• ESTRÉS: técnicas de relajación\n• SUEÑO: dormir mal eleva la presión\n\nMide tu presión en casa y lleva registro. La hipertensión es silenciosa: la mayoría no sabe que la tiene. Si tu presión es >130/85, consulta a tu médico.",
        ),
      ],
    ),
    Article(
      title: "Anemia: Combátela con hierro en tu plato",
      description:
          "Síntomas, alimentos ricos en hierro y cómo mejorar su absorción",
      content:
          "La anemia por deficiencia de hierro es muy común en México, sobre todo en mujeres y niños.",
      imageUrl: "lib/data/img/animal/bistecderes.jpg",
      color: Colors.purple,
      publishDate: DateTime.now().subtract(const Duration(days: 93)),
      tags: ["anemia", "hierro", "salud"],
      sections: [
        ArticleSection(
          title: "¿Qué es la anemia?",
          content:
              "La anemia ocurre cuando no hay suficientes glóbulos rojos o hemoglobina para transportar oxígeno.\n\nSíntomas frecuentes:\n• Cansancio y debilidad\n• Palidez en piel y uñas\n• Falta de aire\n• Mareos y dolor de cabeza\n• Manos y pies fríos\n• Uñas quebradizas\n\nEn México, la anemia afecta a ~1 de cada 4 niños pequeños y a muchas mujeres en edad fértil, según la ENSANUT.",
        ),
        ArticleSection(
          title: "Hierro hemo vs no hemo",
          content:
              "No todo el hierro se absorbe igual:\n\n• HIERRO HEMO (animal): Se absorbe bien (15-35%). Carne roja, vísceras, pollo, pescado\n• HIERRO NO HEMO (vegetal): Se absorbe poco (2-20%). Frijoles, lentejas, espinaca, amaranto\n\nTruco: El hierro vegetal se absorbe mucho mejor si se acompaña de vitamina C (limón, naranja, guayaba). Unos frijoles con salsa de limón y jitomate son una combinación inteligente.",
        ),
        ArticleSection(
          title: "Alimentos ricos en hierro",
          content:
              "Fuentes por cada 100g (aprox):\n\n• HÍGADO DE RES: 6.5mg\n• ALMEJAS: 24mg\n• FRIJOLES: 5-6mg\n• LENTEJAS: 3.3mg\n• ESPINACA: 2.7mg\n• AMARANTO: 7.6mg\n• CARNE ROJA: 2-3mg\n• HUEVO: 1.2mg\n• QUELITES: ricos en hierro\n\nOjo: El té y el café (taninos) y los lácteos (calcio) pueden reducir la absorción de hierro si se toman justo con la comida. Sepáralos 1-2 horas.",
        ),
        ArticleSection(
          title: "El papel del ácido fólico y B12",
          content:
              "La anemia no siempre es por hierro:\n\n• ÁCIDO FÓLICO: Verduras de hoja verde, frijoles, lentejas. Esencial en embarazo (previene defectos del tubo neural)\n• VITAMINA B12: Solo en productos animales. Los vegetarianos estrictos deben suplementarse\n\nSi la anemia no mejora con dieta, tu médico puede solicitar análisis para identificar el tipo exacto. La ferritina, la hemoglobina y el tamaño de los glóbulos ayudan a diferenciar.",
        ),
        ArticleSection(
          title: "Cocinando para prevenir la anemia",
          content:
              "Prácticas culinarias que ayudan:\n\n• Cocina en sartén de hierro (aporta hierro al alimento)\n• Agrega limón al final de los guisos de leguminosas\n• Combina carne + leguminosas + vitamina C en la misma comida\n• Evita remojar demasiado los frijoles (pierden nutrientes)\n• Incluye hierro en todas las comidas, no solo en una\n\nSi estás embarazada o tu anemia es severa, sigue las indicaciones médicas: los suplementos de hierro son la primera línea de tratamiento.",
        ),
      ],
    ),
    Article(
      title: "Salud intestinal: Prebióticos y probióticos",
      description:
          "Cuida la microbiota que vive en tu intestino y mejora tu salud general",
      content:
          "Tu intestino alberga billones de bacterias que afectan tu digestión, inmunidad y ánimo.",
      imageUrl: "lib/data/img/animal/yogurt.jpg",
      color: Colors.teal,
      publishDate: DateTime.now().subtract(const Duration(days: 96)),
      tags: ["intestino", "probióticos", "microbiota"],
      sections: [
        ArticleSection(
          title: "¿Qué es la microbiota intestinal?",
          content:
              "En tu intestino viven ~38 billones de microorganismos (bacterias, hongos, virus) que forman la microbiota.\n\nSus funciones:\n• Digieren fibra y producen vitaminas\n• Entrenan al sistema inmune (70% de la inmunidad está en el intestino)\n• Producen neurotransmisores (95% de la serotonina)\n• Protegen contra patógenos\n\nUna microbiota diversa y equilibrada se asocia con mejor salud general, digestión y estado de ánimo.",
        ),
        ArticleSection(
          title: "Prebióticos: el alimento de tus bacterias",
          content:
              "Los prebióticos son la fibra que alimenta a las bacterias buenas:\n\n• FRUCTOOLIGOSACÁRIDOS: ajo, cebolla, plátano, espárrago, nopal\n• INULINA: ajo, cebolla, trigo, alcachofa\n• RESISTENTES: papa fría, plátano verde, arroz recocido\n\nFuentes mexicanas de prebióticos: nopal, cebolla, ajo, plátano, papa, frijoles y jícama (esta última es excelente fuente de inulina).",
        ),
        ArticleSection(
          title: "Probióticos: las bacterias buenas",
          content:
              "Los probióticos son microorganismos vivos que benefician tu intestino:\n\n• YOGURT NATURAL (con cultivos vivos)\n• QUESO FRESCO ARTESANAL\n• JAMAIBA, TEPACHE Y PULQUE (fermentados, con moderación)\n• CHUCRUT O VERDURAS FERMENTADAS\n• KÉFIR\n\nPara que un probiótico funcione, debe consumirse regularmente. Busca yogurt que diga 'contiene cultivos vivos activos' y elige natural (sin azúcar añadida).",
        ),
        ArticleSection(
          title: "Lo que daña tu microbiota",
          content:
              "Estos hábitos empobrecen la diversidad bacteriana:\n\n• DIETA ALTA EN AZÚCAR Y ULTRAprocesados\n• EXCESO DE GRASAS TRANS\n• ALCOHOL\n• ANTIBIÓTICOS sin necesidad (y sin repoblar después)\n• ESTRÉS CRÓNICO\n• FALTA DE SUEÑO\n• ESTILO DE VIDA SEDENTARIO\n\nEl azúcar alimenta bacterias 'malas' y hongos, mientras que la fibra alimenta las buenas: el balance de tu intestino refleja tu dieta.",
        ),
        ArticleSection(
          title: "Cómo mejorar tu salud intestinal hoy",
          content:
              "Plan de acción:\n\n1. COME MÁS FIBRA: 25-30g al día (verduras, frutas, leguminosas)\n2. INCLUYE ALIMENTOS FERMENTADOS 3-4 veces/semana\n3. VARÍA TU DIETA: la diversidad alimentaria crea microbiota diversa\n4. HIDRÁTATE BIEN\n5. DUERME 7-8 horas\n6. MANEJA EL ESTRÉS\n\nRecuerda: los cambios en la microbiota tardan semanas en notarse. La constancia es la clave.",
        ),
      ],
    ),
    Article(
      title: "Alimentación antiinflamatoria: Reduce la inflamación crónica",
      description:
          "Qué alimentos apagan el fuego interno y cuáles lo alimentan",
      content:
          "La inflamación crónica de bajo grado está detrás de muchas enfermedades modernas.",
      imageUrl: "lib/data/img/vegetables/brocoli.jpg",
      color: Colors.green,
      publishDate: DateTime.now().subtract(const Duration(days: 99)),
      tags: ["inflamación", "antioxidantes", "omega-3"],
      sections: [
        ArticleSection(
          title: "Inflamación aguda vs crónica",
          content:
              "La inflamación aguda es buena: es la respuesta del cuerpo para curarse (un esguince, una herida).\n\nLa inflamación crónica de bajo grado es el problema: el cuerpo se mantiene en 'alerta' constante, dañando tejidos lentamente. Se asocia con:\n• Enfermedad cardiovascular\n• Diabetes tipo 2\n• Sobrepeso y obesidad\n• Dolor articular\n• Enfermedades autoinmunes\n• Envejecimiento acelerado\n\nLa dieta es el principal interruptor de este fuego.",
        ),
        ArticleSection(
          title: "Alimentos antiinflamatorios",
          content:
              "Tu escudo antiinflamatorio:\n\n• PESCADOS GRASOS: Omega-3 (salmón, sardina, caballa)\n• AGUACATE: grasas monoinsaturadas\n• ACEITE DE OLIVA EXTRA VIRGEN\n• FRUTOS ROJOS: arándanos, fresas (antocianinas)\n• CÚRCUMA: curcumina (consume con pimienta negra para absorberla)\n• JENGIBRE\n• TOMATE: licopeno\n• VERDURAS DE HOJA VERDE\n• NUECES\n• TÉ VERDE\n• CHOCOLATE OSCURO (>70%)\n\nLa cúrcuma con pimienta negra y un toque de aceite mejora mucho la absorción de la curcumina.",
        ),
        ArticleSection(
          title: "Alimentos que inflaman",
          content:
              "Reduce estos:\n\n• AZÚCAR Y REFRESCOS\n• GRASAS TRANS (frituras, productos de paquete)\n• ACEITES VEGETALES REFINADOS en exceso\n• CARNE ROJA Y PROCESADA en exceso\n• HARINAS REFINADAS (pan blanco, pastas)\n• ALCOHOL\n• EXCESO DE OMEGA-6 (aceites de maíz, girasol en exceso)\n\nEl refresco azucarado es inflamatorio por partida doble: azúcar + aditivos. Uno de los cambios más potentes es eliminarlo.",
        ),
        ArticleSection(
          title: "El patrón alimentario completo",
          content:
              "Más que alimentos aislados, importa el patrón:\n\n• LA DIETA MEDITERRÁNEA es el mejor ejemplo: abundante pescado, verduras, frutas, aceite de oliva, nueces y poca carne roja y azúcar\n• INCLUYE ALIMENTOS FERMENTADOS: mejoran la inmunidad intestinal\n• HIERBAS Y ESPECIAS: ajo, cebolla, cúrcuma, jengibre, chile (capsaicina)\n\nLa cocina mexicana puede ser antiinflamatoria: pescado a la veracruzana, ensaladas de nopal, salsas de jitomate con ajo y hierbas.",
        ),
        ArticleSection(
          title: "Estilo de vida antiinflamatorio",
          content:
              "La alimentación no trabaja sola:\n\n• EJERCICIO REGULAR: reduce marcadores inflamatorios\n• SUEÑO ADECUADO: dormir mal eleva la inflamación\n• MANEJO DEL ESTRÉS: cortisol crónico inflama\n• EVITAR TABACO\n• MANTENER PESO SALUDABLE: el tejido graso abdominal produce sustancias inflamatorias\n\nEl sobrepeso abdominal es en sí una fuente de inflamación: perder incluso 5-10% del peso reduce los marcadores inflamatorios de forma notable.",
        ),
      ],
    ),
    Article(
      title: "Reflujo y acidez: Qué comer (y qué evitar)",
      description:
          "La alimentación para calmar la acidez y el reflujo gastroesofágico",
      content:
          "La acidez estomacal es incómoda, pero la dieta puede controlarla en gran medida.",
      imageUrl: "lib/data/img/vegetables/calabacin.jpg",
      color: Colors.orange,
      publishDate: DateTime.now().subtract(const Duration(days: 102)),
      tags: ["reflujo", "acidez", "digestión"],
      sections: [
        ArticleSection(
          title: "¿Qué causa la acidez?",
          content:
              "El reflujo ocurre cuando el ácido del estómago sube hacia el esófago:\n\n• El esfínter entre ambos se relaja o debilita\n• El contenido ácido irrita el esófago\n\nFactores que lo empeoran:\n• Sobrepeso y obesidad (presión abdominal)\n• Comidas muy abundantes\n• Acostarse después de comer\n• Tabaco y alcohol\n• Algunos alimentos y bebidas\n• Estrés",
        ),
        ArticleSection(
          title: "Alimentos que calman la acidez",
          content:
              "Alimentos suaves y alcalinizantes:\n\n• AVENA\n• PLÁTANO (poco ácido)\n• MELÓN Y PAPAYA\n• VERDURAS COCIDAS: calabacita, zanahoria, papa\n• JENGIBRE (infusión)\n• POLLO Y PESCADO A LA PLANCHA\n• ARROZ Y TORTILLA DE MAÍZ\n• MANZANILLA (té)\n• GALLETAS INTEGRALES\n\nComer papaya, que contiene papaína, ayuda a digerir mejor y calmar molestias.",
        ),
        ArticleSection(
          title: "Alimentos que provocan reflujo",
          content:
              "Evita o modera:\n\n• COMIDAS GRASOSAS Y FRITURAS (relajan el esfínter)\n• CAFÉ Y CAFEÍNA\n• ALCOHOL\n• REFRESCOS Y BEBIDAS CARBONATADAS\n• CÍTRICOS EN EXCESO (naranja, limón, toronja, tomate crudo)\n• CHOCOLATE\n• MENTA Y HIERBABUENA (relajan el esfínter)\n• CEBOLLA Y AJO EN CRUDO\n• PICANTE EN EXCESO\n• CARNES MAGRAS NO, PERO CARNES GRASOSAS SÍ\n\nNo tienes que eliminar todo: observa cuáles te afectan personalmente y modéralos.",
        ),
        ArticleSection(
          title: "Hábitos que previenen la acidez",
          content:
              "Tanto o más importante que la dieta:\n\n• COME PORCIONES MÁS PEQUEÑAS Y FRECUENTES\n• NO TE ACOSTES HASTA 2-3 HORAS DESPUÉS DE COMER\n• ELEVA LA CABECERA DE LA CAMA 10-15cm\n• NO COMAS 3 HORAS ANTES DE DORMIR\n• BAJA DE PESO si tienes sobrepeso\n• EVITA ROPA AJUSTADA\n• COME DESPACIO Y MASTICA BIEN\n\nEsperar 3 horas entre la cena y la cama es una de las medidas más efectivas contra el reflujo nocturno.",
        ),
        ArticleSection(
          title: "Cuándo ver a un médico",
          content:
              "No todo es 'simple acidez': consulta si presentas:\n\n• DOLOR EN EL PECHO (puede confundirse con angina)\n• DIFICULTAD PARA TRAGAR\n• VÓMITO CON SANGRE O HECES NEGRAS\n• PÉRDIDA DE PESO SIN CAUSA\n• SÍNTOMAS A PESAR DEL TRATAMIENTO\n\nEl reflujo crónico no tratado puede dañar el esófago (esófago de Barrett). No te automediques con antiácidos por tiempo indefinido sin supervisión médica.",
        ),
      ],
    ),
    Article(
      title: "Sistema inmune: Los alimentos que te defienden",
      description:
          "Nutre tus defensas para protegerte de gripes e infecciones",
      content:
          "La nutrición es el combustible de tu sistema inmunológico.",
      imageUrl: "lib/data/img/fruits/naranja.jpg",
      color: Colors.lightBlue,
      publishDate: DateTime.now().subtract(const Duration(days: 105)),
      tags: ["inmunidad", "defensas", "vitamina C"],
      sections: [
        ArticleSection(
          title: "Nutrición e inmunidad: la relación clave",
          content:
              "El sistema inmune es un ejército que necesita suministros constantes:\n\n• La malnutrición (déficit de nutrientes) debilita las defensas\n• Cada célula inmune requiere proteína para fabricarse\n• Vitaminas y minerales actúan como cofactores\n• El intestino alberga 70% de la inmunidad\n\nNingún alimento 'superheroico' te protege por sí solo: es el conjunto de una buena alimentación el que mantiene las defensas.",
        ),
        ArticleSection(
          title: "Los nutrientes estrella de la inmunidad",
          content:
              "Estos son los nutrientes con más evidencia:\n\n• VITAMINA C: guayaba, naranja, kiwi, pimiento\n• VITAMINA D: sol, pescados grasos, huevo (la mayoría de mexicanos tiene déficit)\n• ZINC: ostras, carne, semillas de calabaza\n• SELENIO: nueces de Brasil, atún\n• PROTEÍNA: huevo, pollo, frijoles\n• HIERRO: carne roja, frijoles, lentejas\n• PROBIÓTICOS: yogurt, fermentados\n\nLa guayaba supera a la naranja en vitamina C: una pieza cubre tu requerimiento diario.",
        ),
        ArticleSection(
          title: "La vitamina D: la más ignorada",
          content:
              "En México, el déficit de vitamina D es sorprendentemente común (más del 40% de adultos):\n\n• FUENTES: sol directo 15-20 min/día (antes de las 10am o después de las 4pm), pescados grasos, yema de huevo, hígado\n• FUNCIÓN: la vitamina D regula la respuesta inmune\n\nSi pasas mucho tiempo en interiores o tienes piel oscura, tu riesgo de déficit es mayor. Un análisis de sangre lo confirma y tu médico puede recomendar suplemento.",
        ),
        ArticleSection(
          title: "¿La vitamina C previene la gripe?",
          content:
              "El mito más famoso de la inmunidad:\n\n• NO previene la gripe en personas normales\n• SÍ reduce la duración y severidad del resfriado en ~8-14%\n• No hay beneficio de dosis megas (el exceso se elimina por orina)\n\nMejor estrategia: comer vitamina C en frutas y verduras todo el año, no solo cuando te enfermas. El cuerpo no almacena vitamina C, se consume diariamente.",
        ),
        ArticleSection(
          title: "Hábitos que debilitan tus defensas",
          content:
              "Mantén tus defensas fuertes evitando:\n\n• SUEÑO INSUFICIENTE (dormir <6 horas triplica el riesgo de resfriado)\n• ESTRÉS CRÓNICO\n• TABACO Y ALCOHOL EN EXCESO\n• DIETA ALTA EN AZÚCAR Y ULTRAprocesados\n• SEDENTARISMO\n\nEl ejercicio moderado (30-45 min) estimula la circulación de células inmunes; el ejercicio extenuante sin recuperación, en cambio, puede suprimirlas temporalmente.",
        ),
      ],
    ),
    Article(
      title: "Huesos fuertes: Calcio, vitamina D y más",
      description:
          "Prevén la osteoporosis desde hoy con la alimentación adecuada",
      content:
          "La masa ósea se construye desde joven y se protege toda la vida.",
      imageUrl: "lib/data/img/animal/leche.jpg",
      color: Colors.brown,
      publishDate: DateTime.now().subtract(const Duration(days: 108)),
      tags: ["huesos", "calcio", "osteoporosis"],
      sections: [
        ArticleSection(
          title: "¿Qué es la osteoporosis?",
          content:
              "La osteoporosis es la pérdida de densidad ósea que hace los huesos frágiles:\n\n• Es más común en mujeres posmenopáusicas\n• Puede causar fracturas graves (cadera, columna, muñeca)\n• Es SILENCIOSA: no da síntomas hasta la fractura\n\nLa masa ósea máxima se alcanza alrededor de los 25-30 años. Lo que comas antes de esa edad define tu 'banco de hueso' para el resto de la vida. Después, el objetivo es no perder.",
        ),
        ArticleSection(
          title: "Calcio: la materia prima",
          content:
              "Necesitas 1000-1300mg de calcio al día:\n\n• LECHE Y DERIVADOS: la fuente más concentrada\n• QUESO FRESCO Y PANELA: opciones mexicanas\n• TORTILLA DE MAÍZ NIXTAMALIZADA: calcio agregado en el proceso\n• FRITJOLES\n• BRÓCOLI, ESPINACA\n• AJONJOLÍ\n• ALMENDRAS\n• SARDINAS (con espinas, comestibles)\n\nLa nixtamalización (cocción del maíz con cal) es un invento mexicano que aporta calcio: una ventaja de la tortilla de maíz sobre la de harina.",
        ),
        ArticleSection(
          title: "Vitamina D: la llave del calcio",
          content:
              "Sin vitamina D, el cuerpo NO puede absorber el calcio:\n\n• FUENTE PRINCIPAL: sol (15-20 min al día)\n• ALIMENTOS: pescados grasos, yema, hígado, alimentos fortificados\n\nDéficit de vitamina D = huesos débiles incluso con calcio suficiente. Es el nutriente óseo más frecuentemente deficiente en México.",
        ),
        ArticleSection(
          title: "Más nutrientes para los huesos",
          content:
              "Los huesos no son solo calcio:\n\n• MAGNESIO: nueces, semillas, leguminosas, cacao\n• POTASIO: frutas y verduras\n• VITAMINA K: espinaca, brócoli, col (ayuda a fijar el calcio)\n• PROTEÍNA: suficiente para mantener la matriz ósea\n\nEvita el exceso de sodio y cafeína, que aumentan la pérdida de calcio por la orina.",
        ),
        ArticleSection(
          title: "Ejercicio y otros cuidados",
          content:
              "Los huesos responden al estímulo:\n\n• EJERCICIO DE IMPACTO Y FUERZA: caminar, subir escaleras, pesas\n• El hueso se fortalece cuando 'siente' peso\n• EVITA TABACO Y EXCESO DE ALCOHOL\n• PREVIENE CAÍDAS (alfombras, iluminación, calzado)\n\nEl ejercicio de fuerza no solo fortalece huesos, también músculos que protegen contra caídas y fracturas. Nunca es tarde para empezar.",
        ),
      ],
    ),
    Article(
      title: "Hígado graso: La epidemia silenciosa que puedes revertir",
      description:
          "Qué es el hígado graso no alcohólico y cómo la dieta lo revierte",
      content:
          "El hígado graso afecta a 1 de cada 3 mexicanos y es reversible con alimentación.",
      imageUrl: "lib/data/img/fruits/pina.jpg",
      color: Colors.amber,
      publishDate: DateTime.now().subtract(const Duration(days: 111)),
      tags: ["hígado", "hígado graso", "salud"],
      sections: [
        ArticleSection(
          title: "¿Qué es el hígado graso no alcohólico?",
          content:
              "El hígado acumula grasa sin que el alcohol sea la causa:\n\n• Se asocia a obesidad, diabetes y síndrome metabólico\n• Puede avanzar a inflamación, fibrosis y cirrosis\n• Es la enfermedad hepática más común en el mundo\n\nLa buena noticia: en sus etapas iniciales es REVERSIBLE con cambios de estilo de vida. El hígado es un órgano con gran capacidad de regeneración.",
        ),
        ArticleSection(
          title: "Los tres pilares para revertirlo",
          content:
              "1. BAJAR DE PESO: perder 7-10% del peso reduce significativamente la grasa hepática\n2. REDUCIR AZÚCAR Y FRUCTOSA: la fructosa procesada (jarabe de maíz de alta fructosa en refrescos) es la principal culpable de la grasa en el hígado\n3. EJERCICIO REGULAR: la actividad quema la grasa acumulada\n\nEl refresco y las bebidas azucaradas son el enemigo número uno del hígado graso.",
        ),
        ArticleSection(
          title: "Alimentos amigos del hígado",
          content:
              "Estos ayudan a tu hígado:\n\n• CAFÉ (sin azúcar): estudios muestran que reduce el riesgo de fibrosis\n• ACEITE DE OLIVA: grasa saludable\n• PESCADO Y OMEGA-3\n• VERDURAS: brócoli, espinaca, zanahoria\n• AVENA (fibra)\n• AGUACATE\n• TÉ VERDE\n• TÉ DE JAMAIBA O DE MANZANILLA\n\nEl café sin azúcar es de los aliados más sorprendentes: la evidencia asocia su consumo con menor riesgo de daño hepático.",
        ),
        ArticleSection(
          title: "Alimentos a evitar",
          content:
              "Reduce drásticamente:\n\n• REFRESCOS Y BEBIDAS AZUCARADAS\n• FRITURAS\n• ALCOHOL\n• CARNES PROCESADAS\n• HARINAS REFINADAS\n• EXCESO DE FRUCTOSA (fruta en jugos, jarabes)\n\nOjo con el falso 'natural': los jugos de fruta (aunque sean naturales) concentran fructosa sin la fibra de la fruta entera. Prefiere la fruta entera.",
        ),
        ArticleSection(
          title: "El plan de acción",
          content:
              "Si te diagnosticaron hígado graso:\n\n• SÍGUELO CON TU MÉDICO: requiere monitoreo\n• PIERDE PESO GRADUALMENTE (0.5-1kg por semana)\n• ADOPTA UNA DIETA TIPO MEDITERRÁNEA\n• EJERCÍTATE 150 min/semana\n• EVITA EL ALCOHOL\n• CONTROLA LA DIABETES Y EL COLESTEROL\n\nLa reversión es posible: pacientes que pierden peso y cambian hábitos ven desaparecer la grasa hepática en exámenes posteriores.",
        ),
      ],
    ),
    Article(
      title: "Tiroides: Alimentación para hipotiroidismo y hipertiroidismo",
      description:
          "Cómo la dieta apoya a tu glándula tiroides y su función",
      content:
          "La tiroides regula tu metabolismo y tu alimentación influye en su funcionamiento.",
      imageUrl: "lib/data/img/fruits/coco.jpg",
      color: Colors.pink,
      publishDate: DateTime.now().subtract(const Duration(days: 114)),
      tags: ["tiroides", "hormonas", "metabolismo"],
      sections: [
        ArticleSection(
          title: "¿Qué hace la tiroides?",
          content:
              "La tiroides es una glándula en el cuello que produce hormonas (T3 y T4) que controlan el metabolismo.\n\n• HIPOTIROIDISMO: tiroides lenta → fatiga, aumento de peso, frío, cabello débil\n• HIPERTIROIDISMO: tiroides acelerada → pérdida de peso, nerviosismo, palpitaciones\n\nEl hipotiroidismo (a menudo por tiroiditis de Hashimoto, autoinmune) es mucho más común, sobre todo en mujeres.",
        ),
        ArticleSection(
          title: "Yodo: el nutriente clave",
          content:
              "El yodo es la materia prima de las hormonas tiroideas:\n\n• FUENTES: sal yodada, pescados y mariscos de mar, huevo, lácteos\n\nMéxico yodó su sal por ley, lo que erradicó el bocio. Sin embargo:\n• Algunas sales 'gourmet' (de mar, rosada) no están yodadas\n• Dietas muy restrictivas pueden carecer de yodo\n\nConsejo: usa sal yodada en casa y evita excesos de suplementos de yodo (el exceso también daña la tiroides).",
        ),
        ArticleSection(
          title: "Selenio y zinc: apoyos importantes",
          content:
              "La tiroides necesita estos minerales para activar sus hormonas:\n\n• SELENIO: nueces de Brasil (1-2 al día), atún, sardina, huevo\n• ZINC: carne, semillas de calabaza, ostras\n\nEl selenio es particularmente relevante en la tiroiditis de Hashimoto: ayuda a reducir los anticuerpos. No tomes suplementos de selenio sin indicación médica (el exceso es tóxico).",
        ),
        ArticleSection(
          title: "Nutrientes que apoyan la función tiroidea",
          content:
              "Complementa con:\n\n• VITAMINA D: déficit muy común en pacientes tiroideos\n• HIERRO Y VITAMINA B12: deficiencias frecuentes\n• MAGNESIO\n\nY mantén una dieta rica en antioxidantes (frutas y verduras de colores) para apoyar la función general.",
        ),
        ArticleSection(
          title: "Qué evitar y recomendaciones finales",
          content:
              "Precauciones:\n\n• SOYA: contiene compuestos que pueden interferir con la absorción de levotiroxina (tu medicamento). Toma tu medicamento y espera 4 horas antes de consumir soya\n• BRÓCOLI, COL, NABO (cocidos moderan los goitrógenos)\n• NO TE AUTOMEDIQUES: el tratamiento es médico, la dieta es apoyo\n\nRecuerda: no hay 'dieta milagrosa' para la tiroides. Lleva tu medicamento, come balanceado, haz ejercicio y duerme bien. La alimentación acompaña, el tratamiento médico cura.",
        ),
      ],
    ),
    Article(
      title: "Menopausia: Nutrición para una etapa de cambio",
      description:
          "Alimentos y nutrientes clave para atravesar la menopausia con bienestar",
      content:
          "La menopausia es un proceso natural que se vive mejor con buena nutrición.",
      imageUrl: "lib/data/img/fruits/granada.jpg",
      color: Colors.deepPurple,
      publishDate: DateTime.now().subtract(const Duration(days: 117)),
      tags: ["menopausia", "mujeres", "hormonas"],
      sections: [
        ArticleSection(
          title: "Los cambios que trae la menopausia",
          content:
              "Al bajar el estrógeno ocurren cambios que la nutrición puede amortiguar:\n\n• MENOR METABOLISMO: tendencia a ganar peso (sobre todo abdominal)\n• PÉRDIDA DE MASA ÓSEA: riesgo de osteoporosis\n• CAMBIOS EN COLESTEROL: mayor riesgo cardiovascular\n• BOCHORNOS Y ALTERACIONES DEL SUEÑO\n• CAMBIOS EN LA MASA MUSCULAR\n\nLa buena noticia: la dieta y el ejercicio mitigan todos estos cambios.",
        ),
        ArticleSection(
          title: "Nutrientes clave en la menopausia",
          content:
              "Prioriza:\n\n• CALCIO (1200mg) Y VITAMINA D: lácteos, sardinas, brócoli, sol\n• PROTEÍNA (1.0-1.2g/kg): para mantener masa muscular y ósea\n• OMEGA-3: salmón, sardina, chía, nueces (ayuda a bochornos y corazón)\n• MAGNESIO: mejora sueño y ánimo\n• FIBRA: controla el peso y el colesterol\n• SOYA (con moderación): isoflavonas pueden aliviar bochornos\n\nLa proteína se vuelve crítica después de la menopausia: ayuda a combatir la sarcopenia y mantener el metabolismo.",
        ),
        ArticleSection(
          title: "Alimentos que ayudan con los bochornos",
          content:
              "Estrategias nutricionales:\n\n• SOYA Y PRODUCTOS DE SOYA (tofu, bebida de soya): isoflavonas con efecto similar a estrógenos suaves\n• LINAZA: lignanos\n• AGUA FRÍA y comidas más ligeras\n• REDUCE PICANTE, CAFEÍNA Y ALCOHOL: pueden disparar bochornos\n• MANTENTE HIDRATADA\n\nCada mujer es distinta: algunos alimentos le sientan bien a unas y mal a otras. Observa tus propios disparadores.",
        ),
        ArticleSection(
          title: "Protegiendo el corazón y los huesos",
          content:
              "El riesgo cardiovascular aumenta tras la menopausia:\n\n• GRASAS SALUDABLES: aguacate, aceite de oliva, nueces\n• PESCADO 2-3 veces/semana\n• MENOS SODIO y grasas saturadas\n• EJERCICIO AERÓBICO + FUERZA\n• CALCIO + VITAMINA D + EJERCICIO DE IMPACTO para huesos\n\nEl ejercicio de fuerza (2-3 veces/semana) es doblemente valioso: fortalece huesos y músculo, y acelera el metabolismo.",
        ),
        ArticleSection(
          title: "Control de peso en la menopausia",
          content:
              "El metabolismo baja, pero no estás condenada a engordar:\n\n• AUMENTA LA PROTEÍNA y la fibra (más saciedad)\n• REDUCE CALORÍAS LÍQUIDAS (refrescos, jugos, alcohol)\n• COMIDAS CONSCIENTES, porciones controladas\n• EJERCICIO REGULAR incluyendo fuerza\n• SUEÑO ADECUADO (el mal sueño desregula el apetito)\n\nEl objetivo no es 'no envejecer', es envejecer fuerte y sano. La masa muscular es tu aliada metabólica.",
        ),
      ],
    ),
    Article(
      title: "Alimentación para estudiar: Nutre tu cerebro",
      description:
          "Comidas y nutrientes para concentrarte y rendir en tus estudios",
      content:
          "Tu cerebro es un órgano hambriento: consume 20% de tu energía diaria.",
      imageUrl: "lib/data/img/cereales/arrozintegral.jpg",
      color: Colors.indigo,
      publishDate: DateTime.now().subtract(const Duration(days: 120)),
      tags: ["cerebro", "estudio", "concentración"],
      sections: [
        ArticleSection(
          title: "El cerebro y sus nutrientes favoritos",
          content:
              "Estos nutrientes son críticos para la función cognitiva:\n\n• OMEGA-3 (DHA): es la grasa estructural del cerebro. Salmón, sardina, chía, nuez\n• GLUCOSA ESTABLE: el cerebro usa glucosa, pero prefiere liberación lenta (carbohidratos complejos)\n• VITAMINAS DEL COMPLEJO B: participación en la energía neuronal\n• HIERRO: el cerebro con deficiencia rinde menos\n• ANTIOXIDANTES: protegen las neuronas\n• AGUA: deshidratación = caída de la concentración\n\nUn buen desayuno es la base del rendimiento escolar: los niños que desayunan se concentran mejor.",
        ),
        ArticleSection(
          title: "Comidas ideales antes de estudiar",
          content:
              "Come 1-2 horas antes de estudiar:\n\n• AVENA CON FRUTA Y NUEZ: carbohidrato complejo + omega-3\n• HUEVO CON TORTILLA Y AGUACATE: proteína + grasa buena\n• SANDWICH INTEGRAL DE ATÚN O POLLO\n• LICUADO DE PLÁTANO CON CHÍA\n• YOGURT CON AMARANTO\n\nEvita antes de estudiar: comidas pesadas (sueño), azúcar (pico y bajón), comidas ultraprocesadas.",
        ),
        ArticleSection(
          title: "Snacks para sesiones largas de estudio",
          content:
              "El 'antojito' de media tarde del estudiante:\n\n• NUECES Y ALMENDRAS\n• FRUTA (manzana, plátano)\n• GARBANZOS TOSTADOS\n• YOGURT NATURAL\n• AGUA O TÉ VERDE SIN AZÚCAR\n• CHOCOLATE OSCURO (>70%): un cuadrito mejora el ánimo\n\nEvita el 'dopaje' con energía: los energizantes y el exceso de café causan ansiedad y un bajón posterior. La cafeína moderada (1-2 tazas de café/té) es suficiente.",
        ),
        ArticleSection(
          title: "Hidratación: el cerebro funciona mejor hidratado",
          content:
              "La deshidratación afecta directamente la cognición:\n\n• Pérdida de 1-2% de peso en agua: caída en concentración y memoria\n• El cerebro es ~75% agua\n• Bebe agua de forma regular durante el estudio\n\nLleva una botella de agua y establece horarios: en épocas de exámenes es fácil olvidar beber mientras se estudia.",
        ),
        ArticleSection(
          title: "Rutina completa para estudiar bien",
          content:
              "La nutrición es parte del método de estudio:\n\n• DESAYUNA SIEMPRE\n• COME EQUILIBRADO a las horas regulares\n• HIDRÁTATE\n• DESCANSA: dormir consolida la memoria (estudiar toda la noche es contraproducente)\n• EJERCÍCITE: 20-30 min mejora la memoria\n• PAUSAS ACTIVAS cada 45-50 min\n\nEstudiar no se trata solo de horas: la calidad cognitiva depende de combustible adecuado y descanso real.",
        ),
      ],
    ),
  ];
}
