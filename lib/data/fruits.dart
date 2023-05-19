import 'package:flutter/material.dart';

import '../object/food.dart';

List<Food> fruits = [
  Food(
    name: 'Albaricoque seco',
    description:
        ' Fruta seca y arrugada de color naranja oscuro con una pulpa dulce y pegajosa ',
    calories: 48,
    portions: 5,
    image: Image.asset('img/fruits/albaricoqueseco.jpg'),
  ),
  Food(
    name: 'Arándano',
    description:
        ' Fruta pequeña redonda de color azul oscuro o negro con una pulpa jugosa y dulce o ácida según la variedad ',
    calories: 57,
    portions: 20,
    image: Image.asset('img/fruits/arandano.jpg'),
  ),
  Food(
    name: 'Arándano seco',
    description:
        ' Fruta seca y arrugada de color azul oscuro o negro con una pulpa dulce y pegajosa ',
    calories: 308,
    portions: 10,
    image: Image.asset('img/fruits/arandanoseco.jpg'),
  ),
  Food(
    name: 'Banana',
    description:
        ' Fruta alargada y curvada con piel amarilla y pulpa blanda y dulce',
    calories: 89,
    portions: 0.5,
    image: Image.asset('img/fruits/banana.jpg'),
  ),
  Food(
    name: 'Cereza',
    description:
        ' Fruta pequeña y jugosa con piel roja o negra brillante y pulpa dulce o ácida según la variedad ',
    calories: 50,
    portions: 10,
    image: Image.asset('img/fruits/cereza.jpg'),
  ),
  Food(
    name: 'Ciruela',
    description:
        ' Fruta redonda u ovalada con piel lisa y pulpa jugosa y dulce o ácida según la variedad ',
    calories: 46,
    portions: 1,
    image: Image.asset('img/fruits/ciruela.jpg'),
  ),
  Food(
    name: 'Ciruela pasa',
    description:
        ' Fruta seca y arrugada de color marrón oscuro con una pulpa dulce y pegajosa ',
    calories: 240,
    portions: 5,
    image: Image.asset('img/fruits/ciruelapasa.jpg'),
  ),
  Food(
    name: 'Coco ',
    description:
        'Fruta grande redonda u ovalada de color marrón oscuro con una capa fibrosa exterior ',
    calories: 354,
    portions: 0.5,
    image: Image.asset('img/fruits/coco.jpg'),
  ),
  Food(
    name: 'Durazno',
    description:
        ' Fruta redonda u ovalada con piel aterciopelada y pulpa jugosa y dulce',
    calories: 39,
    portions: 1,
    image: Image.asset('img/fruits/darazno.jpg'),
  ),
  Food(
    name: 'Dátil',
    description:
        ' Fruta alargada y delgada de color marrón oscuro con una pulpa dulce y pegajosa ',
    calories: 282,
    portions: 5,
    image: Image.asset('img/fruits/datil.jpg'),
  ),
  Food(
    name: 'Frambuesa',
    description:
        ' Fruta pequeña formada por pequeñas drupas agrupadas en forma de cono y de color rojo o negro ',
    calories: 52,
    portions: 30,
    image: Image.asset('img/fruits/frambruesa.jpg'),
  ),
  Food(
    name: 'Fresa',
    description:
        ' Fruta pequeña y jugosa con piel roja y semillas en la superficie',
    calories: 32,
    portions: 17,
    image: Image.asset('img/fruits/fresa.jpg'),
  ),
  Food(
    name: 'Goji berry seco',
    description:
        ' Fruta seca y arrugada de color rojo brillante con una pulpa dulce y ligeramente ácida ',
    calories: 349,
    portions: 10,
    image: Image.asset('img/fruits/gojiberryseco.jpg'),
  ),
  Food(
    name: 'Granada',
    description:
        ' Fruta redonda con piel gruesa y dura y pulpa dividida en compartimentos llenos de semillas rodeadas de jugo dulce o ácido ',
    calories: 83,
    portions: 0.5,
    image: Image.asset('img/fruits/granada.jpg'),
  ),
  Food(
    name: 'Grosella negra seca',
    description:
        ' Fruta seca y arrugada de color negro o morado oscuro con una pulpa dulce y ligeramente ácida ',
    calories: 283,
    portions: 10,
    image: Image.asset('img/fruits/grosellanegraseca.jpg'),
  ),
  Food(
    name: 'Grosella roja seca',
    description:
        ' Fruta seca y arrugada de color rojo brillante con una pulpa dulce y ligeramente ácida ',
    calories: 56,
    portions: 10,
    image: Image.asset('img/fruits/grosellarojaseca.jpg'),
  ),
  Food(
    name: 'Guayaba',
    description:
        ' Fruta redonda u ovalada con piel verde o amarilla y pulpa blanca o rosada y dulce ',
    calories: 68,
    portions: 1,
    image: Image.asset('img/fruits/guayaba.jpg'),
  ),
  Food(
    name: 'Higo seco',
    description:
        ' Fruta seca y arrugada de color marrón oscuro con una pulpa dulce y pegajosa ',
    calories: 74,
    portions: 2,
    image: Image.asset('img/fruits/higoseco.jpg'),
  ),
  Food(
    name: 'Kiwi',
    description:
        ' Fruta pequeña y jugosa con piel marrón peluda y pulpa verde dulce y suave',
    calories: 61,
    portions: 2,
    image: Image.asset('img/fruits/kiwi.jpg'),
  ),
  Food(
    name: 'Lima',
    description:
        ' Fruta redonda de color verde claro a amarillo claro con una pulpa ácida ',
    calories: 30,
    portions: 1,
    image: Image.asset('img/fruits/lima.jpg'),
  ),
  Food(
    name: 'Limón ',
    description:
        'Fruta redonda de color amarillo brillante con una pulpa ácida ',
    calories: 29,
    portions: 1,
    image: Image.asset('img/fruits/limon.jpg'),
  ),
  Food(
    name: 'Mandarina',
    description:
        ' Fruta redonda y pequeña con piel naranja fácil de pelar y pulpa dividida en gajos ',
    calories: 53,
    portions: 1,
    image: Image.asset('img/fruits/mandarina.jpg'),
  ),
  Food(
    name: 'Mango',
    description:
        ' Fruta grande y jugosa con piel amarilla o naranja y pulpa dulce y fibrosa',
    calories: 60,
    portions: 1,
    image: Image.asset('img/fruits/mango.jfif'),
  ),
  Food(
    name: 'Manzana',
    description: ' Fruta redonda y jugosa con piel roja o verde y pulpa blanca',
    calories: 52,
    portions: 1,
    image: Image.asset('img/fruits/manzana.jpg'),
  ),
  Food(
    name: 'Melón',
    description:
        ' Fruta grande y jugosa con piel verde o amarilla y pulpa dulce y suave',
    calories: 36,
    portions: 1,
    image: Image.asset('img/fruits/melon.jpg'),
  ),
  Food(
    name: 'Mora',
    description:
        ' Fruta pequeña formada por pequeñas drupas agrupadas en forma de cono y de color negro o morado oscuro ',
    calories: 43,
    portions: 10,
    image: Image.asset('img/fruits/mora.jpg'),
  ),
  Food(
    name: 'Naranja',
    description:
        ' Fruta redonda y jugosa con piel naranja y pulpa dividida en gajos',
    calories: 47,
    portions: 1,
    image: Image.asset('img/fruits/naranja.jpg'),
  ),
  Food(
    name: 'Papaya',
    description:
        ' Fruta grande y jugosa con piel amarilla o naranja y pulpa dulce y suave',
    calories: 43,
    portions: 1,
    image: Image.asset('img/fruits/papaya.jpg'),
  ),
  Food(
    name: 'Pasas',
    description:
        ' Frutas secas y arrugadas de color marrón oscuro o dorado con una pulpa dulce y pegajosa ',
    calories: 299,
    portions: 10,
    image: Image.asset('img/fruits/pasas.jpg'),
  ),
  Food(
    name: 'Pera',
    description:
        ' Fruta redonda u ovalada con piel verde o amarilla y pulpa blanca y jugosa',
    calories: 57,
    portions: 1,
    image: Image.asset('img/fruits/pera.jpg'),
  ),
  Food(
    name: 'Piña',
    description:
        ' Fruta grande y jugosa con piel marrón y pulpa amarilla y dulce',
    calories: 50,
    portions: 1,
    image: Image.asset('img/fruits/pina.jpg'),
  ),
  Food(
    name: 'Sandía',
    description:
        ' Fruta grande y jugosa con piel verde o rayada y pulpa roja o amarilla dulce y suave',
    calories: 30,
    portions: 1,
    image: Image.asset('img/fruits/sandia.jpg'),
  ),
  Food(
    name: 'Toronja ',
    description:
        'Fruta grande redonda de color amarillo anaranjado con una pulpa ácida ',
    calories: 42,
    portions: 0.5,
    image: Image.asset('img/fruits/toronja.jpg'),
  ),
  Food(
    name: 'Uva ',
    description:
        'Fruta pequeña redonda u ovalada de color verde amarillento o morado oscuro ',
    calories: 69,
    portions: 15,
    image: Image.asset('img/fruits/uva.jpg'),
  ),
];
