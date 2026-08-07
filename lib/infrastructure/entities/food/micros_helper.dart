import 'animal.dart';
import 'cereal.dart';
import 'food.dart';
import 'fruta.dart';
import 'leguminosa.dart';
import 'micronutrients.dart';
import 'verdura.dart';

/// Extrae los micronutrientes de un [Food], sin importar su tipo concreto.
///
/// Prioriza el valor ya persistido (`food.micros`, por ejemplo al cargar un
/// registro guardado); si no existe, los extrae de los campos del subtipo
/// concreto (`Cereal`, `Fruta`, `Verdura`, `Leguminosa`, `Animal`).
Micronutrients? microsOf(Food food) {
  if (food.micros != null) return food.micros;

  if (food is Cereal) {
    return Micronutrients(
      fibra: food.fibra,
      sodio: food.sodio,
      calcio: food.calcio,
      hierro: food.hierro,
      acidoFolico: food.acidoFolico,
      azucarEquivalente: food.azucarEquivalente,
      indiceGlicemico: food.indiceGlicemico,
      cargaGlicemica: food.cargaGlicemica,
    );
  }

  if (food is Fruta) {
    return Micronutrients(
      fibra: food.fibra,
      potasio: food.potasio,
      vitaminaA: food.vitaminaA,
      acidoAscorbico: food.acidoAscorbico,
      acidoFolico: food.acidoFolico,
      hierro: food.hierro,
      indiceGlicemico: food.indiceGlicemico,
      cargaGlicemica: food.cargaGlicemica,
    );
  }

  if (food is Verdura) {
    return Micronutrients(
      fibra: food.fibra,
      potasio: food.potasio,
      vitaminaA: food.vitaminaA,
      acidoAscorbico: food.acidoAscorbico,
      acidoFolico: food.acidoFolico,
      hierro: food.hierro,
      indiceGlicemico: food.indiceGlicemico,
      cargaGlicemica: food.cargaGlicemica,
    );
  }

  if (food is Leguminosa) {
    return Micronutrients(
      fibra: food.fibra,
      potasio: food.potasio,
      hierro: food.hierro,
      selenio: food.selenio,
      fosforo: food.fosforo,
      azucarEquivalente: food.azucarEquivalente,
      indiceGlicemico: food.indiceGlicemico,
      cargaGlicemica: food.cargaGlicemica,
    );
  }

  if (food is Animal) {
    return Micronutrients(
      sodio: food.sodio,
      calcio: food.calcio,
      hierro: food.hierro,
      vitaminaA: food.vitaminaA,
      colesterol: food.colesterol,
      selenio: food.selenio,
    );
  }

  return null;
}
