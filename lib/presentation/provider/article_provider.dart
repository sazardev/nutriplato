import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';
import 'package:nutriplato/infrastructure/entities/article/article_section.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> articles = [];
  Article? selectedArticle;
  bool isLoading = false;
  String? error;

  void getArticles() async {
    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      articles = _getExampleArticles();
      isLoading = false;
      error = null;
    } catch (e) {
      error = e.toString();
      isLoading = false;
    }

    notifyListeners();
  }

  void setSelectedArticle(Article article) {
    selectedArticle = article;
    notifyListeners();
  }

  List<Article> _getExampleArticles() {
    return [
      Article(
        title: "Beneficios de una alimentación balanceada",
        description:
            "Descubre cómo una alimentación equilibrada mejora tu salud según la Guía Alimentaria Mexicana",
        content: "La alimentación balanceada es clave para la salud integral.",
        imageUrl: "lib/data/img/plato_del_bien_comer.jpeg",
        color: Colors.green,
        publishDate: DateTime.now().subtract(const Duration(days: 3)),
        tags: ["nutrición", "salud", "bienestar"],
        sections: [
          ArticleSection(
            title: "¿Qué es una alimentación balanceada?",
            content:
                "Una alimentación balanceada consiste en consumir una variedad de alimentos que proporcionen los nutrientes necesarios para mantener la salud y tener energía. Según la Secretaría de Salud de México y el 'Plato del Bien Comer', una dieta equilibrada debe incluir:\n\n• Verduras y frutas (⅓ del plato)\n• Cereales y tubérculos (⅓ del plato)\n• Leguminosas y alimentos de origen animal (⅓ del plato)\n\n¿Sabías que? Los mexicanos consumen en promedio solo 34% de las verduras recomendadas diariamente, según datos del INSP.",
            images: ["lib/data/img/nutrition_balance.jpeg"],
          ),
          ArticleSection(
            title: "Beneficios para la salud física",
            content:
                "El IMSS destaca que una alimentación equilibrada tiene múltiples beneficios comprobados:\n\n• Mantiene un peso saludable, combatiendo la obesidad que afecta al 75.2% de la población adulta mexicana\n• Fortalece el sistema inmunológico, aumentando hasta 25% la capacidad de defensa\n• Reduce hasta un 80% el riesgo de enfermedades crónicas como diabetes (que afecta a 14% de mexicanos) y enfermedades cardíacas\n• Previene la desnutrición y deficiencias nutricionales\n• Mejora la energía y vitalidad diaria\n\nPara toda la familia: Un juego divertido es crear 'platos arcoíris' con alimentos de diferentes colores. ¡Mientras más colores naturales tenga tu plato, más nutrientes contiene!",
            images: ["lib/data/img/healthy_food_variety.jpeg"],
          ),
          ArticleSection(
            title: "Impacto en la salud mental",
            content:
                "Según investigaciones respaldadas por el CONACYT, la alimentación también afecta directamente nuestra salud mental:\n\n• Una dieta rica en omega-3 (pescados, nueces) reduce síntomas de depresión en hasta 30%\n• Los probióticos (yogurt, alimentos fermentados) mejoran el estado de ánimo a través del eje intestino-cerebro\n• Alimentos ricos en triptófano (plátano, huevo) favorecen la producción de serotonina, hormona de la felicidad\n• Dieta variada reduce hasta 20% el riesgo de deterioro cognitivo\n\nPara niños: Explícales que los alimentos son como \"superpoderes\" para el cerebro. Los pescados son \"alimentos inteligentes\" que ayudan a pensar mejor.",
          ),
          ArticleSection(
            title: "El plato del bien comer mexicano",
            content:
                "La Norma Oficial Mexicana NOM-043-SSA2-2012 establece el 'Plato del Bien Comer' como guía alimentaria para la población mexicana. Esta herramienta visual facilita la elección de alimentos saludables adaptados a nuestra cultura:\n\n• Verduras y frutas: Proporcionan vitaminas, minerales y fibra. ¡Come al menos 5 porciones diarias de diferentes colores!\n• Cereales: Aportan energía para tus actividades. Prefiere los integrales (tortilla, amaranto, avena).\n• Leguminosas y alimentos de origen animal: Construyen y reparan tus tejidos. Combina frijoles con maíz para proteínas completas.\n\nTip práctico: Usa tu mano como guía de porciones - el puño para cereales, la palma para proteínas, y el pulgar para grasas saludables.",
            images: ["lib/data/img/plato_bien_comer_oficial.jpg"],
          ),
          ArticleSection(
            title: "Hábitos para toda la familia",
            content:
                "La Secretaría de Salud recomienda estos hábitos para implementar una alimentación balanceada en casa:\n\n• Involucra a niños en la preparación de alimentos. Los niños que cocinan comen más saludable.\n• Establece horarios regulares de comida en familia.\n• Toma agua simple (2 litros diarios) en lugar de bebidas azucaradas.\n• Reduce el consumo de alimentos ultraprocesados y comida rápida.\n• Lee las etiquetas nutrimentales (utiliza el nuevo etiquetado frontal mexicano).\n\nRecuerda: La hidratación también es fundamental. El 70% de nuestro cuerpo es agua, y necesitamos reponer aproximadamente 2 litros diarios mediante bebidas y alimentos.",
          ),
        ],
      ),
      Article(
        title: "Los mejores alimentos para deportistas",
        description:
            "Nutrición adecuada para mejorar tu rendimiento físico según especialistas mexicanos",
        content:
            "La alimentación correcta puede potenciar significativamente tu rendimiento deportivo.",
        imageUrl: "lib/data/img/fitness_food.jpeg",
        color: Colors.blue,
        publishDate: DateTime.now().subtract(const Duration(days: 5)),
        tags: ["deporte", "energía", "rendimiento"],
        sections: [
          ArticleSection(
            title: "Carbohidratos: El combustible principal",
            content:
                "Los carbohidratos son la fuente primaria de energía para el ejercicio. La CONADE (Comisión Nacional de Cultura Física y Deporte) recomienda:\n\n• Antes del ejercicio: Consume carbohidratos complejos 2-3 horas antes (avena, pan integral, camote)\n• Durante el ejercicio: Para actividades mayores a 60 minutos, 30-60g de carbohidratos por hora\n• Después del ejercicio: Reponer 1-1.2g/kg de peso en las primeras 4 horas\n\n¿Sabías que? Un plátano aporta aproximadamente 27g de carbohidratos, ideal para recuperarse después de entrenar. Los deportistas mexicanos de alto rendimiento consumen en promedio 5-7g de carbohidratos/kg de peso corporal.",
            images: ["lib/data/img/carbs_for_athletes.jpeg"],
          ),
          ArticleSection(
            title: "Proteínas para recuperación y crecimiento",
            content:
                "Según el Instituto Nacional de Medicina del Deporte, las proteínas son esenciales para la reparación muscular:\n\n• Requerimiento diario: 1.2-2.0g/kg de peso corporal para deportistas (vs 0.8g/kg en sedentarios)\n• Timing: Distribuir el consumo cada 3-4 horas para maximizar la síntesis proteica muscular\n• Fuentes mexicanas recomendadas: Pollo, huevo, frijoles, lentejas, amaranto, chía\n\nPara niños deportistas: Explícales que las proteínas son como \"ladrillos\" que reparan sus músculos después de jugar. Un vaso de leche con chocolate natural después de entrenar es una excelente opción de recuperación.",
            images: ["lib/data/img/protein_sources_mx.jpeg"],
          ),
          ArticleSection(
            title: "Hidratación estratégica",
            content:
                "La FEMEDE (Federación Mexicana de Medicina del Deporte) destaca la importancia de la hidratación, especialmente en el clima mexicano:\n\n• Antes: 400-600ml de agua 2 horas antes del ejercicio\n• Durante: 150-250ml cada 15-20 minutos. En ejercicios intensos >60 minutos, añadir electrolitos\n• Después: 1.5 litros por cada kg de peso perdido durante el ejercicio\n\nDato importante: La deshidratación de solo 2% del peso corporal reduce el rendimiento hasta en un 20%. En climas cálidos como muchas regiones de México, este porcentaje puede alcanzarse en solo 45 minutos de ejercicio intenso.\n\nPara toda la familia: Preparen aguas frescas naturales con frutas como alternativa a las bebidas deportivas comerciales.",
          ),
          ArticleSection(
            title: "Alimentos tradicionales mexicanos para deportistas",
            content:
                "Nuestra gastronomía ofrece excelentes opciones para deportistas, respaldadas por estudios de la UNAM:\n\n• Amaranto: Con 16g de proteína por 100g, es un superalimento mexicano que contiene los 9 aminoácidos esenciales\n• Chía: Rica en omega-3, proteínas y antioxidantes. 1 cucharada antes del ejercicio puede mantener la hidratación\n• Frijoles + maíz (tortilla): Combinación que aporta proteína completa y carbohidratos complejos\n• Nopales: Altos en fibra y antioxidantes, regulan glucosa e insulina\n• Aguacate: Grasa saludable que mejora la absorción de nutrientes y reduce inflamación\n\nIdea práctica: Prepara un batido deportivo mexicano: 1 plátano + 1 cucharada de amaranto + 1 cucharada de chía + agua de coco.",
            images: ["lib/data/img/traditional_mexican_superfoods.jpeg"],
          ),
          ArticleSection(
            title: "Suplementación: ¿Cuándo es necesaria?",
            content:
                "La COFEPRIS advierte que los suplementos no sustituyen una alimentación correcta, pero según especialistas del CAR (Centro de Alto Rendimiento) pueden ser útiles en casos específicos:\n\n• Proteína en polvo: Cuando no es posible cubrir requerimientos con alimentos\n• Creatina: Puede aumentar fuerza y potencia en ejercicios de alta intensidad\n• Electrolitos: En entrenamientos intensos >60 min o con sudoración excesiva\n\nRecuerda: Antes de tomar cualquier suplemento, consulta con un profesional de salud. La mayoría de necesidades nutricionales pueden cubrirse con alimentos naturales bien seleccionados.\n\nPara padres: Los niños y adolescentes generalmente no necesitan suplementos si siguen una dieta variada. Concéntrate en proveer alimentos reales de calidad.",
          ),
        ],
      ),
      Article(
        title: "El poder de las leguminosas en la dieta mexicana",
        description:
            "Descubre por qué los frijoles y otras legumbres son un tesoro nutricional",
        content:
            "Las leguminosas son fundamentales en la alimentación saludable mexicana.",
        imageUrl: "lib/data/img/legumbres.jpeg",
        color: Colors.brown,
        publishDate: DateTime.now().subtract(const Duration(days: 7)),
        tags: ["nutrición", "leguminosas", "tradición"],
        sections: [
          ArticleSection(
            title: "Leguminosas: El superalimento mexicano",
            content:
                "Las leguminosas como frijoles, lentejas, habas y garbanzos son parte fundamental de la dieta mexicana desde tiempos prehispánicos. El Instituto Nacional de Nutrición Salvador Zubirán destaca:\n\n• Son excelente fuente de proteína vegetal (20-25%)\n• Contienen fibra soluble e insoluble que mejora la digestión\n• Aportan hierro, zinc, magnesio y vitaminas del complejo B\n• Tienen índice glucémico bajo, ideal para control de azúcar en sangre\n\n¿Sabías que? México es uno de los principales productores de frijol en el mundo, con más de 70 variedades nativas. El consumo de frijoles se ha reducido 50% en zonas urbanas en las últimas décadas según la FAO.",
            images: ["lib/data/img/variedades_frijoles.jpeg"],
          ),
          ArticleSection(
            title: "Beneficios para la salud comprobados",
            content:
                "Investigaciones del INSP (Instituto Nacional de Salud Pública) han demostrado que el consumo regular de leguminosas:\n\n• Reduce hasta 22% el riesgo de enfermedades cardiovasculares\n• Disminuye el colesterol LDL (\"malo\") hasta en un 5%\n• Mejora el control glucémico en personas con diabetes tipo 2\n• Contribuye al mantenimiento de peso saludable gracias a su efecto saciante\n• Reduce riesgo de ciertos tipos de cáncer por su contenido de fitoquímicos\n\nPara toda la familia: Creen un \"calendario de leguminosas\" y prueben un tipo diferente cada semana. ¡Hay muchos colores y sabores por descubrir!",
          ),
          ArticleSection(
            title: "La combinación perfecta: Cereales + Leguminosas",
            content:
                "La tradicional combinación mexicana de frijoles con maíz (tortilla) no es casualidad. La Secretaría de Agricultura explica que:\n\n• Juntos forman una proteína completa con todos los aminoácidos esenciales\n• Esta combinación tiene valor nutricional similar a proteínas animales\n• Aportan energía sostenida por la fibra y carbohidratos complejos\n• Son económicamente accesibles para toda la población\n\nEjemplos de platillos completos: Enfrijoladas, tlacoyos, huaraches, sopes con frijoles, tacos de frijol con nopales.\n\nPara niños: Explícales que los frijoles y la tortilla son \"amigos inseparables\" porque juntos forman un equipo más poderoso que por separado.",
            images: ["lib/data/img/maiz_frijol_combo.jpeg"],
          ),
          ArticleSection(
            title: "Cómo incorporarlas diariamente",
            content:
                "La NOM-043-SSA2-2012 recomienda consumir leguminosas al menos 2-3 veces por semana. Ideas prácticas:\n\n• Prepara un batch semanal de frijoles y congela en porciones\n• Añade lentejas o garbanzos a ensaladas y sopas\n• Prepara hummus de garbanzo o frijol para botana con verduras\n• Agrega frijoles molidos a salsas como fuente oculta de proteína y fibra\n• Experimenta con harinas de leguminosas en panqueques o tortillas\n\nTip antiflatulentos: Remoja las legumbres secas por 8-12 horas y descarta esa agua antes de cocinar. Añade hierbas como epazote o hinojo durante la cocción para mejorar digestibilidad.",
          ),
          ArticleSection(
            title: "Leguminosas para todas las edades",
            content:
                "El DIF Nacional recomienda las leguminosas en todas las etapas de vida:\n\n• Niños: Iniciar con purés de lenteja o frijol desde los 6 meses\n• Adolescentes: Snacks como garbanzos tostados para crecimiento\n• Embarazo: Fundamentales por su aporte de ácido fólico y hierro\n• Adultos mayores: Textura suave y alta densidad nutricional\n\nEl programa gubernamental PREVENIMSS incluye las leguminosas como alimento indispensable en la orientación alimentaria para prevención de enfermedades crónicas.\n\nRecuerda: Un plato saludable mexicano debería incluir ⅓ de leguminosas o alimentos de origen animal, priorizando las primeras varias veces por semana.",
            images: ["lib/data/img/legumbres_todas_edades.jpeg"],
          ),
        ],
      ),
      Article(
        title: "Agua: El nutriente olvidado",
        description:
            "Por qué la hidratación es clave para tu salud según expertos mexicanos",
        content:
            "El agua es esencial para todas las funciones vitales del organismo.",
        imageUrl: "lib/data/img/agua_hidratacion.jpeg",
        color: Colors.lightBlue,
        publishDate: DateTime.now().subtract(const Duration(days: 10)),
        tags: ["hidratación", "salud", "agua"],
        sections: [
          ArticleSection(
            title: "La importancia vital del agua",
            content:
                "La Secretaría de Salud señala que el agua constituye entre el 50-70% de nuestro peso corporal y es esencial para:\n\n• Transportar nutrientes a las células\n• Regular la temperatura corporal\n• Eliminar toxinas y desechos\n• Lubricar articulaciones y órganos\n• Mantener funciones cognitivas óptimas\n\n¿Sabías que? Una deshidratación de solo 1-2% puede reducir tu capacidad cognitiva hasta un 10%. Según el INSP, el 70% de los escolares mexicanos llegan deshidratados a la escuela, afectando su rendimiento académico.",
            images: ["lib/data/img/importance_of_water.jpeg"],
          ),
          ArticleSection(
            title: "¿Cuánta agua necesitamos realmente?",
            content:
                "La Academia Nacional de Medicina de México recomienda:\n\n• Mujeres adultas: 2-2.2 litros diarios (9 vasos)\n• Hombres adultos: 2.5-3 litros diarios (12 vasos)\n• Niños: 1.5-2 litros según edad y peso\n• Personas activas: Adicional 0.5-1L por hora de actividad física\n\nEstas cantidades incluyen el agua contenida en alimentos (20% aprox.) y bebidas. La fórmula personalizada es: 30-35 ml por kg de peso corporal.\n\nPara niños: Usa vasos de colores o marca una botella con horarios para hacerlo divertido. Explícales que su cuerpo es como una planta que necesita agua para crecer fuerte.",
          ),
          ArticleSection(
            title: "Señales de deshidratación",
            content:
                "El IMSS advierte sobre estas señales que indican necesidad de mayor hidratación:\n\n• Sed (ya es señal de deshidratación inicial)\n• Orina oscura o de fuerte olor\n• Sequedad en boca y mucosas\n• Fatiga inexplicable\n• Dolor de cabeza\n• Mareo o aturdimiento\n• Estreñimiento\n\nEn adultos mayores: El mecanismo de la sed disminuye con la edad, por lo que requieren horarios fijos de hidratación independientemente de la sensación de sed. La deshidratación es causa frecuente de hospitalización en este grupo.",
            images: ["lib/data/img/dehydration_signs.jpg"],
          ),
          ArticleSection(
            title: "Agua y alimentación tradicional mexicana",
            content:
                "La tradición mexicana incluye formas saludables de hidratación según estudios de la UNAM:\n\n• Aguas frescas naturales: Jamaica (con antioxidantes), limón (vitamina C), tamarindo (minerales), chía (omega-3)\n• Caldos y sopas: Aportan hidratación además de nutrientes\n• Frutas con alto contenido de agua: Sandía, melón, piña, naranja\n• Verduras hidratantes: Pepino, jícama, lechuga, calabacita\n\nLa NOM-051 sobre etiquetado advierte sobre bebidas azucaradas, que pueden contener hasta 12 cucharaditas de azúcar por porción y causan deshidratación paradójica.",
          ),
          ArticleSection(
            title: "Hábitos para mejor hidratación",
            content:
                "Recomendaciones del programa gubernamental Salud para Todos:\n\n• Comenzar el día con 1-2 vasos de agua\n• Llevar siempre una botella reutilizable\n• Establecer horarios de hidratación (al despertar, entre comidas, antes de dormir)\n• Consumir frutas y verduras con alto contenido de agua\n• Limitar bebidas con cafeína o alcohol que tienen efecto diurético\n• En clima cálido o actividad física, aumentar consumo preventivamente\n\nPara toda la familia: Creen una \"estación de hidratación\" en casa con agua natural infusionada con frutas, hierbas o verduras. Ejemplos: agua con rodajas de pepino y limón; agua con hierbabuena y naranja.",
            images: ["lib/data/img/healthy_hydration_habits.jpeg"],
          ),
          ArticleSection(
            title: "Mitos y realidades sobre la hidratación",
            content:
                "La COFEPRIS desmiente algunos mitos comunes:\n\n• MITO: \"El agua engorda si se toma durante las comidas\"\nREALIDAD: El agua no contiene calorías; no puede causar aumento de peso\n\n• MITO: \"Todas las bebidas hidratan por igual\"\nREALIDAD: Bebidas con cafeína, alcohol o alto contenido de azúcar pueden causar mayor pérdida de líquidos\n\n• MITO: \"Beber agua fría quema calorías\"\nREALIDAD: El efecto termogénico es mínimo y no significativo\n\n• MITO: \"Beber mucha agua limpia/desintoxica el organismo\"\nREALIDAD: Si bien la hidratación adecuada favorece la función renal, el exceso de agua no \"limpia\" toxinas adicionales\n\nRecuerda: La cantidad y momento de hidratación debe personalizarse según edad, actividad física, clima y condiciones de salud.",
          ),
        ],
      ),
      // NUEVOS ARTÍCULOS
      Article(
        title: "El desayuno perfecto para empezar el día",
        description:
            "Cómo diseñar un desayuno nutritivo que te dé energía para toda la mañana",
        content: "El desayuno es considerado la comida más importante del día.",
        imageUrl: "lib/data/img/breakfast_healthy.jpeg",
        color: Colors.orange,
        publishDate: DateTime.now().subtract(const Duration(days: 2)),
        tags: ["desayuno", "energía", "nutrición"],
        sections: [
          ArticleSection(
            title: "¿Por qué es importante desayunar?",
            content:
                "Según la Secretaría de Salud de México, el desayuno aporta entre el 20-25% de las calorías diarias necesarias:\n\n• Rompe el ayuno nocturno de 8-12 horas\n• Activa el metabolismo para el resto del día\n• Mejora la concentración y memoria hasta un 30%\n• Previene el hambre excesiva que lleva a atracones\n• Estabiliza los niveles de glucosa en sangre\n\n¿Sabías que? Los niños que desayunan tienen mejor rendimiento académico. Según el INSP, solo el 60% de los estudiantes mexicanos desayunan antes de ir a la escuela.",
          ),
          ArticleSection(
            title: "Componentes del desayuno ideal",
            content:
                "Un desayuno balanceado según el Plato del Bien Comer debe incluir:\n\n• PROTEÍNA (¼ del plato): Huevo, frijoles, queso fresco, yogurt natural\n• CARBOHIDRATOS COMPLEJOS (¼ del plato): Tortilla, avena, pan integral, fruta\n• VERDURAS Y FRUTAS (½ del plato): Nopal, papaya, plátano, jitomate, espinaca\n• GRASAS SALUDABLES: Aguacate, nueces, semillas\n\nTip mexicano: Los chilaquiles con huevo y frijoles son un desayuno completo si se preparan con poco aceite y tortilla horneada en lugar de frita.",
          ),
          ArticleSection(
            title: "Desayunos mexicanos saludables",
            content:
                "Ideas de desayunos tradicionales adaptados a la nutrición moderna:\n\n• Huevos rancheros con salsa de jitomate casera y tortilla de maíz\n• Licuado de nopal con piña, apio y naranja\n• Molletes con frijoles, aguacate y pico de gallo (sin gratinar)\n• Quesadillas de hongos con epazote y guacamole\n• Atole de amaranto con fruta fresca\n• Enfrijoladas con queso fresco y crema de rancho (poca)\n\nPara niños: Prepara 'hot cakes de avena' mezclando avena molida, plátano machacado, huevo y canela. ¡Nutritivos y deliciosos!",
          ),
          ArticleSection(
            title: "Errores comunes en el desayuno",
            content:
                "El IMSS advierte sobre estos errores frecuentes:\n\n• Desayunar solo café o pan dulce (pico de glucosa seguido de bajón)\n• Cereales comerciales con alto contenido de azúcar (ver etiquetado frontal)\n• Jugos industrializados en lugar de fruta entera (sin fibra)\n• Saltarse el desayuno para 'ahorrar calorías' (efecto contrario)\n• Desayunos muy grasosos que causan pesadez\n\nRecuerda: Lee las etiquetas. Un cereal 'saludable' no debería tener más de 8g de azúcar por porción ni sellos de advertencia.",
          ),
          ArticleSection(
            title: "Desayunos rápidos para días ocupados",
            content:
                "Opciones para cuando tienes poco tiempo (preparación <10 min):\n\n• Overnight oats: Avena remojada en leche toda la noche con chía y fruta\n• Smoothie completo: Plátano + espinaca + proteína + leche vegetal\n• Tostada de aguacate con huevo cocido preparado desde antes\n• Yogurt griego con granola casera y fruta picada\n• Wrap de tortilla integral con frijoles y huevo revuelto\n\nMeal prep: Dedica 1 hora el domingo a preparar porciones de avena, huevos cocidos, frutas picadas y smoothies congelados para toda la semana.",
          ),
        ],
      ),
      Article(
        title: "Cómo leer etiquetas nutricionales",
        description:
            "Guía completa para entender el nuevo etiquetado frontal mexicano",
        content:
            "Entender las etiquetas te ayuda a tomar mejores decisiones alimentarias.",
        imageUrl: "lib/data/img/etiquetado_frontal.jpeg",
        color: Colors.red,
        publishDate: DateTime.now().subtract(const Duration(days: 4)),
        tags: ["etiquetado", "salud", "regulación"],
        sections: [
          ArticleSection(
            title: "El nuevo etiquetado frontal mexicano",
            content:
                "Desde octubre 2020, México implementó el sistema de etiquetado frontal más estricto del mundo según la NOM-051:\n\n• Octágonos negros de advertencia para exceso de nutrientes críticos\n• Leyendas sobre cafeína y edulcorantes para menores\n• Prohibición de personajes y promociones en productos con sellos\n\nLos 5 sellos principales:\n🔷 EXCESO CALORÍAS\n🔷 EXCESO AZÚCARES\n🔷 EXCESO GRASAS SATURADAS\n🔷 EXCESO GRASAS TRANS\n🔷 EXCESO SODIO\n\n¿Sabías que? Este etiquetado ha reducido las compras de productos ultraprocesados en un 25% según estudios del INSP.",
          ),
          ArticleSection(
            title: "Entendiendo la tabla nutricional",
            content:
                "La tabla al reverso del producto contiene información valiosa:\n\n• Tamaño de porción: Toda la información se basa en esta cantidad (no siempre es el paquete completo)\n• Calorías: Energía que aporta. Adultos promedio: 2000 kcal/día\n• Grasas: Totales, saturadas y trans. Evitar trans, limitar saturadas\n• Carbohidratos: Totales y azúcares. Distinguir entre naturales y añadidos\n• Proteína: Buscar al menos 7g por porción en alimentos proteicos\n• Sodio: Límite diario 2000mg (1 cucharadita de sal)\n• Fibra: Buscar al menos 3g por porción\n\nTip: El % de Valor Diario (VD) te dice qué tanto aporta ese producto a tu requerimiento. >20% es alto, <5% es bajo.",
          ),
          ArticleSection(
            title: "Lista de ingredientes: Lo que revela",
            content:
                "La lista de ingredientes está ordenada de mayor a menor cantidad:\n\n• Si el azúcar (o sus nombres alternativos) aparece entre los primeros 3 ingredientes, el producto tiene demasiada\n• Nombres del azúcar: jarabe de maíz, fructosa, dextrosa, maltosa, jarabe de alta fructosa, miel de maple, néctar de agave\n• Aditivos a evitar: colorantes artificiales (Rojo 40, Amarillo 5), conservadores (BHT, BHA)\n• Prefiere productos con listas cortas de ingredientes reconocibles\n\nRegla de oro: Si tu abuela no reconocería un ingrediente, probablemente tu cuerpo tampoco lo necesita.",
          ),
          ArticleSection(
            title: "Detectando publicidad engañosa",
            content:
                "La PROFECO advierte sobre frases publicitarias que pueden confundir:\n\n• \"Natural\" o \"Artesanal\": No hay regulación estricta para estos términos\n• \"Light\" o \"Bajo en grasa\": Puede tener alto azúcar como compensación\n• \"Sin azúcar añadida\": Puede contener azúcares naturales o edulcorantes\n• \"Multigrano\": No significa integral; puede ser harina refinada\n• \"Fuente de fibra\": Cantidad mínima (puede ser solo 2g)\n• \"Fortalecido con vitaminas\": No compensa un producto poco saludable\n\nEjemplo: Un yogurt 'bajo en grasa' puede tener 25g de azúcar por porción (equivalente a 5 cucharaditas).",
          ),
          ArticleSection(
            title: "Guía práctica de compras",
            content:
                "Estrategias basadas en recomendaciones del IMSS:\n\n• Comprar en el perímetro del supermercado (productos frescos)\n• Limitar productos con más de 2 sellos de advertencia\n• Comparar productos similares y elegir el de menos sellos\n• Preferir productos con lista de ingredientes corta (<10 ingredientes)\n• Revisar porciones: Un paquete puede contener 2-3 porciones\n\nPara familias: Involucra a los niños en leer etiquetas. Hagan un juego de 'detective de alimentos' buscando opciones más saludables. Esto crea hábitos de consumo informado desde temprana edad.",
          ),
        ],
      ),
      Article(
        title: "Superalimentos mexicanos que debes conocer",
        description:
            "Tesoros nutricionales de nuestra tierra respaldados por la ciencia",
        content: "México es cuna de alimentos con propiedades extraordinarias.",
        imageUrl: "lib/data/img/superfoods_mexico.jpeg",
        color: Colors.teal,
        publishDate: DateTime.now().subtract(const Duration(days: 6)),
        tags: ["superalimentos", "tradición", "nutrientes"],
        sections: [
          ArticleSection(
            title: "Amaranto: El oro de los aztecas",
            content:
                "El amaranto fue alimento sagrado para los aztecas y hoy la UNAM lo reconoce como uno de los mejores alimentos del mundo:\n\n• 16% de proteína de alta calidad (más que cualquier cereal)\n• Contiene los 9 aminoácidos esenciales (proteína completa)\n• Rico en hierro, calcio, magnesio y zinc\n• Alto en fibra (15g por 100g)\n• Sin gluten (apto para celíacos)\n\nFormas de consumirlo: Alegrías (dulce tradicional con miel), atole, palomitas de amaranto, mezclado con yogurt, en sopas, como harina para pan.\n\n¿Sabías que? La NASA considera al amaranto como alimento para misiones espaciales por su perfil nutricional completo.",
          ),
          ArticleSection(
            title: "Chía: Semillas de energía ancestral",
            content:
                "Los guerreros aztecas consumían chía para largas batallas. La ciencia moderna confirma sus beneficios:\n\n• Mayor fuente vegetal de Omega-3 (más que el salmón por gramo)\n• 40% fibra (5g por cucharada)\n• Absorbe 10 veces su peso en agua (excelente para hidratación)\n• Rica en antioxidantes que combaten el envejecimiento\n• Regula niveles de glucosa en sangre\n\nModos de uso: Agua de chía con limón, pudín de chía, en smoothies, espolvoreada en ensaladas, como sustituto de huevo en repostería (1 cda + 3 cdas agua).\n\nPrecaución: Siempre hidratar antes de consumir para evitar molestias digestivas.",
          ),
          ArticleSection(
            title: "Nopal: El cactus medicinal",
            content:
                "El nopal es símbolo de México y protagonista de nuestra bandera. Investigaciones del IPN demuestran:\n\n• Reduce glucosa en sangre hasta 17% en diabéticos\n• Alto contenido de fibra soluble (controla colesterol)\n• Propiedades antiinflamatorias comprobadas\n• Rico en vitamina A, C, K y complejo B\n• Bajo en calorías (16 kcal por 100g)\n• Contiene 17 aminoácidos\n\nFormas de consumo: Ensalada de nopalitos, licuado verde, tacos de nopal asado, con huevo, en salsa verde.\n\nTip: Para reducir la baba, corta en tiras finas y cocina con cebolla y sal hasta que esté suave.",
          ),
          ArticleSection(
            title: "Cacao: Alimento de dioses",
            content:
                "Los mayas consideraban al cacao más valioso que el oro. La UNAM ha estudiado sus propiedades:\n\n• Más antioxidantes que el té verde o vino tinto\n• Flavonoides que mejoran la circulación cerebral y memoria\n• Teobromina que mejora el ánimo (precursor de serotonina)\n• Magnesio para función muscular y nerviosa\n• Polifenoles que protegen el corazón\n\nImportante: Los beneficios son del cacao puro o chocolate oscuro (>70% cacao), no del chocolate con leche o azucarado.\n\nConsumo: Chocolate caliente con cacao puro y canela, nibs de cacao en smoothies, polvo de cacao en avena.",
          ),
          ArticleSection(
            title: "Otros tesoros mexicanos",
            content:
                "Superalimentos que merecen más reconocimiento:\n\n• AGUACATE: Grasa saludable, potasio, vitamina E. México produce el 30% mundial.\n• JITOMATE: Licopeno antioxidante (más disponible cocido), vitamina C.\n• CHILE: Capsaicina acelera metabolismo, rico en vitamina C.\n• CALABAZA (semillas): 19g proteína/100g, zinc para inmunidad.\n• PITAYA/PITAHAYA: Antioxidantes, prebióticos naturales.\n• XOCONOSTLE: Regula glucosa, protege el hígado.\n• CHAPULINES: 70% proteína, hierro, zinc (proteína del futuro).\n\nRecomendación: Incluye al menos 3 de estos superalimentos mexicanos en tu dieta semanal para aprovechar nuestra biodiversidad nutricional.",
          ),
        ],
      ),
      Article(
        title: "Alimentación para un sueño reparador",
        description:
            "Cómo lo que comes afecta la calidad de tu descanso nocturno",
        content: "La nutrición y el sueño están íntimamente conectados.",
        imageUrl: "lib/data/img/sleep_nutrition.jpeg",
        color: Colors.indigo,
        publishDate: DateTime.now().subtract(const Duration(days: 8)),
        tags: ["sueño", "descanso", "nutrición"],
        sections: [
          ArticleSection(
            title: "La conexión alimentación-sueño",
            content:
                "El IMSS reporta que el 45% de los mexicanos tiene problemas de sueño. La alimentación juega un rol crucial:\n\n• El intestino produce el 95% de la serotonina corporal (precursor de melatonina)\n• Comidas pesadas antes de dormir dificultan el sueño profundo\n• La deficiencia de ciertos nutrientes causa insomnio\n• El horario de comidas afecta el ritmo circadiano\n\nDato importante: Dormir menos de 7 horas aumenta el hambre y antojos al día siguiente por alteración de hormonas (grelina y leptina), creando un ciclo vicioso.",
          ),
          ArticleSection(
            title: "Alimentos que favorecen el sueño",
            content:
                "Alimentos ricos en triptófano, magnesio y melatonina natural:\n\n• PLÁTANO: Rico en magnesio, potasio y triptófano\n• LECHE TIBIA: Contiene triptófano y calcio (mito con base real)\n• CEREZA: Una de las pocas fuentes naturales de melatonina\n• AVENA: Carbohidrato complejo que facilita entrada de triptófano al cerebro\n• ALMENDRAS/NUECES: Magnesio y melatonina\n• PAVO/POLLO: Alto contenido de triptófano\n• KIWI: Estudios muestran que 2 kiwis antes de dormir mejoran el sueño\n\nCena ideal: Proteína magra + carbohidrato complejo + vegetales. Ejemplo: Pechuga con arroz integral y verduras al vapor.",
          ),
          ArticleSection(
            title: "Alimentos que dificultan el sueño",
            content:
                "Evitar especialmente 3-4 horas antes de dormir:\n\n• CAFEÍNA: En café, té, chocolate, refrescos de cola. Efecto dura 6-8 horas.\n• ALCOHOL: Aunque da somnolencia inicial, fragmenta el sueño profundo.\n• COMIDAS MUY CONDIMENTADAS: Pueden causar acidez y reflujo.\n• COMIDAS GRASOSAS: Digestión lenta que interrumpe el descanso.\n• AZÚCAR: Picos de glucosa causan despertares nocturnos.\n• EXCESO DE LÍQUIDOS: Interrupciones para ir al baño.\n\nTip: Si tomas café, que sea antes del mediodía. La vida media de la cafeína es de 5-6 horas.",
          ),
          ArticleSection(
            title: "Cena perfecta para dormir bien",
            content:
                "Recomendaciones del Instituto de Nutrición y Salud:\n\n• Cenar 2-3 horas antes de acostarse\n• Porción moderada (no más del 25% de calorías diarias)\n• Incluir carbohidrato complejo para facilitar entrada de triptófano\n• Evitar exceso de proteína animal (difícil digestión)\n• Preferir preparaciones ligeras: al vapor, hervido, asado\n\nMenú sugerido:\n- Sopa de verduras con pollo desmenuzado\n- Quesadilla de champiñones con aguacate\n- Avena caliente con plátano y canela\n- Ensalada tibia con huevo y vegetales",
          ),
          ArticleSection(
            title: "Suplementos naturales para el sueño",
            content:
                "Si después de mejorar la alimentación persisten problemas, consulta a tu médico sobre:\n\n• MELATONINA: Hormona natural del sueño (1-3mg antes de dormir)\n• MAGNESIO: Relaja músculos y sistema nervioso (200-400mg)\n• VALERIANA: Hierba tradicional para insomnio\n• PASIFLORA: Reduce ansiedad que impide dormir\n• TÉ DE MANZANILLA: Efecto calmante suave\n\nRecuerda: Los suplementos no sustituyen buenos hábitos. Primero optimiza tu alimentación y rutina de sueño (misma hora de dormir, cuarto oscuro, sin pantallas 1 hora antes).\n\nPara niños: Evitar azúcar y pantallas después de las 6pm. Una rutina de cena tranquila favorece el sueño infantil.",
          ),
        ],
      ),
      Article(
        title: "Nutrición durante el embarazo",
        description:
            "Guía completa de alimentación para mamás embarazadas según la NOM mexicana",
        content:
            "La nutrición durante el embarazo es fundamental para la salud de madre e hijo.",
        imageUrl: "lib/data/img/pregnancy_nutrition.jpeg",
        color: Colors.pink,
        publishDate: DateTime.now().subtract(const Duration(days: 12)),
        tags: ["embarazo", "maternidad", "nutrición"],
        sections: [
          ArticleSection(
            title: "Necesidades nutricionales especiales",
            content:
                "La NOM-007-SSA2 establece los requerimientos durante el embarazo:\n\n• Calorías: +300 kcal/día en 2do-3er trimestre (no comer por dos)\n• Proteína: 1.1g/kg de peso (aumento de 25g/día)\n• Ácido fólico: 600mcg/día (previene defectos del tubo neural)\n• Hierro: 27mg/día (previene anemia)\n• Calcio: 1000mg/día (huesos del bebé y de la madre)\n• Omega-3: 200-300mg DHA/día (desarrollo cerebral)\n\n¿Sabías que? El 50% de las mujeres mexicanas inician el embarazo con deficiencia de ácido fólico, según el INSP.",
          ),
          ArticleSection(
            title: "Alimentos esenciales por trimestre",
            content:
                "PRIMER TRIMESTRE (Sem 1-12):\n• Prioridad: Ácido fólico (espinaca, frijoles, hígado, fortified cereals)\n• Manejo de náuseas: Comidas pequeñas y frecuentes, galletas integrales\n• Hidratación constante\n\nSEGUNDO TRIMESTRE (Sem 13-26):\n• Aumentar proteína y calcio para crecimiento acelerado\n• Hierro de fuentes animales (mejor absorción) y vegetales\n• Omega-3 de pescado bajo en mercurio (salmón, sardina)\n\nTERCER TRIMESTRE (Sem 27-40):\n• Carbohidratos complejos para energía del parto\n• Fibra para evitar estreñimiento común\n• Comidas pequeñas por espacio reducido",
          ),
          ArticleSection(
            title: "Alimentos a evitar durante el embarazo",
            content:
                "La COFEPRIS y SSA recomiendan evitar:\n\n• PESCADOS ALTOS EN MERCURIO: Tiburón, pez espada, marlín, atún rojo\n• LÁCTEOS NO PASTEURIZADOS: Quesos frescos artesanales sin pasteurizar\n• CARNES Y MARISCOS CRUDOS: Sushi, ceviche, carpaccio, ostiones\n• HUEVO CRUDO O MAL COCIDO: Mayonesa casera, merengue crudo\n• EMBUTIDOS Y PATÉS: Por riesgo de listeria\n• ALCOHOL: Ninguna cantidad es segura durante el embarazo\n• EXCESO DE CAFEÍNA: Máximo 200mg/día (1 taza de café)\n\nImportante: Lavar muy bien frutas y verduras. Evitar germinados crudos por riesgo bacteriano.",
          ),
          ArticleSection(
            title: "Menús saludables para embarazadas",
            content:
                "Ideas de comidas balanceadas con sabor mexicano:\n\nDESAYUNO:\n• Licuado de mango con espinaca, leche y avena\n• Huevos revueltos con nopales y tortilla de maíz\n\nCOMIDA:\n• Caldo tlalpeño con pollo, verduras y aguacate\n• Tacos de frijol con queso Oaxaca y salsa verde\n\nCENA:\n• Salmón al horno con verduras y arroz integral\n• Quesadillas de flor de calabaza con frijoles\n\nCOLACIONES:\n• Jícama con limón y chile\n• Yogurt con granola y fruta\n• Almendras y fruta deshidratada",
          ),
          ArticleSection(
            title: "Control de peso saludable",
            content:
                "Aumento de peso recomendado según IMC previo (NOM-007):\n\n• IMC <18.5 (bajo peso): 12.5-18 kg\n• IMC 18.5-24.9 (normal): 11.5-16 kg\n• IMC 25-29.9 (sobrepeso): 7-11.5 kg\n• IMC >30 (obesidad): 5-9 kg\n\nConsejos:\n• No hacer dietas restrictivas durante el embarazo\n• Enfocarse en calidad sobre cantidad\n• Actividad física moderada (30 min/día si no hay contraindicación)\n• Control prenatal mensual para monitorear peso\n\nRecuerda: El peso ganado incluye: bebé (3-4kg), placenta, líquido amniótico, aumento de sangre, reservas de grasa para lactancia.",
          ),
        ],
      ),
      Article(
        title: "Combatiendo la diabetes con alimentación",
        description:
            "Estrategias nutricionales para prevenir y controlar la diabetes tipo 2",
        content:
            "La alimentación es clave en la prevención y control de la diabetes.",
        imageUrl: "lib/data/img/diabetes_control.jpeg",
        color: Colors.purple,
        publishDate: DateTime.now().subtract(const Duration(days: 14)),
        tags: ["diabetes", "salud", "prevención"],
        sections: [
          ArticleSection(
            title: "La epidemia de diabetes en México",
            content:
                "México ocupa el 6to lugar mundial en diabetes según la Federación Internacional de Diabetes:\n\n• 14.1 millones de mexicanos viven con diabetes (14% de adultos)\n• 50% no saben que la tienen (prediabetes silenciosa)\n• Es la 2da causa de muerte en el país\n• Costo anual por paciente: \$12,000-\$15,000 USD\n\nFactores de riesgo:\n• Sobrepeso u obesidad (75% de mexicanos)\n• Sedentarismo\n• Antecedentes familiares\n• Edad >45 años\n• Síndrome de ovario poliquístico\n• Diabetes gestacional previa\n\nBuena noticia: La diabetes tipo 2 es prevenible en hasta el 58% de los casos con cambios de estilo de vida.",
          ),
          ArticleSection(
            title: "El índice glucémico: Tu aliado",
            content:
                "El índice glucémico (IG) mide qué tan rápido un alimento eleva la glucosa:\n\n• IG BAJO (<55): Preferir siempre\n  - Leguminosas, vegetales sin almidón, frutas enteras\n  - Pan integral, avena, pasta al dente\n\n• IG MEDIO (56-69): Consumo moderado\n  - Arroz integral, plátano maduro, miel\n\n• IG ALTO (>70): Evitar o minimizar\n  - Pan blanco, arroz blanco, papa, sandía\n  - Cereales de caja, bebidas azucaradas\n\nTruco: La fibra, proteína y grasa reducen el IG de una comida. Acompañar carbohidratos con estos elementos.",
          ),
          ArticleSection(
            title: "Plato ideal para diabéticos",
            content:
                "El método del plato recomendado por la ADA (Asociación Americana de Diabetes):\n\n• ½ PLATO: Vegetales sin almidón (brócoli, espinaca, nopal, jitomate, pepino, chayote)\n• ¼ PLATO: Proteína magra (pollo, pescado, huevo, frijoles, tofu)\n• ¼ PLATO: Carbohidrato de IG bajo (tortilla, arroz integral, camote)\n• + Bebida sin calorías (agua, té sin azúcar)\n\nPorciones aproximadas:\n• Proteína: Tamaño de la palma de tu mano\n• Carbohidratos: Puño cerrado\n• Grasas saludables: Pulgar (aceite, aguacate, nueces)",
          ),
          ArticleSection(
            title: "Alimentos estrella para diabéticos",
            content:
                "Investigaciones del INCMNSZ (Instituto Nacional de Nutrición) destacan:\n\n• NOPAL: Reduce glucosa postprandial hasta 17%. Consumir diariamente.\n• CANELA: Media cucharadita mejora sensibilidad a insulina.\n• VINAGRE: 2 cdas antes de comida reducen pico de glucosa.\n• FRIJOLES: Fibra soluble que estabiliza azúcar en sangre.\n• AGUACATE: Grasas que no elevan glucosa y dan saciedad.\n• NUECES: Reducen riesgo cardiovascular asociado a diabetes.\n• JITOMATE: Licopeno mejora sensibilidad a la insulina.\n\nSuplemento útil: Omega-3 reduce triglicéridos frecuentemente elevados en diabetes.",
          ),
          ArticleSection(
            title: "Plan de acción preventivo",
            content:
                "Estrategias respaldadas por el programa PREVENIMSS:\n\n• Perder 5-7% del peso si hay sobrepeso (reduce riesgo 58%)\n• 150 minutos semanales de actividad física moderada\n• Reducir azúcares añadidas a <25g/día (5 cucharaditas)\n• Limitar bebidas azucaradas (mayor factor de riesgo dietético)\n• Consumir fibra: 25-30g diarios\n• Comer a horarios regulares (no saltarse comidas)\n• Monitorear glucosa si hay antecedentes familiares\n\nRecuerda: La prediabetes es reversible. Si tu glucosa en ayunas está entre 100-125 mg/dL, los cambios de estilo de vida pueden evitar que progrese a diabetes.",
          ),
        ],
      ),
      Article(
        title: "Alimentación para adultos mayores",
        description:
            "Necesidades nutricionales especiales después de los 60 años",
        content: "La nutrición en adultos mayores requiere atención especial.",
        imageUrl: "lib/data/img/senior_nutrition.jpeg",
        color: Colors.amber,
        publishDate: DateTime.now().subtract(const Duration(days: 16)),
        tags: ["adultos mayores", "envejecimiento", "nutrición"],
        sections: [
          ArticleSection(
            title: "Cambios nutricionales con la edad",
            content:
                "El INGER (Instituto Nacional de Geriatría) explica que después de los 60:\n\n• El metabolismo disminuye 2-3% por década\n• Reducción de masa muscular (sarcopenia)\n• Menor absorción de vitamina B12, calcio y vitamina D\n• Disminución del sentido del gusto y olfato\n• Menor sensación de sed (riesgo de deshidratación)\n• Cambios en la dentición que afectan masticación\n\n¿Sabías que? El 25% de los adultos mayores mexicanos tienen desnutrición, mientras que otro 25% tiene sobrepeso. Ambos extremos son problemáticos.",
          ),
          ArticleSection(
            title: "Nutrientes prioritarios después de los 60",
            content:
                "La NOM-043 destaca estos nutrientes esenciales:\n\n• PROTEÍNA: 1.0-1.2g/kg para mantener masa muscular\n• CALCIO: 1200mg/día (prevención de osteoporosis)\n• VITAMINA D: 800-1000 UI (sol 15 min + suplemento si necesario)\n• VITAMINA B12: Suplemento o alimentos fortificados (absorción reducida)\n• FIBRA: 25-30g para evitar estreñimiento común\n• OMEGA-3: Protección cardiovascular y cognitiva\n• ZINC: Inmunidad y cicatrización (frecuentemente deficiente)\n\nTip: La exposición solar de 15-20 minutos antes de las 10am o después de las 4pm ayuda a sintetizar vitamina D.",
          ),
          ArticleSection(
            title: "Estrategias para comer mejor",
            content:
                "Recomendaciones del DIF para adultos mayores:\n\n• Hacer 5-6 comidas pequeñas si hay poco apetito\n• Priorizar alimentos densos en nutrientes\n• Usar hierbas y especias para compensar menor gusto\n• Preferir texturas suaves si hay problemas dentales\n• Socializar durante las comidas (comer acompañado mejora la ingesta)\n• Tomar líquidos con horario establecido (no esperar a tener sed)\n\nIdeas de preparaciones:\n• Licuados nutritivos con frutas, avena y proteína\n• Sopas cremosas con verduras y pollo\n• Frijoles molidos (más fáciles de digerir)\n• Huevos en diferentes preparaciones",
          ),
          ArticleSection(
            title: "Alimentos para mantener la mente activa",
            content:
                "Estudios del Instituto de Neurología muestran que ciertos alimentos protegen la función cognitiva:\n\n• PESCADOS GRASOS: Salmón, sardina, caballa (Omega-3 para cerebro)\n• FRUTOS ROJOS: Arándanos, fresas, moras (antioxidantes protectores)\n• VEGETALES DE HOJA VERDE: Espinaca, acelga (folato y vitamina K)\n• NUECES: Especialmente las de Castilla (vitamina E y omega-3)\n• ACEITE DE OLIVA: Grasas monoinsaturadas antiinflamatorias\n• CÚRCUMA: Curcumina con propiedades neuroprotectoras\n\nLa dieta MIND (combinación de mediterránea y DASH) reduce el riesgo de Alzheimer hasta en un 53% cuando se sigue estrictamente.",
          ),
          ArticleSection(
            title: "Menú ejemplo para adultos mayores",
            content:
                "Menú de un día completo (aprox. 1800 kcal):\n\nDESAYUNO:\n• Avena con leche, nueces y plátano\n• Té de manzanilla\n\nCOLACIÓN:\n• Yogurt griego con miel y semillas\n\nCOMIDA:\n• Caldo de pollo con verduras y arroz\n• Tortilla de maíz\n• Agua de jamaica sin azúcar\n\nCOLACIÓN:\n• Fruta picada (papaya, melón)\n\nCENA:\n• Quesadilla de flor de calabaza\n• Frijoles de olla\n• Té de hierbas\n\nAntes de dormir:\n• Vaso de leche tibia con canela\n\nRecuerda: Consultar al médico sobre necesidad de suplementos, especialmente vitamina D, B12 y calcio.",
          ),
        ],
      ),
      Article(
        title: "Nutrición para niños en edad escolar",
        description:
            "Cómo alimentar correctamente a tus hijos para un óptimo desarrollo",
        content:
            "La alimentación en la infancia sienta las bases para toda la vida.",
        imageUrl: "lib/data/img/kids_nutrition.jpeg",
        color: Colors.cyan,
        publishDate: DateTime.now().subtract(const Duration(days: 18)),
        tags: ["niños", "crecimiento", "escolares"],
        sections: [
          ArticleSection(
            title: "Necesidades nutricionales infantiles",
            content:
                "La NOM-043 y el Sistema DIF establecen estos requerimientos:\n\n• CALORÍAS: 1400-2000 kcal/día según edad y actividad\n• PROTEÍNA: 0.95g/kg de peso para crecimiento\n• CALCIO: 1000mg (3 porciones de lácteos o equivalentes)\n• HIERRO: 10mg/día (previene anemia que afecta al 20% de niños)\n• VITAMINA A: Para visión y sistema inmune\n• FIBRA: Edad + 5g (ej: niño de 8 años = 13g)\n\nPreocupación nacional: El 35% de niños mexicanos tiene sobrepeso u obesidad, y el consumo de frutas y verduras es 70% menor al recomendado.",
          ),
          ArticleSection(
            title: "El lunch escolar perfecto",
            content:
                "Un lunch equilibrado según la SEP debe incluir:\n\n• PROTEÍNA: Pollo desmenuzado, huevo, queso, frijoles\n• CARBOHIDRATO: Pan integral, tortilla, galletas integrales\n• FRUTA/VERDURA: Entera o picada, fácil de comer\n• AGUA NATURAL: Evitar jugos y bebidas azucaradas\n\nIdeas de lunch:\n• Rollito de jamón de pavo con queso y aguacate + uvas + agua\n• Quesadilla de frijol + jícama con limón + agua de jamaica\n• Sándwich de pollo con lechuga + manzana + agua\n• Wrap de hummus con verduras + fresas + agua\n\nTip: Involucra a los niños en preparar su lunch. Lo que ellos preparan, lo comen con más gusto.",
          ),
          ArticleSection(
            title: "Cómo manejar a niños selectivos con la comida",
            content:
                "Estrategias respaldadas por psicólogos del IMSS:\n\n• Ofrecer el mismo alimento hasta 15 veces antes de asumir que no le gusta\n• Dar el ejemplo: Los niños imitan a los adultos\n• No usar comida como premio o castigo\n• Involucrar a los niños en la compra y preparación\n• Presentar alimentos de forma divertida (caritas, figuras)\n• No forzar a terminar el plato (respeta señales de saciedad)\n• Ofrecer opciones limitadas (¿quieres brócoli o zanahoria?)\n\nPatrón normal: Es común que niños de 2-6 años sean selectivos. Generalmente mejora con el tiempo si no se presiona excesivamente.",
          ),
          ArticleSection(
            title: "Alimentos a limitar en niños",
            content:
                "La COFEPRIS y SSA recomiendan restringir:\n\n• BEBIDAS AZUCARADAS: Principal fuente de azúcar añadida\n• COMIDA RÁPIDA: Máximo 1 vez por semana\n• DULCES Y GOLOSINAS: Ocasionalmente, no diariamente\n• PRODUCTOS CON SELLOS: Limitar especialmente si tienen 2+ sellos\n• FRITURAS DE BOLSA: Altas en sodio y grasas trans\n\nDatos alarmantes: Un niño mexicano promedio consume:\n- 40 litros de refresco al año\n- El doble de azúcar recomendada\n- Solo 34% de las verduras necesarias\n\nAlternativas: Fruta congelada en paleta casera, palomitas hechas en casa, agua de frutas natural, chips de manzana o plátano deshidratados.",
          ),
          ArticleSection(
            title: "Fomentando hábitos saludables",
            content:
                "Estrategias para crear una relación sana con la comida:\n\n• Comer en familia sin distracciones (TV, celulares)\n• Establecer horarios regulares de comidas\n• Cocinar juntos al menos una vez por semana\n• Cultivar un pequeño huerto (aunque sea en macetas)\n• Leer etiquetas juntos en el supermercado\n• Celebrar con actividades, no solo con comida\n• Hablar positivamente sobre los alimentos (no 'esto es malo')\n\nRecuerda: Los hábitos alimentarios se forman en la infancia. Un niño que come bien tiene mayor probabilidad de ser un adulto que come bien.\n\nPara padres: No etiqueten alimentos como 'buenos' o 'malos', sino como 'para comer todos los días' o 'para ocasiones especiales'.",
          ),
        ],
      ),
    ];
  }
}
