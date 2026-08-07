import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';
import 'package:nutriplato/infrastructure/entities/article/article_section.dart';

/// Artículos de recetas y menús saludables.
List<Article> recetasArticles() {
  return [
    Article(
      title: "10 desayunos mexicanos saludables para toda la semana",
      description:
          "Deliciosos desayunos tradicionales adaptados a una alimentación equilibrada",
      content:
          "Desayunar bien es más fácil de lo que crees con estas ideas mexicanas.",
      imageUrl: "lib/data/img/healthy_food_variety.jpeg",
      color: Colors.orange,
      publishDate: DateTime.now().subtract(const Duration(days: 54)),
      tags: ["desayunos", "recetas", "mexicano"],
      sections: [
        ArticleSection(
          title: "La fórmula del desayuno completo",
          content:
              "Un desayuno equilibrado combina:\n\n• CARBOHIDRATO COMPLEJO: tortilla, avena, pan integral\n• PROTEÍNA: huevo, frijoles, queso fresco, yogurt\n• FRUTA O VERDURA: papaya, plátano, nopales, jitomate\n• GRASA SALUDABLE: aguacate, nueces, aceite de oliva\n\nSin los tres grupos, el desayuno deja de ser completo: solo carbohidratos = hambre a media mañana; solo proteína = energía insuficiente.",
        ),
        ArticleSection(
          title: "Desayunos calientes de fin de semana",
          content:
              "Ideas para desayunos elaborados:\n\n1. HUEVOS RANCHEROS: Huevo estrellado sobre tortilla de maíz, salsa de jitomate casera y frijoles refritos (hechos en casa, poco aceite)\n2. CHILAQUILES SALUDABLES: Con tortilla horneada en lugar de frita, salsa verde o roja natural, pollo deshebrado, crema light y queso bajo en grasa\n3. MOLETES: Pan integral tostado con frijoles refritos, pico de gallo y queso (sin gratinar)\n4. ENFRIJOLADAS: Tortilla en salsa de frijol con cebolla, queso fresco y crema\n5. HUEVOS CON NOPALITOS: Revoltillo con nopales, jitomate y cebolla, servido con tortilla\n\nTruco: los chilaquiles saludables usan tortilla horneada al horno: quedan crujientes sin freír.",
        ),
        ArticleSection(
          title: "Desayunos rápidos entre semana",
          content:
              "Cuando el tiempo apremia:\n\n6. AVENA CON FRUTA Y NUEZ: Cocida o fría (overnight oats) con plátano, fresas y nueces\n7. LICUADO VERDE: Nopal, piña, apio y naranja o limón (desintoxicante natural)\n8. TOSTADAS DE AGUACATE CON HUEVO: Huevo cocido o revuelto sobre pan integral con aguacate\n9. YOGURT GRIEGO CON AMARANTO Y FRUTA: Granola de amaranto o frutos rojos\n10. QUESADILLA DE CHAMPIÑONES: Tortilla de maíz con queso panela y hongos, sin freír (a la plancha)\n\nPrepara la avena la noche anterior y el desayuno listo en 2 minutos.",
        ),
        ArticleSection(
          title: "Errores comunes que arruinan el desayuno",
          content:
              "Evita estos clásicos:\n\n• SOLO CAFÉ Y PAN DULCE: Pico de glucosa y bajón a media mañana\n• CEREALES DE CAJA 'FIT': Muchos tienen 2 sellos de advertencia\n• JUGOS INDUSTRIALIZADOS: Azúcar sin fibra\n• 'DESAYUNO INGLÉS' GRASOSO: Salchicha, tocino y papa frita con exceso de grasa saturada\n• NO DESAYUNAR: El peor error, provoca atracones más tarde\n\nCompara siempre el etiquetado: un cereal de caja 'saludable' no debería tener sellos de EXCESO AZÚCARES.",
        ),
        ArticleSection(
          title: "Menú semanal sugerido",
          content:
              "PLAN DE 7 DÍAS:\n\n• LUNES: Avena con plátano y canela + té verde\n• MARTES: Licuado verde + tostada de aguacate\n• MIÉRCOLES: Huevos con nopalitos + tortilla\n• JUEVES: Yogurt con amaranto, fresas y miel\n• VIERNES: Overnight oats con chía y mango\n• SÁBADO: Huevos rancheros con frijoles\n• DOMINGO: Chilaquiles saludables de pollo\n\nRotar opciones evita el aburrimiento y garantiza variedad de nutrientes.",
        ),
      ],
    ),
    Article(
      title: "Cenas ligeras y nutritivas: 10 opciones sin culpa",
      description:
          "Cenar saludable no significa dejar de disfrutar. Ideas rápidas y ligeras",
      content:
          "La cena ideal es ligera, pero suficiente para dormir bien.",
      imageUrl: "lib/data/img/nutrition_balance.jpeg",
      color: Colors.indigo,
      publishDate: DateTime.now().subtract(const Duration(days: 57)),
      tags: ["cenas", "recetas", "ligero"],
      sections: [
        ArticleSection(
          title: "¿Qué hace una buena cena?",
          content:
              "La cena debe aportar 20-25% de las calorías del día y consumirse 2-3 horas antes de dormir:\n\n• LIGERA: Evitar comidas grasosas que dificulten el sueño\n• CON PROTEÍNA MAGRA: Ayuda a reparar tejidos durante la noche\n• CON VERDURAS: Fibra y vitaminas sin exceso calórico\n• CON CARBOHIDRATO COMPLEJO EN PEQUEÑA CANTIDAD: Facilita la producción de melatonina\n\nCenar pesado o muy condimentado causa reflujo e interrumpe el descanso.",
        ),
        ArticleSection(
          title: "Cenas de 10 minutos",
          content:
              "Rápidas y sin complicaciones:\n\n1. SOPA DE VERDURAS CON POLLO DESHEBRADO\n2. QUESADILLA DE FLOR DE CALABAZA con frijoles de olla\n3. ENSALADA TIBIA CON HUEVO Y AGUACATE\n4. TACOS DE NOPALITO ASADO con salsa verde\n5. WRAP DE TORTILLA INTEGRAL CON ATÚN Y VERDURAS\n6. SALMÓN O PESCADO A LA PLANCHA con espárragos\n7. YOGURT CON GRANOLA Y FRUTA (si tienes poca hambre)\n8. TOFU O SOYA TEXTURIZADA GUISADA CON VERDURAS\n9. CHAMPINONES SALTADOS CON AJO SOBRE TOSTADA\n10. CALDO DE RES O DE POLLO con verduras\n\nEl caldo de pollo con verduras es uno de los mejores aliados: hidrata, llena y es muy ligero.",
        ),
        ArticleSection(
          title: "La cena ideal para dormir mejor",
          content:
              "Alimentos que favorecen el sueño:\n\n• PLÁTANO: Magnesio y triptófano\n• LECHE TIBIA CON CANELA: Calcio y triptófano\n• AVENA: Carbohidrato complejo que ayuda a producir melatonina\n• CEREZAS: Melatonina natural\n• ALMENDRAS: Magnesio\n• KIWI: Estudios muestran que mejora el sueño\n\nMenú sugerido: Avena caliente con plátano y canela + un vaso de leche tibia = cena ligera y soporífera.",
        ),
        ArticleSection(
          title: "Alimentos a evitar en la cena",
          content:
              "Lo que NO debes cenar:\n\n• CAFEÍNA: café, té negro, refresco de cola, chocolate (afecta hasta 8 horas)\n• COMIDAS MUY GRASOSAS: freír, salsas cremosas, quesos en exceso\n• PICANTE EN EXCESO: puede causar acidez en personas sensibles\n• AZÚCAR: postres, refrescos (causan despertares nocturnos)\n• EXCESO DE LÍQUIDOS: interrupciones para ir al baño\n\nSi quieres algo dulce, elige fruta o yogurt natural con canela en lugar de postres procesados.",
        ),
        ArticleSection(
          title: "Menú semanal de cenas",
          content:
              "PLAN DE 7 DÍAS:\n\n• LUNES: Sopa de verduras + quesadilla de hongos\n• MARTES: Ensalada de espinaca con huevo y aguacate\n• MIÉRCOLES: Tacos de nopalito con frijoles\n• JUEVES: Salmón a la plancha con espárragos\n• VIERNES: Caldo de pollo con verduras\n• SÁBADO: Overnight oats + manzana\n• DOMINGO: Wrap integral con atún y verduras\n\nCenar ligero también ayuda a controlar el peso: una cena excesiva se acumula porque no hay actividad posterior para gastarla.",
        ),
      ],
    ),
    Article(
      title: "Loncheras escolares: Alimenta su cerebro y su energía",
      description:
          "Ideas de lunch saludables, atractivos y fáciles para tus hijos",
      content:
          "La lonchera correcta nutre el rendimiento escolar de tus hijos.",
      imageUrl: "lib/data/img/fruits/manzana.jpg",
      color: Colors.cyan,
      publishDate: DateTime.now().subtract(const Duration(days: 60)),
      tags: ["loncheras", "niños", "escolar"],
      sections: [
        ArticleSection(
          title: "El método del plato en la lonchera",
          content:
              "La SEP recomienda que la lonchera incluya 5 grupos:\n\n• CEREAL O PAN: tortilla, pan integral, galletas integrales, avena\n• PROTEÍNA: pollo, jamón de pavo, queso panela, huevo, frijoles\n• FRUTA: entera o picada, de temporada\n• VERDURA: jícama, zanahoria, pepino con limón y chile\n• AGUA NATURAL: nunca jugos o refrescos\n\nEjemplo ideal: Sándwich de pollo con lechuga + manzana + zanahorias baby + agua.",
        ),
        ArticleSection(
          title: "10 ideas de loncheras completas",
          content:
              "Alternativas para variar toda la semana:\n\n1. Quesadilla de frijol + uvas + pepino con limón\n2. Rollito de jamón de pavo con queso y aguacate + fresas\n3. Wrap de hummus con verduras + pera\n4. Taquito de pollo con salsa (sin freír) + papaya picada\n5. Hot cakes de avena y plátano + jícama\n6. Sándwich de atún con lechuga + mandarinas\n7. Palitos de elote cocido con limón y chile + sandía\n8. Crema de frijol con totopos horneados + manzana\n9. Pan pita con queso panela y jitomate + melón\n10. Galletas integrales con queso cottage + ciruela\n\nVaría la fruta y verdura con la temporada para evitar el aburrimiento.",
        ),
        ArticleSection(
          title: "Tips para que tu hijo coma su lonchera",
          content:
              "Estrategias que funcionan:\n\n• INVOLÚCRALO: que elija entre 2 opciones que le ofrezcas\n• PREPÁRALA JUNTOS la noche anterior\n• CORTA EN FORMAS DIVERTIDAS: caritas, estrellas, cubitos\n• ACOMPAÑA con una nota o dibujo (hace que quiera abrirla)\n• NO LA CONVIERTAS EN PREMIO O CASTIGO\n• Ofrece el alimento nuevo 10-15 veces antes de rendirte\n\nLo que el niño prepara o elige, lo come con más gusto. La autonomía aumenta la aceptación.",
        ),
        ArticleSection(
          title: "Lo que NO debe ir en la lonchera",
          content:
              "Evita estos clásicos poco saludables:\n\n• REFRESCOS Y JUGO: exceso de azúcar\n• GOLOSINAS Y DULCES\n• PAPITAS Y FRITURAS DE BOLSA\n• SÁNDWICH DE PAN BLANCO CON EMBUTIDO ÚNICAMENTE (sin verduras)\n• COMIDA RÁPIDA\n\nLa lonchera no debe sustituir el desayuno, sino complementarlo. El agua natural es imprescindible en nuestro clima.",
        ),
        ArticleSection(
          title: "Loncheras para días de calor",
          content:
              "En clima cálido, prioriza alimentos seguros:\n\n• Usa una hielera o termo para el agua\n• Evita mayonesa y cremas que se descompongan\n• Empaca frutas que resistan (manzana, uva, mandarina) sobre las muy blandas\n• Queso y yogurt requieren refrigeración: usa termo\n• Incluye más verduras crujientes\n\nLa seguridad alimentaria también es nutrición: una lonchera en mal estado puede causar una intoxicación.",
        ),
      ],
    ),
    Article(
      title: "Snacks saludables mexicanos: Botanas sin culpa",
      description:
          "Ideas de colaciones nutritivas para calmar el hambre entre comidas",
      content:
          "Las botanas saludables evitan que llegues con demasiada hambre a la comida.",
      imageUrl: "lib/data/img/fruits/guayaba.jpg",
      color: Colors.pink,
      publishDate: DateTime.now().subtract(const Duration(days: 63)),
      tags: ["snacks", "botanas", "colaciones"],
      sections: [
        ArticleSection(
          title: "¿Por qué necesitas colaciones?",
          content:
              "Comer pequeñas colaciones entre comidas:\n\n• Evita la sensación extrema de hambre que lleva a comer de más\n• Mantiene la glucosa estable y la energía constante\n• Te aporta nutrientes extra\n\nLas colaciones deben aportar 10-15% de las calorías diarias (150-250 kcal), aproximadamente la cantidad de un puño cerrado.\n\nImportante: Una colación no es una comida extra, es un apoyo entre comidas.",
        ),
        ArticleSection(
          title: "Botanas rápidas de compra",
          content:
              "Opciones para llevar o comprar:\n\n• FRUTA PICADA CON LIMÓN Y CHILE (¡la mejor botana mexicana!)\n• JÍCAMA Y ZANAHORIA con limón\n• GARBANZOS O HABAS COCIDAS con limón y chile en polvo\n• NUECES, ALMENDRAS O CACAHUATES NATURALES (no confitados)\n• SEMILLAS DE CALABAZA tostadas\n• PALOMITAS HECHAS EN CASA (sin mantequilla)\n• GALLETAS INTEGRALES con queso cottage\n• YOGURT NATURAL con amaranto\n• ALEGRÍAS (amaranto) si son bajas en azúcar\n\nPrefiere botanas de bolsa con menos de 2 sellos de advertencia y revisa el tamaño de porción.",
        ),
        ArticleSection(
          title: "Snacks caseros para preparar",
          content:
              "Con 15 minutos puedes tener colaciones para la semana:\n\n• GARBANZOS CRUJIENTES: al horno con especias\n• CHIPS DE ZANAHORIA O JÍCAMA: finas, con chile y limón\n• TOTOPOS HORNEADOS: tortilla de maíz al horno en lugar de frita\n• BARRITAS DE AVENA Y PLÁTANO sin azúcar\n• BOLITAS ENERGÉTICAS: avena + amaranto + plátano + coco + cacahuate\n• PUDÍN DE CHÍA con leche de coco\n• MANZANA O PLÁTANO DESHIDRATADO (sin azúcar añadida)\n\nLas bolitas energéticas de avena y amaranto son perfectas para llevar a la escuela o trabajo: energía sostenida sin azúcar refinada.",
        ),
        ArticleSection(
          title: "Cuándo y cuánto comer",
          content:
              "El timing de las colaciones:\n\n• IDEAL: 2-3 horas después del desayuno y 2-3 horas antes de la cena\n• EVITAR: Comer snacks por aburrimiento o frente a la TV\n• PISTA DE HAMBRE REAL: ¿Comerías una manzana o verduras? Si la respuesta es no, no tienes hambre\n\nEl 'comer emocional' con snacks es la causa más común de exceso calórico. Sirve las colaciones en un plato, no directamente de la bolsa.",
        ),
        ArticleSection(
          title: "Botanas para después de hacer ejercicio",
          content:
              "Si entrenas, la colación posterior es clave para recuperarte:\n\n• Dentro de los 30-60 minutos después del ejercicio\n• Combina proteína + carbohidrato: leche con chocolate natural, yogurt con plátano, fruta con nueces\n• Proporción ideal: 3-4 partes de carbohidrato por 1 de proteína\n\nUna licuado de plátano con leche y amaranto es una opción mexicana perfecta para la recuperación.",
        ),
      ],
    ),
    Article(
      title: "Postres saludables: Dulce sin arrepentimiento",
      description:
          "Satisface tu antojo de dulce con versiones nutritivas",
      content:
          "Sí puedes disfrutar un postre y alimentarte bien al mismo tiempo.",
      imageUrl: "lib/data/img/fruits/fresa.jpg",
      color: Colors.red,
      publishDate: DateTime.now().subtract(const Duration(days: 66)),
      tags: ["postres", "dulce", "recetas"],
      sections: [
        ArticleSection(
          title: "El antojo de dulce explicado",
          content:
              "El deseo de azúcar tiene bases biológicas:\n\n• El azúcar activa el sistema de recompensa del cerebro\n• La caída de glucosa después de comer simple causa antojos\n• El aburrimiento y el estrés incrementan el deseo de dulce\n\nEstrategia: Comer proteína y fibra en las comidas principales reduce los antojos de azúcar posteriores. Si tu comida fue solo arroz y pan (carbohidratos simples), el antojo de postre será casi inevitable.",
        ),
        ArticleSection(
          title: "Postres con fruta mexicana",
          content:
              "Ideas dulces y nutritivas:\n\n• FRUTA ASADA CON CANELA: manzana o pera al horno\n• ENSALADA DE FRUTAS DE TEMPORADA con limón y chile (o miel ligera)\n• FRUTA CONCHOCOLATE: fresas o plátano bañados en chocolate oscuro (>70%)\n• PALETAS DE FRUTA CASERA: licuado de fruta congelado en moldes\n• SORBETE DE PAPAYA O MANGO: fruta congelada licuada\n• PLÁTANO CON MANTEQUILLA DE CACAHUATE Y AMARANTO\n\nEl chocolate oscuro con frutas combina antioxidantes del cacao con fibra de la fruta: antojo satisfecho con nutrientes reales.",
        ),
        ArticleSection(
          title: "Versiones saludables de clásicos mexicanos",
          content:
              "Transformaciones de postres tradicionales:\n\n• ARROZ CON LECHE: con leche descremada y menos azúcar, más canela\n• FLAN: versiones de queso cottage o con leche evaporada light\n• GELATINA: con fruta natural y sin azúcar\n• ALEGRÍAS: caseras con miel de agave en poca cantidad\n• ATE DE MEMBRILLO O GUAYABA: rico en fibra, una porción pequeña\n• NIEVE: de fruta natural en lugar de helado industrial\n\nLa clave: porciones pequeñas y endulzar con fruta o pequeñas cantidades de miel, en lugar de azúcar refinada abundante.",
        ),
        ArticleSection(
          title: "Endulzantes: qué usar y qué evitar",
          content:
              "Opciones para endulzar de forma inteligente:\n\n• MEJORES: Fruta madura, canela, vainilla, dátiles, plátano machacado\n• MODERADOS: miel, piloncillo, agave (siguen siendo azúcar, solo menos refinada)\n• EDULCORANTES ARTIFICIALES: El etiquetado mexicano obliga a declararlos; no deben consumirse en exceso, especialmente por niños y embarazadas\n• EVITAR: Jarabe de maíz de alta fructosa\n\nLos endulzantes artificiales no aportan calorías, pero algunos estudios sugieren que pueden alterar la microbiota y aumentar el antojo de dulce. Mejor acostumbrar el paladar a menos dulzor.",
        ),
        ArticleSection(
          title: "La porción correcta",
          content:
              "Los postres saludables también necesitan límite:\n\n• Sirve una porción pequeña en plato (no directo del recipiente)\n• Disfrútalo lentamente y consciente\n• Los postres saludables siguen aportando calorías\n• Máximo 2-3 veces por semana si estás en control de peso\n\nRegla de oro: el postre es un complemento de una dieta equilibrada, no el protagonista.",
        ),
      ],
    ),
    Article(
      title: "Sopas y caldos mexicanos: El plato reconfortante",
      description:
          "Caldo de pollo, pozole, sopa de verduras: por qué son la mejor comida medicinal",
      content:
          "La sopa de tu abuela es, de hecho, una de las comidas más saludables.",
      imageUrl: "lib/data/img/vegetables/verdurasmezcladas.jpg",
      color: Colors.deepOrange,
      publishDate: DateTime.now().subtract(const Duration(days: 69)),
      tags: ["sopas", "caldos", "tradición"],
      sections: [
        ArticleSection(
          title: "¿Por qué la sopa es tan nutritiva?",
          content:
              "Las sopas y caldos mexicanos reúnen varios beneficios:\n\n• HIDRATAN: el líquido contribuye a tu consumo de agua\n• LLENAN CON POCAS CALORÍAS: el agua ocupa espacio en el estómago\n• CONCENTRAN NUTRIENTES: las verduras aportan vitaminas al caldo\n• SON FÁCILES DE DIGERIR: ideales para enfermos y adultos mayores\n• PERMITEN APROVECHAR TODO: restos de pollo, verduras y frijoles\n\nUn caldo de pollo con verduras aporta proteína, vitaminas, minerales y líquidos: la comida perfecta para un día frío o de enfermedad.",
        ),
        ArticleSection(
          title: "Caldos mexicanos y sus beneficios",
          content:
              "Nuestro repertorio de caldos:\n\n• CALDO DE POLLO: proteína magra, electrolitos, se le considera 'penicilina natural'\n• CALDO DE RES: hierro y zinc del tejido, colágeno\n• CALDO TLALPEÑO: pollo, garbanzo, aguacate y chile poblano (fibra + proteína + grasa buena)\n• CALDO DE PESCADO O MARISCOS: omega-3 y yodo\n• SOPE DE VERDURAS: cualquier vegetal de temporada\n• BIRRIA Y CONSOMÉ: tradicionales, elegir con poca grasa\n\nConsejo: el caldo de pollo hecho en casa con hueso y verduras es superior al caldo industrial en cubitos, que es alto en sodio.",
        ),
        ArticleSection(
          title: "Pozole, menudo y otros antojos: versiones ligeras",
          content:
              "Los 'consomés festivos' también pueden ser saludables:\n\n• POZOLE: el grano de maíz (pozole cacahuazintle) aporta fibra y proteína. Elige pozole blanco o verde, con poca crema, y sirve el pollo o cerdo magro con muchas verduras\n• MENUDO: proteína de alta calidad; controlar el chile si hay acidez\n• BIRRIA: elige cortes magros y limita la grasa de la superficie\n• PANCITA: los callos son colágeno; moderar la grasa\n\nEl secreto para cualquier guiso: servir el doble de verduras y la mitad de la carne, y dejar la crema y el queso en versiones ligeras.",
        ),
        ArticleSection(
          title: "Cómo hacer un caldo de pollo perfecto",
          content:
              "Receta básica de caldo de pollo casero:\n\nINGREDIENTES:\n• 1 pollo o piezas (pierna/pechuga)\n• Cebolla, ajo, zanahoria, calabaza, chayote, papa\n• Hierbas: cilantro, apio, laurel\n• Sal en poca cantidad\n\nPREPARACIÓN:\n1. Hierve el pollo con cebolla, ajo y laurel 20-30 min\n2. Retira la espuma de la superficie\n3. Agrega las verduras y cocina 15 min más\n4. Ajusta sal al final\n5. Deshebra el pollo y sirve con limón, arroz y tortilla\n\nEl limón al final aporta vitamina C que mejora la absorción del hierro.",
        ),
        ArticleSection(
          title: "Sopas para cada ocasión",
          content:
              "Adapta la sopa a tus necesidades:\n\n• PARA ENFERMOS: caldo de pollo claro, sin grasa, con verduras suaves\n• PARA DIETA: sopa de verduras abundante como primer plato (reduce la ingesta de la comida principal)\n• PARA NIÑOS: sopa de fideo integral con verduritas picadas finas\n• PARA VEGETARIANOS: cremas de calabaza, champiñón o frijol con leche de avena\n• PARA DEPORTISTAS: caldo de res con papa, para reponer sodio y carbohidratos\n\nLa crema de calabaza es una sopa vegetariana cremosa sin crema: asa la calabaza y licúa con caldo de verduras y un toque de leche o avena.",
        ),
      ],
    ),
    Article(
      title: "Ensaladas que sí llenan: El arte del plato completo",
      description:
          "Convierte la ensalada en una comida completa con estos trucos",
      content:
          "La ensalada no tiene por qué ser 'comida de conejo'.",
      imageUrl: "lib/data/img/vegetables/lechuga.jpg",
      color: Colors.lightGreen,
      publishDate: DateTime.now().subtract(const Duration(days: 72)),
      tags: ["ensaladas", "verduras", "recetas"],
      sections: [
        ArticleSection(
          title: "El problema de las ensaladas 'flacas'",
          content:
              "Una ensalada solo de lechuga y tomate deja hambre a la hora:\n\n• No tiene proteína: falta saciedad\n• No tiene grasa: algunas vitaminas (A, D, E, K) no se absorben\n• No tiene carbohidrato: falta energía\n\nResultado: 20 minutos después tienes hambre y terminas comiendo cualquier cosa. La ensalada debe ser una comida completa, no una guarnición de agua.",
        ),
        ArticleSection(
          title: "La fórmula de la ensalada completa",
          content:
              "Incluye estos 5 elementos:\n\n1. BASE DE VERDURAS: lechuga, espinaca, pepino, jitomate, zanahoria, jícama\n2. PROTEÍNA: pollo, atún, huevo cocido, frijoles, garbanzos, queso panela, soya\n3. CARBOHIDRATO: elote, papa cocida, tortilla tostada, arroz integral, aguacate\n4. GRASA SALUDABLE: aguacate, nueces, semillas, aceite de oliva\n5. ALIÑO CASERO: limón + aceite de oliva + hierbas (en lugar de aderezos comerciales)\n\nEjemplo completo: espinaca + pollo deshebrado + elote + aguacate + nuez + limón y aceite. Una comida equilibrada en un solo plato.",
        ),
        ArticleSection(
          title: "Ensaladas mexicanas que llenan",
          content:
              "Nuestra cocina tiene ensaladas abundantes:\n\n• ENSALADA DE NOPALES: con jitomate, cebolla, cilantro, aguacate y queso panela\n• COCHINITA O POLLO CON ENSALADA: los tacos en tostada de lechuga\n• ENSALADA DE FRIJOLES: frijoles negros con elote, pimiento y cilantro (la 'ensalada de pueblo')\n• ENSALADA DE GARBANZO: con atún, cebolla morada y limón\n• CHOP SUEY DE VERDURAS: salteadas al wok con salsa de soya\n• TOSTADA DE LECHUGA CON POLLO Y AGUACATE: la tostada sin tortilla\n\nLas 'tostadas' de lechuga son una alternativa inteligente a la tostada frita: crujientes y con cero grasas saturadas.",
        ),
        ArticleSection(
          title: "Aderezos caseros en 1 minuto",
          content:
              "Olvídate de los aderezos comerciales (altos en azúcar y sodio):\n\n• VINAGRETA BÁSICA: 3 partes aceite de oliva + 1 parte limón + hierbas\n• ADEREZO DE AGUACATE: aguacate machacado + limón + yogurt natural\n• ADEREZO DE CILANTRO: cilantro + yogurt + limón + ajo (licuado)\n• SALSA DE MOSTAZA: mostaza + yogurt + miel en poca cantidad\n• VINAGRETA DE JAMAIBA O MANDARINA: usa el jugo en lugar del vinagre\n\nUn buen aliño realza el sabor y permite que las grasas saludables hagan su trabajo de absorción de vitaminas.",
        ),
        ArticleSection(
          title: "Ensaladas para llevar al trabajo",
          content:
              "Tips para ensaladas portátiles:\n\n• Pon el aliño aparte y agrégalo al momento de comer (evita que se marchite)\n• Empaca los ingredientes por capas: aderezo abajo, proteína al centro, hojas arriba\n• Usa frascos de vidrio: la ensalada en tarro dura hasta 3 días\n• Los ingredientes crujientes (nueces, tortilla tostada) ve por separado\n• Prepara 3 tarros el domingo y tendrás almuerzos sanos toda la semana\n\nLa ensalada en tarro es la base del meal prep saludable para oficina.",
        ),
      ],
    ),
    Article(
      title: "Smoothies y licuados: El desayuno líquido inteligente",
      description:
          "Aprende a hacer licuados que alimentan de verdad (no solo fruta con agua)",
      content:
          "Un buen licuado puede ser una comida completa en vaso.",
      imageUrl: "lib/data/img/fruits/banana.jpg",
      color: Colors.yellow,
      publishDate: DateTime.now().subtract(const Duration(days: 75)),
      tags: ["licuados", "smoothies", "recetas"],
      sections: [
        ArticleSection(
          title: "Por qué los licuados fallan (y cómo arreglarlo)",
          content:
              "El licuado de 'solo fruta' es una trampa: pura azúcar sin proteína ni grasa.\n\nProblemas comunes:\n• Solo fruta = pico de glucosa y hambre a la hora\n• Jugo industrializado = azúcar líquida sin fibra\n• Fruta + yogurt azucarado = azúcar doble\n\nLa solución: estructura el licuado como una comida completa.",
        ),
        ArticleSection(
          title: "La fórmula del licuado completo",
          content:
              "Incluye 4 elementos:\n\n1. LÍQUIDO: agua, leche, leche vegetal, agua de coco\n2. FRUTA/VERDURA: plátano, mango, fresas, espinaca, nopal\n3. PROTEÍNA: yogurt griego natural, leche, tofu, avena, amaranto\n4. GRASA SALUDABLE: chía, linaza, cacahuate, nuez, aguacate\n\nEjemplo perfecto: plátano + espinaca + yogurt griego + chía + agua. Proteína, fibra, grasa y carbohidratos en un solo vaso.",
        ),
        ArticleSection(
          title: "Recetas de licuados mexicanos",
          content:
              "Combinaciones con ingredientes de nuestra tierra:\n\n• LICUADO VERDE DESTOX: nopal + piña + apio + naranja\n• LICUADO DE PLÁTANO Y AVENA: plátano + avena + leche + canela\n• LICUADO DE MANGO Y CHÍA: mango + yogurt + chía + agua\n• LICUADO DE FRESA Y AMARANTO: fresas + leche + amaranto + vainilla\n• LICUADO DE COCO Y PIÑA: piña + leche de coco + jengibre\n• LICUADO DE PAPAYA Y NARANJA: papaya + jugo de naranja + avena\n\nEl licuado de plátano con avena y canela es el desayuno 'completo' clásico: energía sostenida para toda la mañana.",
        ),
        ArticleSection(
          title: "Smoothie bowl: la versión moderna",
          content:
              "Si tu licuado queda muy líquido, espesa para hacer un bowl:\n\n• Usa fruta CONGELADA en lugar de hielo\n• Agrega plátano maduro o aguacate para cremosidad\n• Sirve en bowl y decora con granola, amaranto, semillas, fruta picada\n\nUn bowl es un licuado que se come con cuchara: más saciedad, más textura y se puede decorar con más nutrientes.",
        ),
        ArticleSection(
          title: "Errores y precauciones",
          content:
              "Puntos a cuidar:\n\n• LOS LICUADOS NO SUSTITUYEN la fruta entera a diario (la masticación y la fibra entera importan)\n• CUIDA LAS CALORÍAS: un licuado 'de moda' puede tener 500+ kcal\n• NO agregues azúcar: la fruta ya endulza\n• Lávalo bien: fruta y verdura deben desinfectarse\n• Si eres diabético, prefiere licuados con más verduras y menos fruta, y consúmelos con comida (no solo)\n\nRegla: el licuado debe dejar de ser 'un capricho de fruta' y convertirse en una comida con estructura.",
        ),
      ],
    ),
    Article(
      title: "El lunch del adulto: Almuerzos sanos para la oficina",
      description:
          "Organiza tus comidas de trabajo para comer sano, rápido y económico",
      content:
          "Comer en la oficina no tiene que ser sinónimo de comida chatarra.",
      imageUrl: "lib/data/img/vegetables/zanahoria.jpg",
      color: Colors.blueGrey,
      publishDate: DateTime.now().subtract(const Duration(days: 78)),
      tags: ["oficina", "almuerzos", "meal prep"],
      sections: [
        ArticleSection(
          title: "Los 4 errores del almuerzo de oficina",
          content:
              "Reconócelos para corregirlos:\n\n1. SALIR A LA CALLE SIN PLAN: terminas en comida rápida o fonda con comida muy condimentada\n2. LLEVAR SOLO UN SÁNDWICH DE PAN BLANCO CON EMBUTIDO: sin verduras ni proteína de calidad\n3. PEDIR COMIDA A DOMICILIO DIARIO: caro y casi siempre ultraprocesada\n4. NO COMER O COMER POCO: llega a la casa con hambre de lobo y arrasa con todo\n\nLa solución se llama meal prep: preparar tus almuerzos con anticipación.",
        ),
        ArticleSection(
          title: "Meal prep en 5 pasos",
          content:
              "El método dominical:\n\n1. ELIGE 2-3 platillos base (pollo, frijoles, verduras salteadas)\n2. COCINA EN GRANDE el domingo (1.5-2 horas)\n3. PORCIONA en tuppers individuales (usa el método del plato)\n4. REFRIGERA o congela según días\n5. EMPACA cada mañana: toma el tupper y listo\n\nPlatillos que aguantan bien: arroz o frijoles con pollo, tinga de pollo, bisteck con nopales, pasta integral con verduras. Evita salsas cremosas que se descomponen.",
        ),
        ArticleSection(
          title: "10 ideas de almuerzo para llevar",
          content:
              "Porta comidas equilibradas:\n\n1. POLLO A LA PLANCHA + ARROZ INTEGRAL + NOPALES\n2. BISTEC + FRIJOLES DE OLLA + ENSALADA\n3. PESCADO + VERDURAS SALTEADAS + TORTILLA\n4. TINGA DE POLLO + TOTOPOS HORNEADOS\n5. PASTA INTEGRAL + POLLO + PESTO DE CILANTRO\n6. LENTEJAS GUISADAS + ARROZ\n7. QUINOA O ARROZ CON GARBANZOS Y VERDURAS\n8. SANDWICH INTEGRAL DE POLLO + FRUTA + VERDURAS\n9. SOYA TEXTURIZADA GUISADA + ENSALADA\n10. CALDO DE POLLO O RES (en termo)\n\nLleva también un contenedor de fruta y otro de botana saludable (nueces, jícama).",
        ),
        ArticleSection(
          title: "Si no puedes preparar, elige bien afuera",
          content:
              "Tips para comer fuera sin arruinar la semana:\n\n• ELIGE EL PLATO MÁS VERDE del menú\n• PIDE 'a la plancha', 'al horno' o 'al vapor' en lugar de frito\n• PIDE SALSAS Y ADEREZOS APARTE\n• REEMPLAZA el refresco por agua o agua de fruta natural sin azúcar\n• COMPARTE el postre o elígelo frutal\n• EN LA FONDA: prefiere guisos con más verduras (pollo con nopales) sobre los muy grasos (chicharrón en salsa)\n\nPequeños cambios cada vez son más sostenibles que una dieta perfecta un solo día.",
        ),
        ArticleSection(
          title: "El snack de media tarde",
          content:
              "El momento más peligroso de la oficina:\n\n• LA MÁQUINA EXPENDEDORA: elige fruta o nueces si hay, evita papitas y dulces\n• EL 'ANTOJO' DE LAS 4PM: ten tu botana saludable a la mano\n• EL CAFÉ: no abuses; cada café con azúcar añadida suma\n\nBotanas de oficina: cacahuates naturales, fruta, jícama, yogurt griego, palomitas caseras, garbanzos tostados. Son fáciles de guardar en un cajón y te salvan del vending.",
        ),
      ],
    ),
    Article(
      title: "Comidas de fin de semana: Recetas para compartir en familia",
      description:
          "Guisos mexicanos completos y saludables para los días de reunión",
      content:
          "El fin de semana es ideal para disfrutar guisos mexicanos en familia.",
      imageUrl: "lib/data/img/maiz_frijol_combo.jpeg",
      color: Colors.brown,
      publishDate: DateTime.now().subtract(const Duration(days: 81)),
      tags: ["familia", "recetas", "fin de semana"],
      sections: [
        ArticleSection(
          title: "Comidas en familia: un hábito saludable",
          content:
              "Comer en familia tiene beneficios comprobados:\n\n• Los niños que comen con sus padres consumen más frutas y verduras\n• Menor consumo de comida rápida y refrescos\n• Mejor rendimiento escolar y salud emocional\n• Es un momento para conectar y hablar\n\nLa comida en familia no tiene que ser elaborada: lo importante es la constancia y la conversación.",
        ),
        ArticleSection(
          title: "Guisos mexicanos completos para compartir",
          content:
              "Recetas que son comidas completas (el método del plato integrado):\n\n• POLLO EN MOLE VERDE: con frijoles, tortilla y ensalada\n• TINGA DE RES O POLLO: con tostadas de maíz horneadas y aguacate\n• PICADILLO DE RES: con arroz y frijoles\n• TACOS DORADOS: horneados en lugar de fritos, con pollo y mucha verdura\n• CHILAQUILES EN SALSA VERDE: con pollo, crema light y queso\n• BIRRIA LIGERA: con muchas cebollas, limón y cilantro, y tortilla de maíz\n• PESCADO A LA VERACRUZANA: con arroz y verduras\n\nCada guiso se sirve con el 'método del plato': ½ de verduras, ¼ de proteína, ¼ de carbohidrato.",
        ),
        ArticleSection(
          title: "Postres y bebidas familiares sanas",
          content:
              "Para cerrar la comida:\n\n• AGUA DE JAMAICA O LIMÓN SIN AZÚCAR (o con poca miel)\n• FRUTA PICADA DE TEMPORADA\n• GELATINA DE FRUTA NATURAL\n• ARROZ CON LECHE CON CANELA (porciones pequeñas)\n• CAFÉ DE OLLA sin azúcar o con canela\n\nLa jamaica es una bebida antioxidante; prepárala con poca o nada de azúcar y enfriada con hielo.",
        ),
        ArticleSection(
          title: "Involucra a toda la familia",
          content:
              "Hacer la comida juntos es parte del hábito:\n\n• Asigna tareas por edad (lavar, picar, servir)\n• Los niños que ayudan a cocinar comen más sano\n• Los adultos mayores pueden compartir recetas tradicionales\n• Celebra sin comida: terminen la comida con un paseo o juego\n\nCocinar en familia además reduce el estrés y el uso de pantallas durante la comida.",
        ),
        ArticleSection(
          title: "Menú de fin de semana sugerido",
          content:
              "PLAN DE 2 DÍAS:\n\nSÁBADO:\n• Comida: pozole ligero con verduras y pollo\n• Cena: sopa de verduras + quesadillas de flor de calabaza\n\nDOMINGO:\n• Comida: pollo en mole verde con frijoles y ensalada\n• Cena: caldo de pollo con arroz\n\nEntre semana se come rápido; el fin de semana es la oportunidad de cocinar con calma y disfrutar en familia.",
        ),
      ],
    ),
    Article(
      title: "Comer sano con presupuesto: Nutrición sin gastar de más",
      description:
          "Aprende a comer saludable siendo ahorrador con tu despensa",
      content:
          "Comer sano no es caro: es cuestión de estrategia.",
      imageUrl: "lib/data/img/legumbres.jpeg",
      color: Colors.green,
      publishDate: DateTime.now().subtract(const Duration(days: 84)),
      tags: ["economía", "despensa", "ahorro"],
      sections: [
        ArticleSection(
          title: "El mito de que comer sano es caro",
          content:
              "En realidad, la comida ultraprocesada y la comida rápida son las que más cuestan a la larga:\n\n• Comer comida rápida 5 veces por semana cuesta más que cocinar en casa\n• Las enfermedades asociadas a la mala alimentación (diabetes, hipertensión) tienen un costo de salud enorme\n\nLos alimentos más económicos (frijoles, tortillas, huevo, verduras de temporada) son de los más saludables. La clave está en la planeación.",
        ),
        ArticleSection(
          title: "La despensa económica y nutritiva",
          content:
              "Estos básicos rinden mucho por poco:\n\n• FRIJOLES Y LENTEJAS: proteína barata (pocos pesos por kg)\n• HUEVO: proteína de alta calidad y económica\n• TORTILLA DE MAÍZ: carbohidrato complejo, calcio, barato\n• ARROZ Y AVENA: energía por muy poco\n• VERDURAS DE TEMPORADA: compradas en mercado\n• FRUTA DE TEMPORADA\n• NOPALES: una verdura barata y muy nutritiva\n• CALABACITA, CHAYOTE, ZANAHORIA\n\nUn guiso de frijoles con tortillas y nopales cuesta menos que un refresco y un sándwich industrial, y alimenta mucho más.",
        ),
        ArticleSection(
          title: "Estrategias de ahorro en el mercado",
          content:
              "Tips para que tu dinero rinda:\n\n• COMPRA EN MERCADO O TIANGUIS: más barato que supermercado\n• COMPRA TEMPORADA: lo que abunda cuesta menos\n• HAZ LISTA y no compres antojos\n• COMPRA A GRANEL: cereales y leguminosas\n• PLANIFICA EL MENÚ de la semana\n• APROVECHA PROMOCIONES de productos básicos\n• COMPRA MARCA BLANCA en básicos\n• EVITA COMPRAR CON HAMBRE\n\nPlanificar el menú semanal evita las compras impulsivas y el desperdicio de comida.",
        ),
        ArticleSection(
          title: "Recetas de 'pueblo' económicas y sanas",
          content:
              "Comidas tradicionales que son baratas y nutritivas:\n\n• FRIJOLES DE OLLA CON TORTILLAS Y SALSA\n• SOPA DE VERDURAS con cualquier verdura del tianguis\n• REVOLTILLO DE HUEVO CON NOPALES\n• LENTEJAS GUISADAS\n• PAPAS CON VERDURAS Y HUEVO\n• CALDO DE POLLO (aprovecha el hueso y haz más sopa)\n• TORTITAS DE QUELITE O DE PAPA\n• BUDÍN O VERDURAS SALTEADAS con soya\n\nLa 'comida de pobre' tradicional es, nutricionalmente, oro: leguminosas + maíz + verduras + caldos.",
        ),
        ArticleSection(
          title: "Aprovecha cada centavo y evita desperdicio",
          content:
              "El desperdicio de comida es dinero perdido:\n\n• Congela fruta madura para licuados\n• Usa las cáscaras para caldos\n• Cocina 'la olla grande' y refrigera porciones\n• Reutiliza sobras en nuevos platillos (el pollo de hoy, tinga mañana)\n• Compra solo lo que vas a usar\n\nReducir el desperdicio no solo ahorra dinero, también es más sostenible con el planeta. Cada 1 de cada 3 alimentos producidos se desperdicia.",
        ),
      ],
    ),
  ];
}
