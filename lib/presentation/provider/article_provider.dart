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
    ];
  }
}
