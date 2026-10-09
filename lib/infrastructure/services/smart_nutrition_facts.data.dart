import 'package:flutter/material.dart';

import 'smart_nutrition_models.dart';

/// Datos curiosos sobre alimentos.
List<FoodFact> buildFoodFacts() {
  return const [
    // ============ FRUTAS ============
    FoodFact(
      title: 'Aguacate: La fruta del corazón',
      fact:
          'El aguacate contiene más potasio que el plátano y es rico en grasas monoinsaturadas que ayudan a reducir el colesterol malo. México produce el 30% del aguacate mundial.',
      icon: Icons.favorite,
      color: Colors.green,
      source: 'SAGARPA México',
    ),
    FoodFact(
      title: 'Plátano: Energía instantánea',
      fact:
          'Un plátano mediano proporciona aproximadamente 105 calorías y es una excelente fuente de vitamina B6, esencial para el metabolismo. Los atletas lo prefieren antes de competir.',
      icon: Icons.bolt,
      color: Colors.yellow,
      source: 'USDA',
    ),
    FoodFact(
      title: 'Manzana: El cepillo natural',
      fact:
          'Comer una manzana estimula la producción de saliva, reduciendo las bacterias bucales. Contiene pectina, una fibra que alimenta las bacterias buenas del intestino.',
      icon: Icons.apple,
      color: Colors.red,
      source: 'Journal of Dental Research',
    ),
    FoodFact(
      title: 'Limón: Vitamina C concentrada',
      fact:
          'Un limón contiene aproximadamente el 51% de la vitamina C diaria recomendada. Los marineros británicos comían cítricos para prevenir el escorbuto, de ahí el apodo "limeys".',
      icon: Icons.local_drink,
      color: Colors.amber,
      source: 'Historia de la nutrición',
    ),
    FoodFact(
      title: 'Papaya: Digestión natural',
      fact:
          'La papaya contiene papaína, una enzima que ayuda a digerir las proteínas. Una taza aporta el 224% de la vitamina C diaria. México es el 5to productor mundial.',
      icon: Icons.spa,
      color: Colors.orange,
      source: 'FAO',
    ),
    FoodFact(
      title: 'Mango: Rey de las frutas',
      fact:
          'El mango es la fruta nacional de India, Pakistán y Filipinas. Un mango mediano contiene 3g de fibra y el 100% de la vitamina C diaria. México es el principal exportador.',
      icon: Icons.local_florist,
      color: Colors.orange,
      source: 'SAGARPA',
    ),
    FoodFact(
      title: 'Sandía: Hidratación natural',
      fact:
          'La sandía es 92% agua, perfecta para hidratarse. Contiene licopeno (más que el jitomate) y citrulina, un aminoácido que mejora el flujo sanguíneo.',
      icon: Icons.water_drop,
      color: Colors.red,
      source: 'Journal of Agricultural and Food Chemistry',
    ),
    FoodFact(
      title: 'Piña: Antiinflamatorio natural',
      fact:
          'La piña contiene bromelina, una enzima con propiedades antiinflamatorias usada en suplementos deportivos. También ayuda a ablandar carnes cuando se usa como marinada.',
      icon: Icons.local_florist,
      color: Colors.yellow,
      source: 'NCBI',
    ),
    FoodFact(
      title: 'Guayaba: Campeona de vitamina C',
      fact:
          'La guayaba contiene 4 veces más vitamina C que la naranja. Una sola guayaba aporta el 628% de tu requerimiento diario de esta vitamina.',
      icon: Icons.emoji_nature,
      color: Colors.pink,
      source: 'USDA',
    ),
    FoodFact(
      title: 'Naranja: Más que vitamina C',
      fact:
          'Además de vitamina C, las naranjas contienen hesperidina, un flavonoide que mejora la circulación sanguínea y reduce la presión arterial.',
      icon: Icons.brightness_5,
      color: Colors.orange,
      source: 'American Heart Association',
    ),
    FoodFact(
      title: 'Fresas: Antioxidantes rojos',
      fact:
          'Las fresas tienen más vitamina C que las naranjas por porción. Su color rojo viene de antocianinas, potentes antioxidantes que protegen el corazón.',
      icon: Icons.favorite_border,
      color: Colors.red,
      source: 'Journal of Nutrition',
    ),
    FoodFact(
      title: 'Kiwi: Pequeño pero poderoso',
      fact:
          'El kiwi tiene más vitamina C que la naranja y más potasio que el plátano. Estudios muestran que comer 2 kiwis antes de dormir mejora la calidad del sueño.',
      icon: Icons.nights_stay,
      color: Colors.green,
      source: 'Asia Pacific Journal of Clinical Nutrition',
    ),

    // ============ VERDURAS ============
    FoodFact(
      title: 'Espinaca: El secreto de Popeye',
      fact:
          'La espinaca es rica en hierro, pero también contiene oxalatos que pueden inhibir su absorción. Combínala con vitamina C (limón) para maximizar beneficios.',
      icon: Icons.eco,
      color: Colors.green,
      source: 'INSP México',
    ),
    FoodFact(
      title: 'Zanahoria: Visión nocturna',
      fact:
          'Las zanahorias son ricas en beta-caroteno, que el cuerpo convierte en vitamina A. Esta vitamina es esencial para la visión, especialmente en condiciones de poca luz.',
      icon: Icons.visibility,
      color: Colors.orange,
      source: 'American Optometric Association',
    ),
    FoodFact(
      title: 'Brócoli: El superalimento',
      fact:
          'El brócoli contiene sulforafano, un compuesto con propiedades anticancerígenas. Cocerlo al vapor por 3-4 minutos maximiza estos beneficios sin destruir los nutrientes.',
      icon: Icons.spa,
      color: Colors.green,
      source: 'Journal of Cancer Prevention',
    ),
    FoodFact(
      title: 'Nopal: Tesoro mexicano',
      fact:
          'El nopal es bajo en calorías (16 kcal/100g), alto en fibra y estudios del IPN demuestran que ayuda a controlar la glucosa en diabéticos hasta en un 17%.',
      icon: Icons.local_florist,
      color: Colors.green,
      source: 'Instituto Politécnico Nacional',
    ),
    FoodFact(
      title: 'Jitomate: Licopeno poderoso',
      fact:
          'El jitomate cocido tiene más licopeno disponible que el crudo. Este antioxidante reduce el riesgo de cáncer de próstata y enfermedades cardiovasculares.',
      icon: Icons.brightness_1,
      color: Colors.red,
      source: 'Harvard Health',
    ),
    FoodFact(
      title: 'Ajo: Antibiótico natural',
      fact:
          'El ajo contiene alicina, un compuesto con propiedades antibacterianas y antivirales. Machacar el ajo y dejarlo reposar 10 min maximiza sus beneficios.',
      icon: Icons.healing,
      color: Colors.white,
      source: 'Journal of Antimicrobial Chemotherapy',
    ),
    FoodFact(
      title: 'Cebolla: Prebiótico natural',
      fact:
          'Las cebollas contienen inulina, un prebiótico que alimenta las bacterias buenas del intestino. También contienen quercetina, un antiinflamatorio natural.',
      icon: Icons.circle_outlined,
      color: Colors.purple,
      source: 'Gut Microbes Journal',
    ),
    FoodFact(
      title: 'Calabaza: Versatilidad nutritiva',
      fact:
          'Las semillas de calabaza (pepitas) contienen 19g de proteína por 100g y son ricas en zinc, esencial para el sistema inmune. Un snack perfecto.',
      icon: Icons.circle,
      color: Colors.orange,
      source: 'USDA',
    ),
    FoodFact(
      title: 'Chayote: El vegetal olvidado',
      fact:
          'El chayote es 95% agua, tiene solo 19 calorías por 100g y es rico en folato. Originario de México, su nombre viene del náhuatl "chayotli".',
      icon: Icons.grass,
      color: Colors.lightGreen,
      source: 'UNAM',
    ),
    FoodFact(
      title: 'Betabel: Rendimiento deportivo',
      fact:
          'El betabel es rico en nitratos que el cuerpo convierte en óxido nítrico, mejorando el flujo sanguíneo. Los atletas lo usan para mejorar rendimiento hasta un 3%.',
      icon: Icons.sports,
      color: Colors.purple,
      source: 'Journal of Applied Physiology',
    ),
    FoodFact(
      title: 'Apio: Calorías negativas',
      fact:
          'El apio tiene tan pocas calorías (6 kcal/tallo) que la energía para masticarlo y digerirlo es similar a lo que aporta. Es 95% agua y rico en vitamina K.',
      icon: Icons.grass,
      color: Colors.lightGreen,
      source: 'USDA',
    ),

    // ============ PROTEÍNAS ============
    FoodFact(
      title: 'Huevo: Proteína completa',
      fact:
          'El huevo es uno de los pocos alimentos que contiene todos los aminoácidos esenciales. La yema contiene colina, vital para el cerebro y la memoria.',
      icon: Icons.egg,
      color: Colors.amber,
      source: 'American Journal of Clinical Nutrition',
    ),
    FoodFact(
      title: 'Salmón: Omega-3 natural',
      fact:
          'El salmón es una de las mejores fuentes de ácidos grasos omega-3, que reducen la inflamación y apoyan la salud cardiovascular y cerebral.',
      icon: Icons.water,
      color: Colors.pink,
      source: 'American Heart Association',
    ),
    FoodFact(
      title: 'Frijoles: Proteína vegetal',
      fact:
          'Los frijoles negros contienen hasta 15g de proteína por taza y son ricos en antocianinas, los mismos antioxidantes de los arándanos.',
      icon: Icons.circle,
      color: Colors.brown,
      source: 'INSP México',
    ),
    FoodFact(
      title: 'Pollo: Proteína magra eficiente',
      fact:
          '100g de pechuga de pollo aportan 31g de proteína con solo 3g de grasa. Es la proteína favorita de los atletas por su relación proteína/grasa.',
      icon: Icons.restaurant,
      color: Colors.amber,
      source: 'USDA',
    ),
    FoodFact(
      title: 'Atún: Economía proteica',
      fact:
          'El atún en lata es una de las fuentes más económicas de proteína de alta calidad. 100g aportan 26g de proteína y solo 1g de grasa.',
      icon: Icons.waves,
      color: Colors.blue,
      source: 'FDA',
    ),
    FoodFact(
      title: 'Lentejas: Hierro vegetal',
      fact:
          'Las lentejas contienen más hierro que la carne de res por porción (6.6mg vs 2.6mg por 100g). Combínalas con vitamina C para mejor absorción.',
      icon: Icons.brightness_1,
      color: Colors.brown,
      source: 'USDA',
    ),
    FoodFact(
      title: 'Yogurt griego: Probióticos vivos',
      fact:
          'El yogurt griego tiene el doble de proteína que el regular (17g vs 8g por porción) y contiene probióticos que mejoran la salud digestiva.',
      icon: Icons.breakfast_dining,
      color: Colors.white,
      source: 'Journal of Dairy Science',
    ),

    // ============ CEREALES ============
    FoodFact(
      title: 'Avena: Fibra soluble',
      fact:
          'La avena contiene beta-glucano, una fibra soluble que puede reducir el colesterol LDL hasta en un 10% cuando se consumen 3g diarios.',
      icon: Icons.grain,
      color: Colors.brown,
      source: 'FDA (Health Claim)',
    ),
    FoodFact(
      title: 'Quinoa: El grano dorado',
      fact:
          'La quinoa es uno de los pocos granos que es una proteína completa con los 9 aminoácidos esenciales. Fue considerada sagrada por los Incas.',
      icon: Icons.grass,
      color: Colors.amber,
      source: 'FAO',
    ),
    FoodFact(
      title: 'Tortilla de maíz nixtamalizada',
      fact:
          'El proceso de nixtamalización aumenta la biodisponibilidad de niacina y calcio en el maíz, previniendo la pelagra. Una tortilla aporta 60mg de calcio.',
      icon: Icons.breakfast_dining,
      color: Colors.yellow,
      source: 'UNAM',
    ),
    FoodFact(
      title: 'Amaranto: Superfood ancestral',
      fact:
          'El amaranto tiene más proteína que el arroz y el maíz (16% vs 7%), fue sagrado para los aztecas y la NASA lo considera ideal para misiones espaciales.',
      icon: Icons.stars,
      color: Colors.purple,
      source: 'NASA/UNAM',
    ),
    FoodFact(
      title: 'Arroz integral: Fibra y magnesio',
      fact:
          'El arroz integral conserva la cáscara (salvado) que contiene fibra, magnesio y vitaminas B. El arroz blanco pierde el 67% de estos nutrientes.',
      icon: Icons.grass,
      color: Colors.brown,
      source: 'Whole Grains Council',
    ),

    // ============ ESPECIAS Y OTROS ============
    FoodFact(
      title: 'Chile: Capsaicina benéfica',
      fact:
          'La capsaicina del chile puede acelerar el metabolismo hasta un 8% y tiene propiedades analgésicas naturales. México tiene más de 60 variedades de chiles.',
      icon: Icons.local_fire_department,
      color: Colors.red,
      source: 'Journal of Nutritional Science',
    ),
    FoodFact(
      title: 'Canela: Regulador de glucosa',
      fact:
          'Medio gramo de canela al día puede mejorar la sensibilidad a la insulina. Los compuestos de la canela imitan la insulina a nivel celular.',
      icon: Icons.spa,
      color: Colors.brown,
      source: 'Diabetes Care Journal',
    ),
    FoodFact(
      title: 'Cúrcuma: Antiinflamatorio milenario',
      fact:
          'La curcumina de la cúrcuma es un potente antiinflamatorio. Combínala con pimienta negra (piperina) para aumentar su absorción en un 2000%.',
      icon: Icons.local_florist,
      color: Colors.orange,
      source: 'Journal of Medicinal Food',
    ),
    FoodFact(
      title: 'Jengibre: Alivio natural',
      fact:
          'El jengibre es tan efectivo como algunos medicamentos para las náuseas. También tiene propiedades antiinflamatorias comparables al ibuprofeno.',
      icon: Icons.healing,
      color: Colors.amber,
      source: 'Journal of Pain',
    ),
    FoodFact(
      title: 'Miel: Antibacteriano natural',
      fact:
          'La miel tiene propiedades antibacterianas naturales y nunca se echa a perder. Se ha encontrado miel comestible en tumbas egipcias de 3000 años.',
      icon: Icons.emoji_nature,
      color: Colors.amber,
      source: 'Journal of Food Science',
    ),
    FoodFact(
      title: 'Chocolate oscuro: Placer saludable',
      fact:
          'El chocolate con >70% cacao tiene más antioxidantes que el té verde. Los flavonoides del cacao mejoran el flujo sanguíneo cerebral y la memoria.',
      icon: Icons.favorite,
      color: Colors.brown,
      source: 'Frontiers in Nutrition',
    ),
    FoodFact(
      title: 'Chía: Omega-3 vegetal',
      fact:
          'La chía es la mayor fuente vegetal de omega-3 (más que el salmón por gramo). Absorbe 10 veces su peso en agua, excelente para hidratación prolongada.',
      icon: Icons.grain,
      color: Colors.grey,
      source: 'Journal of Food Science and Technology',
    ),
    FoodFact(
      title: 'Nuez de Castilla: Cerebro saludable',
      fact:
          'Las nueces de Castilla tienen la mayor cantidad de omega-3 entre los frutos secos. Su forma incluso parece un cerebro, órgano al que más benefician.',
      icon: Icons.psychology,
      color: Colors.brown,
      source: 'British Journal of Nutrition',
    ),
    FoodFact(
      title: 'Aceite de oliva: Oro líquido',
      fact:
          'El aceite de oliva extra virgen contiene oleocanthal, un antiinflamatorio con efectos similares al ibuprofeno. 3-4 cucharadas tienen el efecto de 200mg.',
      icon: Icons.water_drop,
      color: Colors.green,
      source: 'Nature',
    ),
    FoodFact(
      title: 'Café: Más que cafeína',
      fact:
          'El café es la mayor fuente de antioxidantes en la dieta occidental. Estudios muestran que 3-4 tazas al día reducen el riesgo de Parkinson y diabetes tipo 2.',
      icon: Icons.coffee,
      color: Colors.brown,
      source: 'New England Journal of Medicine',
    ),
  ];
}
