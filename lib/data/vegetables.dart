import 'package:flutter/material.dart';

import '../models/food.dart';

List<Food> vegetables = [
  Food(
    name: 'Ajo',
    description:
        ' Verdura pequeña y redonda con piel blanca y pulpa dividida en dientes ',
    calories: 149,
    portions: 1,
    image: Image.asset('img/vegetables/ajo.jpg'),
  ),
  Food(
    name: 'Alcachofa',
    description:
        ' Verdura grande y redonda con hojas verdes y una pulpa comestible en el centro ',
    calories: 47,
    portions: 0.5,
    image: Image.asset('img/vegetables/alcachofa.jpg'),
  ),
  Food(
    name: 'Apio',
    description: ' Verdura de tallos verdes y crujientes ',
    calories: 16,
    portions: 1,
    image: Image.asset('img/vegetables/apio.jpg'),
  ),
  Food(
    name: 'Berenjena',
    description:
        ' Verdura alargada y delgada con piel morada y pulpa blanca y jugosa ',
    calories: 25,
    portions: 1,
    image: Image.asset('img/vegetables/berenjena.jpg'),
  ),
  Food(
    name: 'Brócoli',
    description:
        ' Verdura de tallos verdes y flores comestibles en forma de árbol pequeño ',
    calories: 34,
    portions: 1,
    image: Image.asset('img/vegetables/brocoli.jpg'),
  ),
  Food(
    name: 'Calabacín',
    description:
        ' Verdura alargada y delgada con piel verde y pulpa blanca y jugosa ',
    calories: 17,
    portions: 1,
    image: Image.asset('img/vegetables/calabacin.jpg'),
  ),
  Food(
    name: 'Calabaza',
    description:
        ' Verdura grande y redonda con piel gruesa y dura y pulpa naranja y dulce ',
    calories: 26,
    portions: 0.5,
    image: Image.asset('img/vegetables/calabaza.jpg'),
  ),
  Food(
    name: 'Cebolla',
    description:
        ' Verdura redonda y jugosa con piel blanca o morada y pulpa dividida en capas ',
    calories: 40,
    portions: 0.5,
    image: Image.asset('img/vegetables/cebolla.jpg'),
  ),
  Food(
    name: 'Cebolla verde',
    description:
        ' Verdura alargada y delgada con tallos verdes y una base blanca ',
    calories: 32,
    portions: 1,
    image: Image.asset('img/vegetables/cebollaverde.jpg'),
  ),
  Food(
    name: 'Champiñón',
    description:
        ' Verdura redonda y pequeña con un sombrero marrón o blanco y un tallo blanco ',
    calories: 22,
    portions: 1,
    image: Image.asset('img/vegetables/champiñon.jpg'),
  ),
  Food(
    name: 'Chirivía',
    description:
        ' Verdura alargada y delgada de color blanco con una pulpa dulce y crujiente ',
    calories: 75,
    portions: 1,
    image: Image.asset('img/vegetables/chirivia.jpg'),
  ),
  Food(
    name: 'Col',
    description: ' Verdura de hojas verdes y crujientes ',
    calories: 25,
    portions: 1,
    image: Image.asset('img/vegetables/col.jpg'),
  ),
  Food(
    name: 'Col Rizada',
    description: ' Verdura de hojas verdes y crujientes ',
    calories: 49,
    portions: 1,
    image: Image.asset('img/vegetables/colerizada.jpg'),
  ),
  Food(
    name: 'Coles de Bruselas',
    description: ' Verdura pequeña y redonda con hojas verdes y crujientes ',
    calories: 43,
    portions: 5,
    image: Image.asset('img/vegetables/colesdebruselas.jpg'),
  ),
  Food(
    name: 'Coliflor',
    description:
        ' Verdura de tallos blancos y flores comestibles en forma de árbol pequeño ',
    calories: 25,
    portions: 1,
    image: Image.asset('img/vegetables/coliflor.jpg'),
  ),
  Food(
    name: 'Encurtidos',
    description:
        ' Verdura pequeña y redonda con piel verde y pulpa blanca y jugosa ',
    calories: 12,
    portions: 1,
    image: Image.asset('img/vegetables/encurtidos.jpg'),
  ),
  Food(
    name: 'Espinaca',
    description: ' Verdura de hojas verdes y suaves ',
    calories: 23,
    portions: 1,
    image: Image.asset('img/vegetables/espainaca.jpg'),
  ),
  Food(
    name: 'Espárragos',
    description:
        ' Verdura alargada y delgada con un tallo verde y una punta comestible ',
    calories: 20,
    portions: 5,
    image: Image.asset('img/vegetables/esparragos.jpg'),
  ),
  Food(
    name: 'Guisantes',
    description:
        ' Verdura pequeña y redonda de color verde con una pulpa dulce y jugosa ',
    calories: 81,
    portions: 0.5,
    image: Image.asset('img/vegetables/guisantes.jpg'),
  ),
  Food(
    name: 'Jugo de Tomate',
    description: ' Bebida hecha a base de tomates exprimidos ',
    calories: 17,
    portions: 1,
    image: Image.asset('img/vegetables/jugodetomate.jpg'),
  ),
  Food(
    name: 'Lechuga',
    description: ' Verdura de hojas verdes y crujientes ',
    calories: 14,
    portions: 1,
    image: Image.asset('img/vegetables/lechuga.jpg'),
  ),
  Food(
    name: 'Lechuga Romana',
    description: ' Verdura de hojas verdes y crujientes ',
    calories: 17,
    portions: 1,
    image: Image.asset('img/vegetables/lechugaromana.jpg'),
  ),
  Food(
    name: 'Maíz',
    description: ' Verdura de granos amarillos y dulces ',
    calories: 86,
    portions: 0.5,
    image: Image.asset('img/vegetables/maiz.jpg'),
  ),
  Food(
    name: 'Nabos',
    description:
        ' Verdura redonda y jugosa con piel blanca o morada y pulpa dividida en capas ',
    calories: 28,
    portions: 1,
    image: Image.asset('img/vegetables/nabos.jpg'),
  ),
  Food(
    name: 'Okra',
    description:
        ' Verdura alargada y delgada con piel verde y pulpa blanca y jugosa ',
    calories: 33,
    portions: 1,
    image: Image.asset('img/vegetables/okra.jpg'),
  ),
  Food(
    name: 'Pepino',
    description:
        ' Verdura alargada y delgada con piel verde y pulpa blanca y jugosa ',
    calories: 15,
    portions: 0.5,
    image: Image.asset('img/vegetables/pepino.jpg'),
  ),
  Food(
    name: 'Pimiento rojo',
    description:
        ' Verdura redonda y jugosa con piel roja y pulpa dividida en gajos ',
    calories: 31,
    portions: 1,
    image: Image.asset('img/vegetables/pimientorojo.jpg'),
  ),
  Food(
    name: 'Pimiento verde',
    description:
        ' Verdura redonda y jugosa con piel verde y pulpa dividida en gajos ',
    calories: 20,
    portions: 1,
    image: Image.asset('img/vegetables/pimientoverde.jpg'),
  ),
  Food(
    name: 'Betabel',
    description:
        ' Verdura redonda y jugosa con piel roja o morada y pulpa dividida en capas ',
    calories: 19,
    portions: 0.25,
    image: Image.asset('img/vegetables/rabamolacha.jpg'),
  ),
  Food(
    name: 'Rábanos',
    description:
        ' Verdura pequeña y redonda con piel roja o blanca y pulpa blanca y crujiente ',
    calories: 16,
    portions: 10,
    image: Image.asset('img/vegetables/rabano.jpg'),
  ),
  Food(
    name: 'Tomate',
    description:
        ' Verdura redonda y jugosa con piel roja o verde y pulpa dividida en gajos ',
    calories: 18,
    portions: 1,
    image: Image.asset('img/vegetables/tomate.jpg'),
  ),
  Food(
    name: 'Tomates cherry',
    description:
        ' Verdura pequeña y redonda con piel roja o verde y pulpa dividida en gajos ',
    calories: 18,
    portions: 10,
    image: Image.asset('img/vegetables/tomatescherry.jpg'),
  ),
  Food(
    name: 'Verduras Mezcladas',
    description: ' Mezcla de diferentes verduras cortadas en trozos pequeños ',
    calories: 59,
    portions: 1,
    image: Image.asset('img/vegetables/verdurasmezcladas.jpg'),
  ),
  Food(
    name: 'Zanahoria',
    description:
        ' Verdura alargada y delgada de color naranja con una pulpa dulce y crujiente ',
    calories: 41,
    portions: 1,
    image: Image.asset('img/vegetables/zanahoria.jpg'),
  ),
];
