import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';
import 'package:nutriplato/infrastructure/entities/article/article_section.dart';

/// Artículos de fundamentos de nutrición.
List<Article> nutricionArticles() {
  return [
    Article(
      title: "Macronutrientes: Carbohidratos, proteínas y grasas",
      description:
          "Entiende los tres pilares de la alimentación y cómo balancearlos en tu plato",
      content:
          "Los macronutrientes son los nutrientes que tu cuerpo necesita en mayor cantidad.",
      imageUrl: "lib/data/img/nutrition_balance.jpeg",
      color: Colors.green,
      publishDate: DateTime.now().subtract(const Duration(days: 21)),
      tags: ["macronutrientes", "nutrición", "básicos"],
      sections: [
        ArticleSection(
          title: "¿Qué son los macronutrientes?",
          content:
              "Los macronutrientes son los nutrientes que el cuerpo utiliza en grandes cantidades para obtener energía y construir tejidos. Se dividen en tres grupos:\n\n• CARBOHIDRATOS: Principal fuente de energía (4 kcal/g)\n• PROTEÍNAS: Construyen y reparan tejidos (4 kcal/g)\n• GRASAS: Energía de reserva y funciones hormonales (9 kcal/g)\n\nPara una persona promedio, la NOM-043 recomienda una distribución aproximada de:\n• 50-60% de carbohidratos\n• 15-20% de proteínas\n• 25-30% de grasas",
        ),
        ArticleSection(
          title: "Carbohidratos: No todos son iguales",
          content:
              "Los carbohidratos han sido injustamente demonizados. La clave está en el tipo:\n\n• SIMPLES (azúcares): Se absorben rápido, causan picos de glucosa. Ej: azúcar, miel, refrescos\n• COMPLEJOS (almidones y fibra): Liberación lenta de energía. Ej: tortilla de maíz, avena, frijoles\n\nEl INSP recomienda que los carbohidratos complejos representen la mayor parte del consumo. Una tortilla de maíz es una opción mucho mejor que un refresco: ambos son carbohidratos, pero uno aporta fibra, calcio y niacina.",
        ),
        ArticleSection(
          title: "Proteínas: Los ladrillos del cuerpo",
          content:
              "Las proteínas están formadas por aminoácidos, y el cuerpo necesita 20 de ellos (9 esenciales que deben venir de los alimentos):\n\n• DE ORIGEN ANIMAL: Completa, alta biodisponibilidad (huevo, pollo, pescado, leche)\n• DE ORIGEN VEGETAL: Combinar cereales + leguminosas para completar (frijoles + tortilla)\n\nLa combinación tradicional mexicana de frijoles con maíz aporta todos los aminoácidos esenciales, al igual que una carne, pero con fibra extra y menor costo.",
        ),
        ArticleSection(
          title: "Grasas: El nutriente mal entendido",
          content:
              "Las grasas son esenciales para la vida: forman membranas celulares, producen hormonas y ayudan a absorber vitaminas. Pero hay diferencias:\n\n• SALUDABLES: Aguacate, aceite de oliva, nueces, pescados grasos (omega-3)\n• LIMITAR: Grasas saturadas (carnes rojas, mantequilla, queso)\n• EVITAR: Grasas trans (productos ultraprocesados, frituras comerciales)\n\nEl nuevo etiquetado mexicano advierte con sellos cuando un producto tiene exceso de grasas saturadas o trans. Evitar estas últimas es una de las decisiones más importantes para tu corazón.",
        ),
        ArticleSection(
          title: "Cómo balancear tu plato",
          content:
              "El método del plato es la forma más sencilla de balancear tus macronutrientes:\n\n• ½ plato: Verduras y frutas (fibra, vitaminas, minerales)\n• ¼ plato: Proteínas (carnes magras, huevo, frijoles)\n• ¼ plato: Carbohidratos complejos (tortilla, arroz integral, papa)\n\nY una cucharadita de grasas saludables (aguacate, aceite de oliva) para completar. Así logras un equilibrio automático sin contar gramos.",
        ),
      ],
    ),
    Article(
      title: "Micronutrientes: Las vitaminas que tu cuerpo agradece",
      description:
          "Conoce las vitaminas y minerales clave para los mexicanos y dónde encontrarlas",
      content:
          "Las vitaminas y minerales son vitales en pequeñas cantidades.",
      imageUrl: "lib/data/img/vegetables/zanahoria.jpg",
      color: Colors.orange,
      publishDate: DateTime.now().subtract(const Duration(days: 24)),
      tags: ["vitaminas", "minerales", "salud"],
      sections: [
        ArticleSection(
          title: "¿Qué son los micronutrientes?",
          content:
              "A diferencia de los macronutrientes, las vitaminas y minerales se necesitan en cantidades pequeñas (microgramos o miligramos), pero sin ellos el cuerpo no puede funcionar. Participan en prácticamente todas las reacciones bioquímicas.\n\nDeficiencias comunes en México según la ENSANUT:\n• Hierro (anemia en 1 de cada 4 niños)\n• Vitamina D (más del 40% de adultos)\n• Zinc y vitamina A\n\nLa mejor estrategia: comer una dieta variada con muchos colores, en lugar de depender de suplementos.",
        ),
        ArticleSection(
          title: "Vitaminas esenciales y sus fuentes",
          content:
              "Guía rápida de vitaminas clave:\n\n• VITAMINA A: Visión e inmunidad. Zanahoria, papaya, hígado, queso\n• VITAMINA C: Antioxidante, cicatrización. Guayaba, kiwi, cítricos, pimiento\n• VITAMINA D: Huesos e inmunidad. Sol, pescados grasos, yema de huevo\n• VITAMINA E: Protege células. Nueces, aguacate, aceites vegetales\n• VITAMINA K: Coagulación. Espinaca, brócoli, col\n• COMPLEJO B: Energía y sistema nervioso. Cereales integrales, leguminosas, carne\n\nDato: La guayaba tiene 4 veces más vitamina C que la naranja. Una sola pieza cubre tu requerimiento diario.",
        ),
        ArticleSection(
          title: "Minerales que suelen faltar",
          content:
              "Estos minerales son especialmente importantes para los mexicanos:\n\n• HIERRO: Transporta oxígeno. Frijoles, carne roja, hígado. Combínalo con vitamina C (limón) para mejorar absorción\n• CALCIO: Huesos y dientes. Leche, queso, tortilla de maíz nixtamalizada, brócoli\n• ZINC: Inmunidad y cicatrización. Ostras, carne, semillas de calabaza\n• MAGNESIO: Músculos y nervios. Frutos secos, plátano, espinaca\n• POTASIO: Presión arterial. Plátano, jitomate, aguacate\n• YODO: Tiroides. Sal yodada, pescados de mar\n\nUn platillo clásico que combina varios: frijoles (hierro) + tortilla de maíz (calcio) + salsa con limón (vitamina C).",
        ),
        ArticleSection(
          title: "Señales de deficiencia",
          content:
              "Reconoce posibles señales de que te falta algún micronutriente:\n\n• Cansancio constante y palidez: posible deficiencia de hierro\n• Problemas de visión nocturna: vitamina A\n• Grietas en comisuras de boca: vitaminas B\n• Calambres musculares: magnesio o potasio\n• Heridas que tardan en sanar: zinc o vitamina C\n\nIMPORTANTE: Estas señales pueden tener muchas causas. Si las presentas de forma persistente, consulta a un médico. No te auto-diagnostiques ni tomes suplementos sin supervisión, ya que el exceso de algunos (como la vitamina A) también es dañino.",
        ),
      ],
    ),
    Article(
      title: "Fibra: El nutriente que limpia tu intestino",
      description:
          "Cómo la fibra mejora tu digestión, corazón y control de peso",
      content:
          "La fibra es un carbohidrato que tu cuerpo no digiere, pero que te hace bien.",
      imageUrl: "lib/data/img/vegetables/brocoli.jpg",
      color: Colors.lightGreen,
      publishDate: DateTime.now().subtract(const Duration(days: 27)),
      tags: ["fibra", "digestión", "salud intestinal"],
      sections: [
        ArticleSection(
          title: "¿Qué es la fibra y por qué importa?",
          content:
              "La fibra es la parte de los alimentos vegetales que el cuerpo humano no puede digerir. No aporta calorías, pero es esencial:\n\n• Regula el tránsito intestinal\n• Alimenta a las bacterias buenas del colon (prebiótico)\n• Reduce la absorción de azúcar y colesterol\n• Da saciedad y ayuda al control de peso\n\nLa recomendación es de 25-30g al día, pero el mexicano promedio consume menos de 15g.",
        ),
        ArticleSection(
          title: "Fibra soluble vs insoluble",
          content:
              "Existen dos tipos de fibra con funciones complementarias:\n\n• SOLUBLE: Forma un gel con el agua, reduce colesterol y glucosa. Ej: avena, frijoles, manzana, nopal\n• INSOLUBLE: Aumenta el volumen de las heces y acelera el tránsito. Ej: salvado de trigo, verduras, nueces\n\nEl nopal es una fuente sobresaliente de fibra soluble, una de las razones por las que ayuda a controlar la glucosa en sangre.",
        ),
        ArticleSection(
          title: "Alimentos mexicanos ricos en fibra",
          content:
              "No necesitas buscar alimentos exóticos. La despensa mexicana está llena de fibra:\n\n• FRIJOLES: 15g de fibra por taza (una de las mejores fuentes)\n• TORTILLA DE MAÍZ: 2g por pieza\n• NOPALES: 5g por porción\n• AVENA: 10g por porción\n• AGUACATE: 7g por pieza\n• GUAYABA: 5g por pieza\n• AMARANTO: 15g por 100g\n\nComer una taza de frijoles + 2 tortillas + nopalitos en una comida ya te acerca a tu meta diaria.",
        ),
        ArticleSection(
          title: "Cómo aumentar tu consumo sin molestias",
          content:
              "Si hoy comes poca fibra, aumenta gradualmente para evitar inflamación y gases:\n\n• Incrementa una porción de fibra cada 3-4 días\n• Acompaña con suficiente agua (la fibra necesita líquido)\n• Prefiere fruta entera en lugar de jugos\n• Deja la cáscara de frutas y verduras bien lavadas\n• Cocina leguminosas con hierbas (epazote, hinojo) para mejor digestión\n\nAumentar la fibra lentamente y con agua suficiente es la clave para que el intestino se adapte sin molestias.",
        ),
      ],
    ),
    Article(
      title: "Antioxidantes: Escudos contra el envejecimiento",
      description:
          "Qué son, dónde encontrarlos y por qué importan para tu salud",
      content:
          "Los antioxidantes protegen a tus células del daño oxidativo.",
      imageUrl: "lib/data/img/fruits/arandano.jpg",
      color: Colors.deepPurple,
      publishDate: DateTime.now().subtract(const Duration(days: 30)),
      tags: ["antioxidantes", "envejecimiento", "salud"],
      sections: [
        ArticleSection(
          title: "¿Qué son los radicales libres y los antioxidantes?",
          content:
              "Los radicales libres son moléculas inestables que se producen por procesos normales del cuerpo y factores externos (contaminación, tabaco, sol, estrés). En exceso, dañan las células y aceleran el envejecimiento.\n\nLos ANTIOXIDANTES neutralizan estos radicales libres:\n• Vitaminas C y E\n• Betacaroteno (provitamina A)\n• Polifenoles y flavonoides\n• Selenio y zinc\n• Licopeno y luteína\n\nLa mejor fuente es la dieta, no los suplementos. Los estudios muestran que los antioxidantes funcionan mejor en su contexto natural (frutas y verduras enteras).",
        ),
        ArticleSection(
          title: "Alimentos mexicanos ricos en antioxidantes",
          content:
              "Nuestra tierra tiene algunos de los alimentos más antioxidantes del mundo:\n\n• JITOMATE: Licopeno (mejor absorbido cocido, en salsas y sopas)\n• CHILE: Capsaicina y vitamina C\n• CACAO: Más flavonoides que el té verde\n• FRUJILLA/FRAMBUESA: Antocianinas\n• AGUACATE: Vitamina E y luteína\n• JAMAICA: Antocianinas (água de flor de jamaica)\n• MAÍZ MORADO Y AZUL: Antocianinas\n• NOPAL: Betalaínas\n• NUEZ PECANERA: Vitamina E\n\nUn consejo: entre más colorido sea tu plato (rojo, morado, verde, naranja), mayor variedad de antioxidantes consumes.",
        ),
        ArticleSection(
          title: "El poder del color",
          content:
              "Cada color de fruta y verdura indica antioxidantes diferentes:\n\n• ROJO: Licopeno (jitomate, sandía, guayaba rosada)\n• NARANJA/AMARILLO: Betacaroteno (zanahoria, papaya, calabaza)\n• VERDE: Luteína y clorofila (espinaca, brócoli, nopal)\n• MORADO/AZUL: Antocianinas (arándano, berenjena, maíz morado)\n• BLANCO: Quercetina y alicina (ajo, cebolla, jícama)\n\nReto de la semana: Intenta incluir 5 colores diferentes de vegetales cada día. Es la forma más visual de garantizar variedad de antioxidantes.",
        ),
        ArticleSection(
          title: "Hábitos que aumentan el estrés oxidativo",
          content:
              "Reducir estos factores multiplica el beneficio de los antioxidantes:\n\n• Tabaco: Genera miles de radicales libres por bocanada\n• Alcohol en exceso\n• Sedentarismo crónico\n• Comer ultraprocesados con grasas trans\n• Exposición solar sin protección\n• Estrés crónico y mal sueño\n• Consumo excesivo de azúcar\n\nLa combinación ganadora es: comer alimentos coloridos + ejercicio regular + dormir bien + evitar tabaco y alcohol. Los antioxidantes son un complemento, no un escudo mágico.",
        ),
      ],
    ),
    Article(
      title: "Grasas buenas vs grasas malas: La guía definitiva",
      description:
          "Aprende a distinguir las grasas que protegen tu corazón de las que lo dañan",
      content:
          "No todas las grasas son enemigas de tu salud cardiovascular.",
      imageUrl: "lib/data/img/animal/salmon.jpg",
      color: Colors.teal,
      publishDate: DateTime.now().subtract(const Duration(days: 33)),
      tags: ["grasas", "corazón", "colesterol"],
      sections: [
        ArticleSection(
          title: "Las grasas que tu cuerpo necesita",
          content:
              "Las grasas saludables son indispensables:\n\n• MONOINSATURADAS: Aguacate, aceite de oliva, nueces\n• POLIINSATURADAS (omega-3 y omega-6): Pescados grasos, semillas de chía, nueces\n\nBeneficios:\n• Protegen el corazón\n• Reducen inflamación\n• Absorben vitaminas A, D, E, K\n• Forman hormonas\n• Dan energía de reserva\n\nEl aguacate mexicano es una de las mejores fuentes de grasas monoinsaturadas del mundo, y México es su principal productor.",
        ),
        ArticleSection(
          title: "Las grasas que debes limitar",
          content:
              "GRASAS SATURADAS: Aumentan el colesterol LDL (malo). Limítalas:\n• Carnes rojas y procesadas\n• Mantequilla y manteca\n• Quesos y crema en exceso\n• Aceite de palma y coco\n\nRecomendación: Menos del 10% de tus calorías diarias (aprox. 20g para una dieta de 2000 kcal). Prefiere cortes magros y retira la grasa visible.",
        ),
        ArticleSection(
          title: "Grasas trans: El peor enemigo",
          content:
              "Las grasas trans son las únicas que debes EVITAR casi por completo:\n\n• Aumentan el colesterol malo Y bajan el bueno\n• Elevan riesgo de infarto y diabetes\n• Causan inflamación sistémica\n\n¿Dónde están?\n• Frituras comerciales\n• Galletas y pasteles industriales\n• Palomitas de microondas\n• Cremas no lácteas\n• Comida rápida\n\nEl etiquetado frontal mexicano (NOM-051) incluye un sello de EXCESO GRASAS TRANS para ayudarte a detectarlas. Si un producto lo tiene, mejor busca otra opción.",
        ),
        ArticleSection(
          title: "Cómo incorporar grasas buenas",
          content:
              "Cambios sencillos con gran impacto:\n\n• Cocina con aceites vegetales (oliva, aguacate) en lugar de manteca\n• Agrega aguacate a tus tacos y ensaladas (en lugar de crema)\n• Come pescado graso (sardina, salmón) 2 veces por semana\n• Espolvorea chía, linaza o nueces sobre tu yogurt o avena\n• Usa semillas de calabaza y cacahuate como botana\n\nRecuerda: Las grasas aportan el doble de calorías por gramo, así que aunque sean saludables, la porción importa.",
        ),
      ],
    ),
    Article(
      title: "Proteína vegetal vs animal: ¿Cuál elegir?",
      description:
          "Comparativa completa para tomar la mejor decisión según tu estilo de vida",
      content:
          "Tanto las proteínas animales como las vegetales tienen su lugar en una dieta saludable.",
      imageUrl: "lib/data/img/leguminosas/garbanzos.jpg",
      color: Colors.brown,
      publishDate: DateTime.now().subtract(const Duration(days: 36)),
      tags: ["proteína", "vegetariano", "nutrición"],
      sections: [
        ArticleSection(
          title: "Las diferencias fundamentales",
          content:
              "PROTEÍNA ANIMAL:\n• Contiene los 9 aminoácidos esenciales (completa)\n• Alta biodisponibilidad (se aprovecha bien)\n• Fuente de B12, hierro hemo y zinc\n• Puede traer grasas saturadas y colesterol\n\nPROTEÍNA VEGETAL:\n• Puede ser incompleta (faltar algunos aminoácidos)\n• Aporta fibra, fitoquímicos y cero colesterol\n• Menor huella ambiental\n• Necesita combinarse para completarse\n\nLa clave está en la combinación y en la calidad global de tu dieta.",
        ),
        ArticleSection(
          title: "Las combinaciones mexicanas que completan",
          content:
              "La cocina mexicana tiene combinaciones perfectas que crean proteína completa:\n\n• FRIJOLES + TORTILLA (la clásica): Los frijoles aportan lisina, el maíz metionina. Juntos, todos los aminoácidos\n• LENTEJAS + ARROZ: Platillo completo\n• GARBANZOS + PAN: Hummus con pan integral\n• SOYA + MAÍZ: Alimentos a base de soya con tortilla\n• AVENA + LECHE: Cereal + lácteo\n\nComer estos pares no necesita ser en la misma comida; basta con que sea el mismo día.",
        ),
        ArticleSection(
          title: "Fuentes vegetales de proteína",
          content:
              "Estas son las mejores fuentes vegetales (proteína por 100g):\n\n• SOYA/TEXTURIZADO: 36g\n• AMARANTO: 16g\n• SEMILLAS DE CALABAZA: 19g\n• LENTEJAS: 9g\n• GARBANZOS: 9g\n• FRIJOLES: 8-9g\n• CACAHUATE: 26g\n• CHÍA: 17g\n\nUn platillo de frijoles con tortillas y nopalitos puede aportar 20-25g de proteína, comparable a una porción de carne.",
        ),
        ArticleSection(
          title: "Nutrientes a vigilar si reduces la carne",
          content:
              "Si decides reducir o eliminar productos animales, presta atención a:\n\n• VITAMINA B12: Solo está en productos animales. Considera alimentos fortificados o suplemento\n• HIERRO: El vegetal (no hemo) se absorbe menos. Combínalo con vitamina C\n• ZINC: Menos disponible en vegetales. Semillas y leguminosas ayudan\n• CALCIO: Si eliminas lácteos, busca fortificados, brócoli, ajonjolí, tortilla nixtamalizada\n• OMEGA-3: Si no comes pescado, prioriza chía, linaza y nueces\n\nCon planeación adecuada, una dieta vegetariana o vegana puede ser saludable en todas las etapas de vida.",
        ),
      ],
    ),
    Article(
      title: "Calorías: Todo lo que debes saber para controlar tu peso",
      description:
          "Qué son las calorías, cuántas necesitas y cómo usarlas a tu favor",
      content:
          "Las calorías son la unidad de energía que tu cuerpo usa para funcionar.",
      imageUrl: "lib/data/img/plato_del_bien_comer.jpeg",
      color: Colors.blueGrey,
      publishDate: DateTime.now().subtract(const Duration(days: 39)),
      tags: ["calorías", "peso", "energía"],
      sections: [
        ArticleSection(
          title: "¿Qué es una caloría?",
          content:
              "Una caloría (kilocaloría, kcal) mide la energía que un alimento aporta al cuerpo. Esta energía se usa para:\n\n• Mantener funciones vitales (respirar, latir el corazón)\n• Realizar actividades físicas\n• Mantener la temperatura corporal\n• Reparar y construir tejidos\n\nLos macronutrientes aportan:\n• Carbohidratos: 4 kcal/g\n• Proteínas: 4 kcal/g\n• Grasas: 9 kcal/g\n• Alcohol: 7 kcal/g\n\nEl balance energético es simple: si consumes más calorías de las que gastas, subes de peso; si consumes menos, bajas.",
        ),
        ArticleSection(
          title: "¿Cuántas calorías necesitas?",
          content:
              "El requerimiento varía según edad, sexo, peso y actividad:\n\n• MUJER sedentaria: 1600-1800 kcal\n• HOMBRE sedentario: 2000-2200 kcal\n• Mujer activa: 2000-2200 kcal\n• Hombre activo: 2400-2800 kcal\n• Deportistas: 3000+ kcal\n\nFórmula rápida: multiplica tu peso en kg por 25-30 para estimar tu mantenimiento. Ej: 70kg × 27 = 1890 kcal.\n\nEstos son estimados. El mejor indicador es tu propio peso: si se mantiene estable, estás comiendo lo correcto.",
        ),
        ArticleSection(
          title: "Calorías vacías: el problema de los ultraprocesados",
          content:
              "No todas las calorías son iguales. Las CALORÍAS VACÍAS aportan energía sin nutrientes:\n\n• Refrescos y bebidas azucaradas: azúcar pura sin valor nutricional\n• Dulces y golosinas\n• Frituras de bolsa\n• Pan dulce industrial\n• Jugos industrializados\n\nUn refresco de 600ml tiene ~250 kcal que podrían ser: 3 piezas de fruta, o 2 tazas de frijoles, o una porción de pollo con verduras. La misma energía, pero completamente distinto en nutrientes.\n\nLas bebidas azucaradas son la principal fuente de calorías vacías en México: 1 de cada 10 calorías consumidas viene de un refresco.",
        ),
        ArticleSection(
          title: "Calorías que sí alimentan",
          content:
              "Para sentirte satisfecho con menos calorías, prioriza alimentos con alta densidad nutricional:\n\n• Verduras: Mucho volumen, pocas calorías (100g de brócoli = 34 kcal)\n• Frutas: Saciantes y nutritivas\n• Proteínas magras: Dan saciedad duradera\n• Leguminosas: Proteína + fibra + carbohidratos complejos\n\nTruco: Comer 5 porciones de verduras al día llena el estómago con menos de 200 kcal. Lo mismo que un puñado de papas fritas (250 kcal) que no te deja satisfecho.",
        ),
        ArticleSection(
          title: "Mitos calóricos comunes",
          content:
              "Desmintamos las creencias más comunes:\n\n• MITO: \"Contar calorías es lo único que importa\" — La calidad nutricional también cuenta para la salud\n• MITO: \"Las calorías negativas existen\" — El apio no quema más de lo que aporta\n• MITO: \"Comer de noche engorda más\" — El total diario importa más que el horario\n• MITO: \"Todas las dietas bajas en calorías sirven\" — Restricciones extremas causan efecto rebote\n• REALIDAD: Pequeños déficits sostenidos (300-500 kcal/día) funcionan mejor que dietas extremas",
        ),
      ],
    ),
    Article(
      title: "Índice glucémico: Tu herramienta contra el azúcar alto",
      description:
          "Cómo los alimentos afectan tu glucosa y por qué importa para todos",
      content:
          "El índice glucémico te dice qué tan rápido sube tu azúcar con cada alimento.",
      imageUrl: "lib/data/img/cereales/avena.jpg",
      color: Colors.amber,
      publishDate: DateTime.now().subtract(const Duration(days: 42)),
      tags: ["índice glucémico", "azúcar", "diabetes"],
      sections: [
        ArticleSection(
          title: "¿Qué es el índice glucémico?",
          content:
              "El índice glucémico (IG) mide la velocidad con la que un alimento eleva la glucosa en sangre, comparado con glucosa pura (100):\n\n• IG BAJO (<55): Liberación lenta y estable\n• IG MEDIO (56-69): Liberación moderada\n• IG ALTO (>70): Sube rápido la glucosa\n\nComer muchos alimentos de IG alto causa picos y bajones de energía, hambre prematura y, a largo plazo, mayor riesgo de diabetes tipo 2.",
        ),
        ArticleSection(
          title: "Ejemplos mexicanos por categoría",
          content:
              "IG BAJO (<55) — prefiere:\n• Frijoles, lentejas, garbanzos\n• Nopales, brócoli, jitomate\n• Manzana, pera, fresas\n• Tortilla de maíz (52)\n\nIG MEDIO (56-69):\n• Plátano maduro\n• Arroz integral\n• Papa cocida\n• Piña, papaya, mango\n\nIG ALTO (>70):\n• Pan blanco y bolillo\n• Arroz blanco\n• Refrescos y azúcar\n• Cereales de caja\n• Sandía y melón\n\nDetalle: La TORTILLA DE MAÍZ tiene menor IG que el pan blanco y aporta calcio. Un cambio sencillo con beneficios reales.",
        ),
        ArticleSection(
          title: "Carga glucémica: el dato más útil",
          content:
              "El IG solo no cuenta la historia completa. La CARGA GLUCÉMICA (CG) considera también la cantidad:\n\nCG = (IG × gramos de carbohidratos de la porción) / 100\n\nEjemplo: La sandía tiene IG alto (75), pero por su alto contenido de agua, una porción normal tiene CG baja. En cambio, comer 3 bolillos (IG medio) puede tener CG muy alta.\n\nRegla práctica: Un alimento de IG alto consumido en porción pequeña no es grave; un alimento de IG medio en cantidad excesiva sí lo es. La cantidad siempre importa.",
        ),
        ArticleSection(
          title: "Cómo bajar el IG de tus comidas",
          content:
              "Estrategias prácticas para estabilizar tu glucosa:\n\n• Combina carbohidratos con proteína y fibra (frijoles + tortilla, no tortilla sola)\n• Agrega un toque de grasa saludable (aguacate en vez de pan solo)\n• Cocina la pasta y el arroz al dente (menos sobrecocción = menor IG)\n• Come fruta entera en lugar de jugo\n• Agrega vinagre o limón a tus comidas: estudios muestran que reduce el pico de glucosa\n• Come el postre como parte de la comida, no solo\n\nEstos trucos ayudan a todos, no solo a personas con diabetes.",
        ),
      ],
    ),
    Article(
      title: "Sodio: El enemigo silencioso en tu mesa",
      description:
          "Por qué el exceso de sal daña tu presión arterial y cómo reducirla sin perder sabor",
      content:
          "La sal es necesaria, pero la mayoría de los mexicanos consume el doble de lo recomendado.",
      imageUrl: "lib/data/img/vegetables/tomate.jpg",
      color: Colors.lightBlue,
      publishDate: DateTime.now().subtract(const Duration(days: 45)),
      tags: ["sodio", "sal", "hipertensión"],
      sections: [
        ArticleSection(
          title: "¿Cuánta sal necesitamos?",
          content:
              "El sodio es un mineral esencial que mantiene el equilibrio de líquidos y la función nerviosa. El problema es el exceso:\n\n• Recomendación OMS: menos de 5g de sal al día (2000mg de sodio)\n• Consumo promedio en México: 10-12g de sal al día (el doble)\n\nEl 75% del sodio que consumimos no viene del salero, sino de productos procesados: pan, embutidos, salsas comerciales, sopas instantáneas y botanas.",
        ),
        ArticleSection(
          title: "El impacto en tu presión arterial",
          content:
              "El exceso de sodio hace que el cuerpo retenga agua, lo que aumenta el volumen de sangre y la presión sobre las arterias:\n\n• La hipertensión afecta a 1 de cada 3 mexicanos adultos\n• Es el principal factor de riesgo de infarto y accidente cerebrovascular\n• Se le llama 'asesino silencioso' porque casi no da síntomas\n\nReducir la sal puede bajar la presión sistólica 4-6 mmHg, comparable a algunos medicamentos antihipertensivos.",
        ),
        ArticleSection(
          title: "Fuentes ocultas de sodio",
          content:
              "Cuidado con estos alimentos que no saben salados:\n\n• PAN Y TORTILLAS INDUSTRIALES\n• QUESOS (especialmente procesados)\n• EMBUTIDOS (jamón, salchichas, tocino)\n• SALSAS Y ADEREZOS comerciales\n• SOPAS INSTANTÁNEAS\n• CEREALES DE CAJA\n• BEBIDAS DE SOYA Y ALGUNOS REFRESCOS (sodio en gasificantes)\n• ALIMENTOS ENLATADOS\n\nLección: La mayoría de los productos con sello de EXCESO SODIO son alimentos que no saben particularmente salados.",
        ),
        ArticleSection(
          title: "Cómo reducir sal sin perder sabor",
          content:
              "Tu paladar se adapta en 3-4 semanas a menos sal. Mientras tanto:\n\n• Usa hierbas y especias: epazote, cilantro, ajo, comino, orégano\n• Sazona con limón, que realza el sabor\n• Escurre y enjuaga alimentos enlatados\n• Cocina más en casa (controlas la sal)\n• Retira el salero de la mesa\n• Lee etiquetas: compara marcas y elige la de menor sodio\n• Prefiere tortillas frescas de maíz y pan artesanal\n\nConsejo: Los chiles y salsas frescas con jitomate y tomatillo aportan sabor intenso sin necesidad de mucha sal.",
        ),
      ],
    ),
    Article(
      title: "Verduras de hoja verde: El vegetal más completo",
      description:
          "Por qué espinacas, acelgas y lechugas deberían estar en tu plato a diario",
      content:
          "Las verduras de hoja verde son el alimento con mejor densidad nutricional del planeta.",
      imageUrl: "lib/data/img/vegetables/espainaca.jpg",
      color: Colors.green,
      publishDate: DateTime.now().subtract(const Duration(days: 48)),
      tags: ["verduras", "verde", "nutrientes"],
      sections: [
        ArticleSection(
          title: "El perfil nutricional de las hojas verdes",
          content:
              "Las verduras de hoja verde (espinaca, acelga, quelites, lechuga, berro) aportan:\n\n• ÁCIDO FÓLICO: Esencial durante el embarazo y para la sangre\n• VITAMINA K: Para la coagulación y los huesos\n• HIERRO Y CALCIO: Aunque en forma menos absorbible que carnes/lácteos\n• LUTEÍNA Y ZEAXANTINA: Protegen la visión\n• VITAMINA C Y ANTIOXIDANTES\n• FIBRA\n\nY todo esto con muy pocas calorías: 100g de espinaca = 23 kcal.",
        ),
        ArticleSection(
          title: "Quelites: El tesoro ancestral",
          content:
              "Los quelites son las verduras de hoja verde silvestres que se consumían desde tiempos prehispánicos:\n\n• Quintonil, verdolaga, romeritos, huauzontle, berro, chepil\n• Ricos en vitaminas, minerales y compuestos antioxidantes\n• Suelen superar en nutrientes a muchas verduras comerciales\n\n¿Sabías que? La verdolaga (portulaca) tiene omega-3 vegetal, un nutriente raro en verduras.\n\nInclúyelos en guisos, tortitas, salsas o simplemente salteados con ajo y cebolla.",
        ),
        ArticleSection(
          title: "Cómo comer más hojas verdes",
          content:
              "Ideas fáciles y mexicanas:\n\n• Espinacas en tu licuado o smoothie verde\n• Agrega acelgas al caldo de pollo\n• Ensalada de espinaca con aguacate, jícama y limón\n• Sopes y tostadas con base de lechuga\n• Tacos de quintonil salteado\n• Añade hojas a tus sopes en lugar de base frita\n\nAumenta las hojas verdes gradualmente; su fibra puede causar gases si se introducen de golpe.",
        ),
        ArticleSection(
          title: "El dato del oxalato",
          content:
              "Las espinacas y acelgas contienen oxalatos, que pueden unirse al calcio y, en personas sensibles, contribuir a cálculos renales.\n\n• La cocción reduce el contenido de oxalatos\n• Personas con historial de piedras en riñón deben consultar a su médico\n• Para la mayoría, los beneficios superan con creces los riesgos\n\nBalance: No necesitas eliminar las hojas verdes; solo modera el consumo si tienes riesgo comprobado de cálculos.",
        ),
      ],
    ),
    Article(
      title: "Frutas de temporada en México: Come con el calendario",
      description:
          "Aprovecha lo que da nuestra tierra cada mes: más sabor, mejor precio, más nutrientes",
      content:
          "México produce una de las mayores variedades de frutas del mundo.",
      imageUrl: "lib/data/img/fruits/papaya.jpg",
      color: Colors.deepOrange,
      publishDate: DateTime.now().subtract(const Duration(days: 51)),
      tags: ["frutas", "temporada", "mexicano"],
      sections: [
        ArticleSection(
          title: "¿Por qué comer frutas de temporada?",
          content:
              "Comer frutas de temporada tiene ventajas múltiples:\n\n• MEJOR SABOR: Se cosechan en su punto óptimo\n• MÁS NUTRIENTES: Menos tiempo entre cosecha y consumo\n• MENOR PRECIO: Mayor oferta en el mercado\n• MENOS IMPACTO AMBIENTAL: Menos transporte y refrigeración\n• APOYO A PRODUCTORES LOCALES\n\nAdemás, las frutas de temporada acompañan las necesidades del clima: jugosas en calor, cítricas en frío.",
        ),
        ArticleSection(
          title: "Calendario de frutas mexicanas",
          content:
              "Ejemplos de temporada:\n\n• PRIMAVERA: Fresa, mango, piña, papaya, naranja\n• VERANO: Sandía, melón, mango, ciruela, higo, aguacate\n• OTOÑO: Guayaba, granada, pera, manzana, uva\n• INVIERNO: Naranja, mandarina, toronja, limón, tejocote, zapote\n\n¿Sabías que? México es el principal exportador mundial de aguacate y mango, y está entre los mayores de papaya y limón. La guayaba y el tejocote son joyas de temporada otoñal-invernal.",
        ),
        ArticleSection(
          title: "Frutas mexicanas poco conocidas que debes probar",
          content:
              "Amplía tu repertorio con estas frutas:\n\n• TEJOCOTE: Vitamina C, se usa en ponche navideño\n• ZAPOTE NEGRO: Dulce, rico en fibra y calcio\n• CHICOZAPOTE: Dulzura natural, vitamina C\n• PITAYA Y PITAHAYA: Antioxidantes y prebióticos\n• MAMEY: Rico en vitaminas A y C, fibra\n• TUNA (fruto del nopal): Fibra, betalaínas\n• GUANÁBANA: Vitamina C, sabor único\n• XOCONOSTLE: Regula glucosa (de la misma familia que el pitayo)\n\nLa tuna es especialmente valiosa: el nopal ya ayuda a la glucosa, y su fruto aporta fibra y antioxidantes en temporada de calor.",
        ),
        ArticleSection(
          title: "Consejos de consumo",
          content:
              "Para aprovechar al máximo las frutas:\n\n• Come 3-5 porciones al día (una porción = 1 pieza mediana o 1 taza picada)\n• Prefiere fruta entera sobre jugos: la fibra te llena y modera el azúcar\n• Deja cáscara donde se pueda (bien lavada): más fibra\n• Combina colores durante la semana\n• En temporada, compra más y congela (mango, fresas, plátano congelan bien)\n• Evita jugos industrializados aunque digan 'natural'\n\nRegla de oro: come frutas como postre o colación, no reemplaces comidas completas por fruta.",
        ),
      ],
    ),
  ];
}
