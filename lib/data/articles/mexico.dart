import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';
import 'package:nutriplato/infrastructure/entities/article/article_section.dart';

/// Artículos sobre tradición gastronómica y cultura alimentaria mexicana.
List<Article> mexicoArticles() {
  return [
    Article(
      title: "El maíz: El oro que sostiene a México",
      description:
          "Historia, nutrientes y usos de nuestro cereal más emblemático",
      content:
          "El maíz es el corazón de la alimentación mexicana desde hace más de 8,000 años.",
      imageUrl: "lib/data/img/cereales/amaranto.jpg",
      color: Colors.amber,
      publishDate: DateTime.now().subtract(const Duration(days: 159)),
      tags: ["maíz", "tradición", "cultura"],
      sections: [
        ArticleSection(
          title: "El maíz: alimento sagrado",
          content:
              "El maíz tiene más de 8,000 años de historia en México, donde nació:\n\n• Los antiguos mexicanos lo llamaron 'oro' y lo consideraban sagrado\n• Existen más de 60 razas nativas de maíz en México (blanco, azul, rojo, amarillo, negro)\n• El Popol Vuh maya dice que el hombre fue creado de maíz\n\nLa diversidad genética del maíz mexicano es una de las mayores del mundo: un tesoro que alimenta al país desde la milpa.",
        ),
        ArticleSection(
          title: "La nixtamalización: el gran invento mexicano",
          content:
              "La nixtamalización (cocinar el maíz con cal) es un proceso ancestral que transformó la nutrición de Mesoamérica:\n\n• LIBERA LA NIACINA (vitamina B3): previene la pelagra\n• AUMENTA EL CALCIO: la cal aporta calcio al maíz\n• MEJORA la disponibilidad de otros nutrientes\n• REDUCE toxinas del grano crudo\n\nLa tortilla nixtamalizada es superior al maíz sin procesar y aporta calcio de forma natural. Esta es una de las razones por las que la tortilla de maíz es mejor opción que la de harina de trigo.",
        ),
        ArticleSection(
          title: "Nutrientes de la tortilla de maíz",
          content:
              "Una tortilla de maíz (60g aprox) aporta:\n\n• ENERGÍA: 60-70 kcal\n• CARBOHIDRATOS COMPLEJOS: liberación lenta\n• CALCIO: por la nixtamalización\n• FIBRA\n• NIACINA, MAGNESIO, FÓSFORO\n• ÍNDICE GLUCÉMICO más bajo que el pan blanco\n\nEs el carbohidrato tradicional de México: económico, saciante y con nutrientes que el pan industrial no tiene.",
        ),
        ArticleSection(
          title: "Maíz en todas sus formas",
          content:
              "El maíz aparece en toda nuestra gastronomía:\n\n• TORTILLAS Y TACOS\n• POZOLE Y TAMALES\n• ELOTE Y ESQUITES\n• TLACOYOS Y HUARACHES\n• ATOLE Y TEPACHE\n• PANES DE MAÍZ\n\nTips saludables:\n• El elote (maíz fresco) es un carbohidrato de IG medio: disfrútalo con moderación\n• Los esquites y elotes con crema, queso y chile en polvo añaden calorías: modera los extras\n• Prefiere tortilla de maíz sobre tortillas de harina o frituras",
        ),
        ArticleSection(
          title: "El futuro del maíz",
          content:
              "Consumir maíz mexicano es también un acto cultural:\n\n• La milpa (maíz + frijol + calabaza) es un sistema agrícola sostenible milenario\n• La diversidad de razas nativas está en riesgo por los maíces transgénicos\n• Comer maíz criollo y en sus formas tradicionales apoya a comunidades\n\nCada vez que comes una tortilla de maíz nixtamalizada, repites un acto de hace miles de años: es nuestra herencia viva en el plato.",
        ),
      ],
    ),
    Article(
      title: "Los chiles: Picor que cura",
      description:
          "El chile es más que sabor: es un alimento con propiedades medicinales",
      content:
          "El chile da identidad a la cocina mexicana y esconde beneficios sorprendentes.",
      imageUrl: "lib/data/img/vegetables/pimientorojo.jpg",
      color: Colors.red,
      publishDate: DateTime.now().subtract(const Duration(days: 162)),
      tags: ["chile", "picante", "capsaicina"],
      sections: [
        ArticleSection(
          title: "El chile en la historia de México",
          content:
              "El chile es originario de América y su centro de diversidad está en México:\n\n• Existen cientos de variedades mexicanas: jalapeño, serrano, habanero, poblano, guajillo, ancho, chipotle\n• Era usado como tributo, moneda y alimento ritual\n• Los mexicanos consumen en promedio 1kg de chile por persona al año\n\nEl chile no solo condimenta: es parte de la identidad y la nutrición nacional.",
        ),
        ArticleSection(
          title: "Capsaicina: el compuesto activo",
          content:
              "La capsaicina es la molécula que produce el picor:\n\n• ACTIVA receptores de dolor y libera endorfinas (bienestar)\n• ACELERA el metabolismo ligeramente (efecto termogénico)\n• Tiene propiedades ANALGÉSICAS (cremas tópicas)\n• Puede ayudar a la SACIEDAD (comer menos)\n\nLa sensación de picor libera endorfinas, por eso 'los que comen picante son felices'. El efecto termogénico es real pero pequeño: el chile no quema la grasa por sí solo.",
        ),
        ArticleSection(
          title: "Nutrientes del chile",
          content:
              "Los chiles son más que picor:\n\n• VITAMINA C: un chile serrano cubre buena parte del requerimiento diario\n• VITAMINAS A Y E: antioxidantes\n• CAPSAICINA Y CAROTENOIDES: antioxidantes\n• FIBRA\n\nCuriosidad: el chile serrano y el jalapeño tienen más vitamina C que los cítricos, por gramo. Los chiles secos (guajillo, ancho) concentran vitaminas y antioxidantes.",
        ),
        ArticleSection(
          title: "Precauciones con el picante",
          content:
              "No todos toleran el chile igual:\n\n• GASTRITIS, ÚLCERA O REFLUJO: modera el picante\n• SÍNDROME DEL INTESTINO IRRITABLE: puede empeorarlo\n• NIÑOS: adapta según tolerancia\n• PERSONAS QUE TOMAN ANTIÁCIDOS O ANTICOAGULANTES: consulta\n\nSi te 'quema': la leche y el yogurt calman mejor que el agua (la caseína neutraliza la capsaicina, que es soluble en grasa).",
        ),
        ArticleSection(
          title: "Cómo disfrutar el chile sano",
          content:
              "Consejos:\n\n• PREPARA SALSAS CASERAS con jitomate, tomatillo y chile fresco\n• ACOMPAÑA con limón y cebolla (más sabor, menos necesidad de sal)\n• EL CHILE EN POLVO Y LAS SALSAS INDUSTRIALES: revisa sellos (pueden tener sodio o azúcar añadida)\n• PRUEBA CHILES SECOS EN GUISOS: aportan sabor profundo con moderación\n\nLa salsa casera es uno de los condimentos más saludables: verduras frescas, capsaicina y cero sellos de advertencia.",
        ),
      ],
    ),
    Article(
      title: "El chocolate y el cacao: El regalo de los dioses",
      description:
          "De Mesoamérica al mundo: el cacao y sus beneficios comprobados",
      content:
          "El cacao mexicano es un superalimento con historia sagrada.",
      imageUrl: "lib/data/img/animal/quesoazul.jpg",
      color: Colors.brown,
      publishDate: DateTime.now().subtract(const Duration(days: 165)),
      tags: ["cacao", "chocolate", "antioxidantes"],
      sections: [
        ArticleSection(
          title: "La historia del cacao",
          content:
              "El cacao era tan valioso en Mesoamérica que se usaba como moneda:\n\n• Los mayas lo llamaban 'alimento de los dioses'\n• Los aztecas lo consumían como bebida (xocoatl), no como dulce\n• El chocolate llegó a Europa como bebida amarga y espumosa\n\nEl cacao mexicano (de Tabasco y Chiapas) es de los mejor valorados del mundo: México conserva variedades criollas y nacionales de aroma fino.",
        ),
        ArticleSection(
          title: "Los beneficios del cacao",
          content:
              "El cacao puro está cargado de nutrientes:\n\n• FLAVONOIDES (más que el té verde): mejoran la circulación y el corazón\n• TEobromina: estimulante suave que mejora el ánimo\n• MAGNESIO: el mineral antiestrés\n• HIERRO Y ZINC\n• FIBRA\n• ANANDA: 'molécula de la felicidad' (se libera con el cacao)\n\nEstudios asocian el chocolate oscuro (>70% cacao) con mejor presión arterial y flujo cerebral.",
        ),
        ArticleSection(
          title: "Chocolate oscuro vs comercial",
          content:
              "La diferencia es enorme:\n\nCHOCOLATE OSCURO (>70% cacao):\n• Más cacao, menos azúcar\n• Rico en antioxidantes\n\nCHOCOLATE COMERCIAL (con leche, blanco):\n• Menos cacao, mucha azúcar y grasa\n• Con sellos de advertencia\n\nRegla práctica: mientras más % de cacao, más beneficios y menos azúcar. El chocolate blanco ni siquiera contiene cacao (solo manteca de cacao + azúcar).",
        ),
        ArticleSection(
          title: "El chocolate en la cocina mexicana",
          content:
              "Nuestro cacao va más allá del dulce:\n\n• MOLE: cacao + chiles + especias (el mole poblano es un ícono)\n• CHOCOLATE DE METATE PARA BEBER (con canela, vainilla y poca azúcar)\n• TAMALES DE CHOCOLATE\n• ATOLE DE CHOCOLATE\n• CHAMPURRADO\n\nEl mole combina cacao y chiles, dos superalimentos mexicanos. Úsalo con moderación por su densidad calórica, pero no lo temas: es mucho más sano que un postre procesado.",
        ),
        ArticleSection(
          title: "Cómo disfrutarlo sano",
          content:
              "Consejos:\n\n• ELIGE CHOCOLATE OSCURO (>70%) y consúmelo en porciones pequeñas (2-3 cuadritos)\n• TOMA CHOCOLATE CALIENTE CON CACAO PURO, canela y poca miel\n• EVITA chocolates con sellos de advertencia\n• UN CUADRITO de cacao con nueces como snack satisface el antojo de dulce con beneficios\n\nEl cacao mexicano es un tesoro: comparte su historia y su sabor con moderación, y obtendrás antioxidantes, magnesio y felicidad.",
        ),
      ],
    ),
    Article(
      title: "La dieta de la milpa: El modelo ancestral de nutrición",
      description:
          "El sistema alimentario más sostenible de Mesoamérica y cómo recuperarlo",
      content:
          "La milpa es un ejemplo perfecto de nutrición, sostenibilidad y cultura.",
      imageUrl: "lib/data/img/maiz_frijol_combo.jpeg",
      color: Colors.lightGreen,
      publishDate: DateTime.now().subtract(const Duration(days: 168)),
      tags: ["milpa", "tradición", "sostenible"],
      sections: [
        ArticleSection(
          title: "¿Qué es la milpa?",
          content:
              "La milpa es un sistema agrícola mesoamericano basado en la asociación de cultivos:\n\n• MAÍZ: el sostén (energía)\n• FRIJOL: proteína y fija nitrógeno al suelo\n• CALABAZA: cubre el suelo, aporta vitaminas y semillas\n• + CHILES, QUELITES, TOMATE Y HIERBAS de acompañamiento\n\nEs un sistema milenario que se retroalimenta: cada planta ayuda a las otras. No es solo agricultura, es un modelo de nutrición completo.",
        ),
        ArticleSection(
          title: "Por qué la milpa es nutricionalmente perfecta",
          content:
              "La combinación de la milpa cubre necesidades nutricionales:\n\n• MAÍZ + FRIJOL: proteína completa (todos los aminoácidos esenciales)\n• MAÍZ + FRIJOL + CALABAZA: carbohidratos + proteína + fibra + vitaminas\n• CHILES: vitamina C y antioxidantes\n• QUELITES: hierro, folato y calcio\n\nEs la 'dieta mediterránea' de América: un patrón alimentario completo construido por siglos de coevolución.",
        ),
        ArticleSection(
          title: "Los quelites y la biodiversidad",
          content:
              "Los quelites son las plantas silvestres comestibles que acompañaban la milpa:\n\n• QUNTONIL, VERDOLAGA, ROMERITOS, HUAUZONTLE, BERRO\n• Son de las hortalizas con mayor densidad de nutrientes\n• Crecen sin pesticidas ni mucha agua\n• Rescatar su consumo enriquece la dieta y la cultura\n\nLa verdolaga tiene omega-3 vegetal; el quintonil es rico en hierro y calcio. Son 'superalimentos' silvestres de nuestra tierra.",
        ),
        ArticleSection(
          title: "Cómo incorporar la milpa hoy",
          content:
              "No necesitas cultivar una milpa para comer como ella:\n\n• COME FRIJOLES + TORTILLA DE MAÍZ a diario\n• INCLUYE CALABAZA Y SUS FLORES (flor de calabaza)\n• AGREGAL CHILES Y QUELITES a tus guisos\n• VUELVE A LOS PLATILLOS TRADICIONALES: tlacoyos, sopes, enfrijoladas, pozole\n\nComer como la milpa es comer alimentos reales, locales, baratos y sostenibles: la mejor lección nutricional de nuestros ancestros.",
        ),
        ArticleSection(
          title: "Sostenibilidad y cultura",
          content:
              "Recuperar la milpa es:\n\n• SOSTENIBLE: usa menos agua y no requiere fertilizantes químicos\n• CULTURAL: preserva semillas nativas y saberes\n• ECONÓMICA: alimenta a familias con poco\n• NUTRICIONAL: una dieta completa con alimentos locales\n\nEn un mundo que busca dietas sostenibles, la milpa es un modelo a seguir. Nuestros ancestros ya resolvieron la ecuación que hoy buscamos: comer sano, barato y cuidando la tierra.",
        ),
      ],
    ),
    Article(
      title: "Nopales y tunas: Los vegetales estrella de México",
      description:
          "El cactus que regula tu glucosa, colesterol y digestión",
      content:
          "El nopal es el símbolo de México y un vegetal con propiedades únicas.",
      imageUrl: "lib/data/img/vegetables/espainaca.jpg",
      color: Colors.green,
      publishDate: DateTime.now().subtract(const Duration(days: 171)),
      tags: ["nopal", "tuna", "vegetal mexicano"],
      sections: [
        ArticleSection(
          title: "El nopal: de símbolo a alimento funcional",
          content:
              "El nopal está en el escudo nacional y en el plato nacional:\n\n• Es un vegetal con fibra soluble única (mucílago)\n• Se consume fresco, asado, en jugos y en polvo\n• México produce millones de toneladas al año\n\nLa ciencia moderna está confirmando lo que nuestros ancestros sabían: el nopal tiene efectos reales sobre la glucosa y el colesterol.",
        ),
        ArticleSection(
          title: "Beneficios comprobados del nopal",
          content:
              "Estudios del IPN y otras instituciones muestran:\n\n• REDUCE LA GLUCOSA POSTPRANDIAL (después de comer) hasta 17%\n• AYUDA A BAJAR EL COLESTEROL (fibra soluble)\n• ALTO CONTENIDO DE FIBRA: mejora el tránsito intestinal\n• ANTIOXIDANTES: betalaínas y vitamina C\n• BAJO EN CALORÍAS: 16 kcal por 100g\n• MINERALES: magnesio, calcio, potasio\n\nConsumir nopal antes o con comidas ricas en carbohidratos modera el pico de glucosa.",
        ),
        ArticleSection(
          title: "Cómo consumir nopal",
          content:
              "Versátil en la cocina:\n\n• ENSALADA DE NOPALITOS con jitomate, cebolla y cilantro\n• TACOS DE NOPAL ASADO\n• LICUADO VERDE (nopal + piña + apio)\n• NOPAL CON HUEVO (revoltillo)\n• SOPA DE NOPAL\n• NOPALES EN SALSA VERDE\n\nTips: para reducir la baba, córtalo en tiras finas y cocínalo con cebolla y un poco de sal. La baba es el mucílago (fibra soluble) que da sus beneficios: no la elimines toda.",
        ),
        ArticleSection(
          title: "La tuna y sus beneficios",
          content:
              "El fruto del nopal (la tuna) también es saludable:\n\n• FIBRA Y AGUA: hidratación y saciedad\n• ANTIOXIDANTES (betalaínas): las tunas rojas y moradas tienen más\n• MAGNESIO Y POTASIO\n• BAJA EN CALORÍAS\n\nLa tuna se consume fresca (pela con cuidado las espinas), en aguas y en dulces (los 'quesos de tuna' y 'colonche' son altos en azúcar: modera).",
        ),
        ArticleSection(
          title: "Precauciones",
          content:
              "El nopal es seguro para la mayoría, pero:\n\n• EN DIABÉTICOS QUE TOMAN MEDICAMENTO: monitoriza la glucosa (el nopal potencializa el efecto)\n• EN POLVO O EXTRACTO: no lo sustituyas por tratamiento médico\n• GRANDES CANTIDADES: pueden causar gases o diarrea\n\nEl nopal es un complemento alimentario, no un reemplazo de tu medicación. Consúmelo como parte de una dieta equilibrada.",
        ),
      ],
    ),
    Article(
      title: "Aguas frescas: Bebidas tradicionales mexicanas y su salud",
      description:
          "Jamaica, limón, horchata, tamarindo... conoce el lado nutritivo de nuestras aguas",
      content:
          "Las aguas frescas son parte de nuestra cultura. Aprende a prepararlas sanas.",
      imageUrl: "lib/data/img/fruits/limon.jpg",
      color: Colors.lightBlue,
      publishDate: DateTime.now().subtract(const Duration(days: 174)),
      tags: ["aguas frescas", "bebidas", "tradición"],
      sections: [
        ArticleSection(
          title: "El problema: la cantidad de azúcar",
          content:
              "Una 'agua fresca' tradicional puede llevar mucho azúcar:\n\n• El promedio en fondas y taquerías: 2-4 cucharadas de azúcar por vaso\n• Un vaso de agua de horchata comercial puede tener hasta 10 cucharaditas\n\nLa solución no es dejar de beber aguas frescas, sino prepararlas con menos azúcar y más ingrediente natural. El cuerpo no distingue entre 'azúcar de agua fresca' y 'azúcar de refresco'.",
        ),
        ArticleSection(
          title: "Aguas frescas con beneficios reales",
          content:
              "El ingrediente base puede aportar nutrientes:\n\n• JAMAICA: ANTIOXIDANTES (antocianinas), ligera acción diurética y ayuda a la presión arterial\n• LIMÓN: vitamina C\n• TAMARINDO: minerales (magnesio, potasio), fibra\n• CHÍA: omega-3 y fibra\n• PEPINO: hidratación\n• MELÓN/SANDÍA: vitaminas A y C, potasio\n\nLa jamaica es una de las bebidas más saludables de nuestra tradición: rica en antioxidantes, sin necesidad de azúcar para disfrutarla.",
        ),
        ArticleSection(
          title: "Cómo preparar aguas frescas sanas",
          content:
              "La regla de oro: MUCHO SABOR, POCA AZÚCAR\n\n• USa la fruta o flor como protagonista (más ingrediente, menos agua-azúcar)\n• ENDULZA CON UN TOQUE o no endulces: la jamaica y el limón se disfrutan bien solos\n• PRUEBA ENDULZANTES NATURALES con moderación (poca miel o stevia)\n• AGREGA CHÍA para fibra y omega-3\n• PREFIERE LA FRUTA ENTERA en vez de jarabes\n\nReceta ideal: 1 puño de flor de jamaica + 1.5L agua + hielo + opcional 1 cucharadita de azúcar por vaso (en vez de 3-4).",
        ),
        ArticleSection(
          title: "Agua vs aguas frescas: cuándo elegir qué",
          content:
              "Tu guía:\n\n• AGUA NATURAL: para todos los días, la base de la hidratación\n• AGUAS FRESCAS SIN AZÚCAR: opción saludable para acompañar comidas\n• AGUAS FRESCAS CON AZÚCAR: ocasionales, en porción pequeña\n• REFRESCO: lo menos posible\n\nEl agua de jamaica o limón sin azúcar es tan sabrosa como el refresco cuando te acostumbras, y aporta antioxidantes en lugar de calorías vacías.",
        ),
        ArticleSection(
          title: "Otras bebidas tradicionales",
          content:
              "Nuestro repertorio de bebidas:\n\n• ATOLE Y CHOCOLATADAS: consumir con moderación (son calóricos), versiones con menos azúcar\n• TEPACHE: fermentado de maíz, probiótico (con moderación)\n• PULQUE: fermentado tradicional, probiótico (responsablemente)\n• CHOCOLATE DE AGUA con canela y poca azúcar\n• CAFÉ DE OLLA con piloncillo moderado\n\nLas bebidas fermentadas tradicionales (tepache, pulque) aportan probióticos y historia. Con moderación y sin exceso de azúcar, son parte de una cultura alimentaria rica.",
        ),
      ],
    ),
    Article(
      title: "Tacos: Tu comida favorita puede ser saludable",
      description:
          "Guía para armar tacos nutritivos sin renunciar al sabor",
      content:
          "Los tacos pueden ser una comida equilibrada si sabes cómo armarlos.",
      imageUrl: "lib/data/img/vegetables/tomate.jpg",
      color: Colors.orange,
      publishDate: DateTime.now().subtract(const Duration(days: 177)),
      tags: ["tacos", "comida callejera", "mexicano"],
      sections: [
        ArticleSection(
          title: "El taco: ¿comida chatarra o comida completa?",
          content:
              "El taco puede ser ambas cosas. La diferencia está en cómo se arma:\n\nUN TACO EQUILIBRADO tiene:\n• Tortilla (carbohidrato)\n• Proteína (pollo, bistec, frijol)\n• Verduras (cebolla, cilantro, nopales)\n• Grasa saludable (aguacate, salsa)\n\nUN TACO PROBLEMA tiene:\n• Doble tortilla de harina\n• Solo proteína frita + mucho queso\n• Crema, tocino y salsa industrial\n\nEl taco clásico de taquería con tortilla de maíz, pollo/bistec, cebolla, cilantro y salsa es una comida razonablemente completa.",
        ),
        ArticleSection(
          title: "Guía para elegir en la taquería",
          content:
              "Ordena estratégicamente:\n\n• MEJORES OPCIONES: de pollo, bistec, suadero (sin exceso), pastor (moderado), lengua, de frijol con queso\n• MODERAR: carnitas (grasosas), chorizo y longaniza, cabeza\n• PIDE VERDURAS: cebolla, cilantro, nopales asados\n• SALSAS: preferiblemente la verde o roja natural (no la de crema)\n• TORTILLA DE MAÍZ: sobre la de harina\n\nAgrega nopales asados a tus tacos: fibra, bajo costo y un clásico. Evita pedir tortilla extra 'por si acaso'.",
        ),
        ArticleSection(
          title: "Tacos caseros saludables",
          content:
              "En casa puedes hacer versiones aún mejores:\n\n• TAcos DE POLLO DESHEBRADO con salsa verde (tinga ligera)\n• TACOS DE FRIJOL con queso panela\n• TACOS DE NOPAL ASADO con pico de gallo\n• TACOS DE SOYA TEXTURIZADA estilo pastor\n• TACOS DE PESCADO con ensalada de col\n• TACOS DE PAPA CON VERDURAS (al horno, no fritos)\n\nLa proteína texturizada de soya con achiote imita al pastor sin grasas saturadas: una opción vegetariana rica.",
        ),
        ArticleSection(
          title: "El acompañamiento cuenta",
          content:
              "Lo que pides al lado puede arruinar los tacos sanos:\n\n• REFRESCO: la fuente principal de calorías vacías\n• PAPAS Y BOTANAS: cambia por jícama con limón y chile\n• CREMA Y QUESO EN EXCESO: modera\n\nUna orden de 3 tacos de bistec con verduras y agua natural puede ser una comida equilibrada de ~500 kcal. Los mismos tacos con refresco, papas, crema extra y tortilla de harina fácilmente superan las 1000 kcal.",
        ),
        ArticleSection(
          title: "Consejos finales",
          content:
              "• COMELOS A LA HORA DEL HAMBRE REAL, no por antojo vacío\n• UNO O DOS TACOS CON ENSALADA AL LADO es mejor que 5 tacos solos\n• PREPARA SALSAS CASERAS: más sabor, sin sellos\n• LA FRECUENCIA IMPORTa: unos tacos de vez en cuando están bien; todos los días necesitan versiones más verdes\n\nLos tacos son cultura y placer: disfrútalos inteligentemente, con tortilla de maíz, más verduras y sin refresco.",
        ),
      ],
    ),
    Article(
      title: "Pozole, tamales y otros antojos: Disfruta las tradiciones sanamente",
      description:
          "Cómo comer platillos tradicionales mexicanos con equilibrio",
      content:
          "Nuestras tradiciones culinarias pueden convivir con una alimentación saludable.",
      imageUrl: "lib/data/img/cereales/maiz.jpg",
      color: Colors.deepOrange,
      publishDate: DateTime.now().subtract(const Duration(days: 180)),
      tags: ["tradiciones", "poole", "festividades"],
      sections: [
        ArticleSection(
          title: "Comida tradicional y nutrición: amigos posibles",
          content:
              "La comida tradicional mexicana es cultural y emocional:\n\n• Está ligada a fiestas, familia e identidad\n• No hay que eliminarla: hay que equilibrarla\n• Los alimentos tradicionales, bien preparados, son nutritivos\n\nEl problema no es el pozole o el tamal en sí, sino la combinación diaria con otros excesos y la falta de actividad física.",
        ),
        ArticleSection(
          title: "El pozole: grande pero balanceable",
          content:
              "Un plato de pozole es abundante, pero puede ser equilibrado:\n\n• EL MAÍZ (cacahuazintle): carbohidrato completo con fibra\n• EL CALDO: hidratante\n• POLLO O CERDO: proteína\n\nPara hacerlo más sano:\n• ELIGE MÁS CALDO Y VERDURAS (lechuga, rábano, cebolla, orégano)\n• MODERA la crema y el queso (grasa saturada)\n• LIMITA las tostadas fritas: prefiere totopos horneados\n• DISFRUTA UN PLATO, no dos con extra\n\nEl pozole blanco o verde con abundante verdura y poca crema es un platillo razonable.",
        ),
        ArticleSection(
          title: "Los tamales: joyas nutritivas con su 'pero'",
          content:
              "El tamal aporta:\n\n• MASA DE MAÍZ: energía y calcio (nixtamalización)\n• RELLENO: pollo, rajas, frijol, elote\n\nSu 'pero' es la GRASA y el tamaño:\n• El uso de manteca en la masa suma calorías\n• Un tamal promedio: 250-400 kcal\n\nConsejo: disfruta 1 tamal con salsa (no atole azucarado al lado), o parte el tamal en 2. Los tamales de elote y de frijol suelen tener menos grasa que los de manteca.",
        ),
        ArticleSection(
          title: "La sobremesa de las fiestas",
          content:
              "En posadas, fiestas patrias y reuniones:\n\n• ELIGE 2-3 ANTOJITOS Y NO TODOS\n• PRUEBA UN POCO DE CADA UNO (para variar) en lugar de porciones enormes de uno\n• BEBE AGUA entre antojos\n• BAILA Y CAMINA (la fiesta es también actividad)\n• NO COMPENSES con castigo después (la culpa no ayuda)\n\nLa regla del 80/20: si el 80% de tus comidas son sanas, el 20% de disfrute tradicional no arruina tu salud.",
        ),
        ArticleSection(
          title: "Recuperando el equilibrio tras las fiestas",
          content:
              "Después de un día de antojos:\n\n• VUELVE A TU RUTINA al siguiente día (no ayunes de castigo)\n• HIDRÁTATE BIEN\n• PRIORIZA VERDURAS, PROTEÍNA Y AGUA\n• EJERCÍCATE un poco más\n• NO TE SIENTAS CULPABLE: un día no arruina meses de buenos hábitos\n\nLa flexibilidad es la clave de una alimentación sostenible: poder disfrutar las tradiciones sin culpa es más saludable que una dieta perfecta que no puedes mantener.",
        ),
      ],
    ),
    Article(
      title: "La cocina veracruzana: Pescados y mariscos de la costa",
      description:
          "El sabor del golfo y los beneficios de la dieta de mariscos",
      content:
          "La cocina veracruzana es un ejemplo de comida deliciosa y saludable.",
      imageUrl: "lib/data/img/animal/salmon.jpg",
      color: Colors.cyan,
      publishDate: DateTime.now().subtract(const Duration(days: 183)),
      tags: ["veracruz", "mariscos", "pescado"],
      sections: [
        ArticleSection(
          title: "El pescado a la veracruzana: platillo modelo",
          content:
              "El pescado a la veracruzana reúne lo mejor de la nutrición:\n\n• PESCADO: proteína magra y omega-3\n• SALSA DE JITOMATE: licopeno (mejor absorbido cocido)\n• ACEITUNAS Y ALCAPARRAS: sabor intenso, moderar por su sodio\n• CEBOLLA, AJO, LAUREL, ORÉGANO: antioxidantes\n• CHILE: vitamina C\n\nEs un platillo completo: proteína + verduras + grasas buenas, cocido en salsa (no frito). Un modelo de cocina saludable.",
        ),
        ArticleSection(
          title: "Omega-3: el tesoro de los pescados",
          content:
              "Los pescados del golfo aportan omega-3, esenciales para:\n\n• EL CORAZÓN: reduce triglicéridos y arritmias\n• EL CEREBRO: desarrollo y protección cognitiva\n• LA INFLAMACIÓN\n\nPescados mexicanos ricos en omega-3: salmón (aunque de importación), sardina, sierra, atún, huachinango (rojo), mojarra.\n\nLa sardina es la joya económica: barata, sustentable y cargada de omega-3 y calcio.",
        ),
        ArticleSection(
          title: "Mariscos y su valor nutricional",
          content:
              "Los mariscos mexicanos (camarón, ostión, pulpo, jaiba) aportan:\n\n• PROTEÍNA DE ALTA CALIDAD con poca grasa\n• ZINC: inmunidad\n• YODO: tiroides\n• SELENIO: antioxidante\n• B12: energía\n\nEl ostión es especialmente rico en zinc; el camarón es proteína pura con poca grasa. Modera el camarón empanizado o en coctel con exceso de cátsup y salsa.",
        ),
        ArticleSection(
          title: "Cómo elegir y consumir pescado seguro",
          content:
              "Recomendaciones de COFEPRIS:\n\n• COMPRA EN ESTABLECIMIENTOS CONFIABLES (evita la venta en calles sin refrigeración)\n• OBSERVA: fresco, con olor a mar, ojos brillantes, agallas rojas\n• COCINA BIEN el pescado (hasta que la carne se desprenda)\n• EMBARAZADAS: evita especies altas en mercurio (tiburón, pez espada, marlín, atún rojo)\n\nElige pescados pequeños (sardina, mojarra) que acumulan menos mercurio y son más sustentables.",
        ),
        ArticleSection(
          title: "El papel de la dieta de la costa en la salud",
          content:
              "Las poblaciones costeras que comen pescado regularmente tienen:\n\n• MENOR riesgo cardiovascular\n• MEJOR salud cerebral\n• DIETAS RICAS en proteína magra y omega-3\n\nIncorpora pescado 2-3 veces por semana, como lo hace la dieta veracruzana. La cocina de la costa demuestra que sano y sabroso van juntos.",
        ),
      ],
    ),
    Article(
      title: "Elote y esquites: El antojo de la calle con equilibrio",
      description:
          "Cómo disfrutar el clásico antojo callejero sin excederte",
      content:
          "El elote es el sabor de las calles mexicanas. Aquí cómo disfrutarlo con inteligencia.",
      imageUrl: "lib/data/img/cereales/maiz.jpg",
      color: Colors.amber,
      publishDate: DateTime.now().subtract(const Duration(days: 186)),
      tags: ["elote", "esquites", "calle"],
      sections: [
        ArticleSection(
          title: "El valor nutricional del maíz fresco",
          content:
              "El elote (maíz fresco) tiene virtudes:\n\n• CARBOHIDRATOS COMPLEJOS: energía de liberación lenta\n• FIBRA: buena digestión\n• VITAMINAS DEL COMPLEJO B\n• MAGNESIO Y FÓSFORO\n• FOLATO\n\nUn elote cocido (sin extras) es un snack de índice glucémico medio: razonable como parte de la dieta. El maíz es 'oro mexicano' también en esta forma.",
        ),
        ArticleSection(
          title: "Dónde se esconden las calorías",
          content:
              "El elote no es el problema, los EXTRAS sí:\n\n• MAYONESA: ~90 kcal por cucharada\n• MANTEQUILLA: ~100 kcal por cucharada\n• QUESO RALLADO: ~45 kcal por cucharada\n• CHILE EN POLVO CON SAL: sodio\n\nUn esquites 'cargado' con mayonesa, mantequilla, queso y chile puede superar las 500 kcal: más que una comida ligera.\n\nVersión ligera: elote asado con limón y chile en polvo SIN mayonesa ni mantequilla.",
        ),
        ArticleSection(
          title: "Cómo pedirlos más sanos",
          content:
              "Tu pedido inteligente:\n\n• ELOTE ASADO con limón y chile (sin mayonesa ni mantequilla)\n• ESQUITES con limón, chile y un toque de queso\n• 'PIDE LA MITAD DE QUESO' o pide el queso aparte\n• AGUA o agua de limón natural, no refresco\n\nEl limón y el chile aportan vitamina C y sabor sin calorías: los extras de siempre pueden transformar el antojo.",
        ),
        ArticleSection(
          title: "Esquites caseros",
          content:
              "En casa controlas todo:\n\n• MAÍZ DESGRANADO cocido al vapor o hervido\n• CON LIMÓN, CHILE, EPASOTE y un toque de sal\n• UN TOQUE DE MANTEQUILLA o queso (no ambos)\n• SIN MAYONESA\n\nLa preparación casera con hierbas (epazote) realza el sabor sin necesidad de grasas extras. Puedes usar maíz de la olla y preparar porciones individuales.",
        ),
        ArticleSection(
          title: "Frecuencia y equilibrio",
          content:
              "El antojo callejero no es el enemigo:\n\n• DISFRÚTALO DE VEZ EN CUANDO (no a diario)\n• ELIGE LA VERSIÓN MÁS SIMPLE (limón y chile)\n• COMPENSA EL RESTO DEL DÍA con verduras y agua\n\nEl equilibrio real está en la constancia de tus hábitos diarios, no en prohibirte el elote de la esquina. Comer calle, disfrutar y volver a lo sano: así se mantiene una alimentación sostenible.",
        ),
      ],
    ),
    Article(
      title: "Tortillas: ¿De maíz o de harina? La respuesta nutricional",
      description:
          "Conoce las diferencias entre la tortilla de maíz y la de harina",
      content:
          "La tortilla es la base de la cocina mexicana. Elegir bien marca la diferencia.",
      imageUrl: "lib/data/img/cereales/panintegral.jpg",
      color: Colors.brown,
      publishDate: DateTime.now().subtract(const Duration(days: 189)),
      tags: ["tortilla", "maíz", "harina"],
      sections: [
        ArticleSection(
          title: "El debate tortilla de maíz vs harina",
          content:
              "Ambas son parte de la dieta mexicana, pero nutricionalmente no son iguales:\n\nTORTILLA DE MAÍZ (nixtamalizada):\n• Calcio (por la nixtamalización)\n• Fibra\n• Menor índice glucémico\n• Más barata\n• Sin gluten\n\nTORTILLA DE HARINA (trigo):\n• Más calóricas por pieza\n• Menos fibra\n• Mayor índice glucémico\n• Más sodio\n• Con gluten",
        ),
        ArticleSection(
          title: "Los números comparados",
          content:
              "Por tortilla (~50g):\n\nTORTILLA DE MAÍZ:\n• 60-70 kcal\n• 2g fibra\n• 20mg calcio\n• 70mg sodio\n\nTORTILLA DE HARINA:\n• 130-150 kcal\n• 1g fibra\n• 10mg calcio\n• 400-500mg sodio\n\nLa tortilla de harina tiene MÁS DEL DOBLE de calorías y hasta 6 veces más sodio que la de maíz.",
        ),
        ArticleSection(
          title: "Los beneficios de la nixtamalización",
          content:
              "La tortilla de maíz tradicional tiene una ventaja única:\n\n• La nixtamalización (cocción con cal) aporta CALCIO\n• LIBERA NIACINA (vitamina B3)\n• MEJORA la digestibilidad\n\nEste proceso ancestral convierte al maíz en un alimento superior. La tortilla de maíz es, de hecho, un alimento 'fortificado' de forma natural.",
        ),
        ArticleSection(
          title: "¿Cuándo usar tortilla de harina?",
          content:
              "La tortilla de harina tiene su lugar:\n\n• EN TACOS DE GUAJOLOTE, BURRITOS Y ALGUNOS PLATILLOS DEL NORTE\n• Como parte de una dieta variada, ocasionalmente\n• SI NO ERES DIABÉTICO Y NO ABUSAS, una tortilla de harina de vez en cuando no es grave\n\nSi eres diabético o estás en control de peso, prioriza la tortilla de maíz. Y revisa: las tortillas de harina 'grandes' de taquería pueden duplicar el aporte.",
        ),
        ArticleSection(
          title: "Consejos de consumo",
          content:
              "• PREFIERE TORTILLA DE MAÍZ como base diaria\n• LAS TORTILLAS FRESCAS de maíz (de tortillería) son mejores que las envasadas (revisa sellos)\n• LIMITA las tostadas fritas y los totopos comerciales\n• EL TACO: tortilla de maíz + proteína + verdura + salsa = equilibrio\n• CUIDA LA CANTIDAD: 3-4 tortillas por comida es razonable según tu energía\n\nLa tortilla de maíz es un alimento bueno para México: nutritiva, económica y cultural. Úsala como base de tus comidas.",
        ),
      ],
    ),
  ];
}
