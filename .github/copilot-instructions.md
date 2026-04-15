# NutriPlato — Copilot Instructions

> Token-optimized reference. Skip sections you already know. Use headings to jump directly.

---

## 1. PROJECT IDENTITY

**App**: NutriPlato v3.0.0+4  
**Purpose**: Educación nutricional basada en el Plato del Bien Comer (NOM-043-SSA2-2012, estándar mexicano).  
**Features**: Plato del Bien Comer interactivo, rastreador de calorías, plan de comidas, fitness, artículos educativos, onboarding, perfil con cálculos nutricionales personalizados.  
**Language**: Spanish UI / código en inglés con comentarios en español.

---

## 2. TECH STACK

| Layer | Tech |
|---|---|
| Framework | Flutter (Dart SDK >=3.3.0 <4.0.0) |
| State (global) | `provider ^6.0.5` — `ChangeNotifier` + `MultiProvider` |
| State (reactive) | `get ^4.6.6` — `GetxController`, `Rx<T>`, `.obs`, `GetMaterialApp` |
| Navigation | GetX (`Get.to`, `Get.arguments`) + `PageController` en HomeScreen |
| Persistence | `shared_preferences ^2.1.1` — JSON serializado |
| HTTP | `http ^1.2.1` |
| Fonts | `google_fonts ^6.2.1` — Poppins en toda la app |
| Icons | `font_awesome_flutter ^10.4.0`, `icons_plus ^5.0.0` |
| Animations | `lottie ^3.1.2`, `shimmer ^3.0.0`, `smooth_page_indicator ^1.1.0` |
| Onboarding | `introduction_screen ^4.0.0` |
| UI components | `percent_indicator ^4.2.4`, `salomon_bottom_bar ^3.3.2`, `showcaseview ^5.0.1`, `circular_countdown_timer ^0.2.3` |
| Sharing | `share_plus ^12.0.1` |
| Localización | `intl ^0.20.2` |

**REGLA**: nunca mezclar GetX y Provider para el mismo estado. Provider = datos de negocio globales. GetX = controladores de feature.

---

## 3. ARQUITECTURA Y ESTRUCTURA

```
lib/
├── main.dart                   # Entry point, MultiProvider setup, GetMaterialApp
├── config/
│   └── theme/
│       ├── app_theme.dart      # AppTheme clase, 8 temas de color, gradients
│       └── design_system.dart  # NutriDesign — constantes de color, spacing, radii, tipografía
├── data/
│   ├── data.dart               # Barrel export de datos
│   └── food/                   # Listas estáticas de alimentos por categoría
│       ├── animals.dart
│       ├── cereales.dart
│       ├── frutas.dart
│       ├── leguminosas.dart
│       └── verduras.dart
│   └── img/                    # Assets: animal/, cereales/, fruits/, leguminosas/, vegetables/, porciones_mano/
├── infrastructure/
│   ├── entities/
│   │   ├── user.dart           # User model simple (legacy)
│   │   ├── user/
│   │   │   └── user_profile.dart  # UserProfile @immutable, Gender, ActivityLevel, NutritionGoal enums
│   │   ├── food/
│   │   │   ├── food.dart          # Food model (name, category, macros, image)
│   │   │   ├── food_log_entry.dart
│   │   │   ├── food_log_provider.dart  # FoodLogProvider (ChangeNotifier)
│   │   │   ├── calories_tracker_screen.dart
│   │   │   ├── add_food_entry_screen.dart
│   │   │   └── [animal|cereal|fruta|leguminosa|verdura].dart  # subtypes
│   │   ├── article/
│   │   │   ├── article.dart
│   │   │   └── article_section.dart
│   │   └── health/
│   │       └── health_condition.dart  # HealthCondition, HealthMetric
│   └── services/
│       ├── nutrition_calculator_service.dart  # BMR (Mifflin-St Jeor, Harris-Benedict), TDEE, macros
│       ├── food_alert_service.dart
│       └── smart_nutrition_service.dart
├── presentation/
│   ├── home.screen.dart        # HomeScreen — 5 tabs via PageController + salomon_bottom_bar
│   ├── provider/
│   │   ├── article_provider.dart
│   │   ├── theme_changer_provider.dart
│   │   ├── user_provider.dart         # UserProvider — carga/guarda User legacy
│   │   └── user_profile_provider.dart # UserProfileProvider — perfil completo + health conditions + métricas
│   └── screens/
│       ├── screens.dart               # Barrel export
│       ├── dashboard/
│       │   ├── modern_dashboard_screen.dart
│       │   └── dashboard.screen.dart
│       ├── food/
│       │   ├── foods.screen.dart
│       │   └── food.view.dart
│       ├── plate/
│       │   └── plate_screen.dart      # Plato del Bien Comer interactivo
│       ├── meal_plan/
│       │   └── meal_plan_screen.dart
│       ├── profile/
│       │   └── profile_screen.dart
│       ├── onboarding/
│       │   └── enhanced_onboarding_screen.dart
│       ├── education/
│       │   └── nutrition_education_screen.dart
│       ├── article_list_screen.dart
│       ├── article_detail_screen.dart
│       ├── featured_articles.dart
│       └── widgets/
│           ├── custom_bottom_nav.dart
│           ├── modern_app_bar.dart
│           ├── modern_cards.dart
│           ├── modern_sidebar.dart
│           ├── animation_widgets.dart
│           ├── loading_widgets.dart
│           ├── article_card.dart
│           └── theme_changer_screen.dart
├── fitness/
│   ├── fitness.controller.dart  # FitnessController (GetxController) — selectedExercise, listedExercises
│   ├── fitness.model.dart       # Fitness (name, desc, difficulty, tags, sets, rest, exercises, gradients)
│   ├── fitness.data.dart        # exercisesData lista estática
│   ├── fitness.screen.dart
│   ├── exercise/
│   │   ├── exercise.model.dart
│   │   ├── exercise.screen.dart
│   │   ├── exercise.start.dart
│   │   └── exercise.finish.dart
│   └── shared/
│       ├── fitness-popular.widget.dart
│       ├── gradient-card.widget.dart
│       └── simple-card.widget.dart
└── search/
    └── search.screen.dart
```

---

## 4. NAVEGACIÓN — 5 TABS (HomeScreen)

| Index | Screen | Ruta conceptual |
|---|---|---|
| 0 | `ModernDashboardScreen` | Dashboard principal |
| 1 | `CaloriesTrackerScreen` | Rastreador de calorías |
| 2 | `SearchScreen` | Búsqueda de alimentos |
| 3 | `PlateScreen` | Plato del Bien Comer |
| 4 | `FitnessScreen` | Fitness / Ejercicio |

Navegación interna: `_pageController.animateToPage(index, ...)`. Pasar índice con `Get.arguments`.

---

## 5. MODELOS CLAVE

### Food
```dart
Food { name, category, icon, color, cantidadSugerida, unidad,
       pesoRedondeado, pesoNeto, energia, proteina, lipidos,
       hidratosDeCarbono, image?, description? }
```
Categorías: `animal`, `cereal`, `fruta`, `leguminosa`, `verdura`

### UserProfile (@immutable)
```dart
UserProfile { id, username, email?, avatarUrl?, createdAt, updatedAt,
  birthDate?, gender (Gender enum), heightCm?, weightKg?, targetWeightKg?,
  activityLevel (ActivityLevel), nutritionGoal (NutritionGoal),
  onboardingCompleted, isProfileComplete }
```

### Enums UserProfile
- `Gender`: male, female, other
- `ActivityLevel`: sedentary(1.2), lightlyActive(1.375), moderatelyActive(1.55), veryActive(1.725), extraActive(1.9)
- `NutritionGoal`: loseWeight(-500kcal), loseWeightFast(-750), maintainWeight(0), gainMuscle(+300), gainWeight(+500)

### Fitness
```dart
Fitness { name, description, difficulty, tags, sets, rest,
          exercises: List<Exercise>, icon, gradients }
```

---

## 6. PROVIDERS (ChangeNotifier via `provider`)

| Provider | Persistencia | Responsabilidad |
|---|---|---|
| `ArticleProvider` | HTTP | Obtiene artículos educativos |
| `FoodLogProvider` | SharedPreferences | Logs diarios de alimentos consumidos |
| `UserProvider` | SharedPreferences | Usuario simple legacy (`User`) |
| `ThemeChangerProvider` | SharedPreferences | Color del tema seleccionado (0-7) |
| `UserProfileProvider` | SharedPreferences | Perfil completo, condiciones de salud, métricas, streak |

Todos inicializados `lazy: false` en `main.dart` `MultiProvider`.

---

## 7. GETX CONTROLLERS

| Controller | Scope | Estado |
|---|---|---|
| `FitnessController` | `Get.put()` en `initialBinding` | `selectedExercise Rx<Fitness?>`, `listedExercises <Fitness>[].obs` |

Agregar nuevos controllers: `Get.put()` en `initialBinding` de `GetMaterialApp` o con `GetBuilder` local.

---

## 8. SERVICIOS

### NutritionCalculatorService (static methods)
- `calculateBMR({weightKg, heightCm, age, gender, formula})` — Mifflin-St Jeor (default), Harris-Benedict, Katch-McArdle
- Referencia normativa: NOM-043-SSA2-2012

### FoodAlertService
Alertas nutricionales basadas en ingesta.

### SmartNutritionService
Recomendaciones inteligentes basadas en perfil.

---

## 9. DESIGN SYSTEM (`NutriDesign`)

```dart
// Espaciado: 4, 8, 12, 16, 20, 24, 32, 48
// Border radius: 8(sm), 12(md), 16(lg), 20(xl), 24(xxl), 100(circle)
// Elevación: 0, 2, 4, 8
// Iconos: 16(sm), 20(md), 24(lg), 32(xl)
// Colores estado: success #51CF66, warning #FFA726, error #FF6B6B, info #4DABF7
// Grises: grey50..grey900
```

### Temas de color (8)
`AppTheme.colorThemes`: Morado(0xFF6C63FF), Verde azulado(4ECDC4), Coral(FF6B6B), Azul(4DABF7), Naranja(FFA726), Verde(51CF66), Rosa(FF8CC8), Púrpura(845EC2)

Font: **Poppins** (Google Fonts) en toda la app.

---

## 10. PERSISTENCIA (SharedPreferences)

| Clave | Tipo | Contenido |
|---|---|---|
| `presentation` | `bool` | Si mostrar onboarding |
| `username` | `String` (JSON) | `User` legacy |
| `user_profile` | `String` (JSON) | `UserProfile` completo |
| `user_health_conditions` | `List<String>` (JSON) | Lista de `HealthCondition` |
| `user_health_metrics` | `List<String>` (JSON) | Lista de `HealthMetric` |

Patrón: `jsonEncode/jsonDecode` + `toJson()/fromJson()` en todos los modelos.

---

## 11. DATOS ESTÁTICOS DE ALIMENTOS

- Ubicación: `lib/data/food/` — un archivo por categoría
- Exportados desde `lib/data/data.dart`
- Son listas `List<Food>` con macronutrientes por porción
- Imágenes en `lib/data/img/{categoría}/`

---

## 12. ASSETS

```yaml
flutter:
  assets:
    - lib/data/img/
    - lib/data/img/porciones_mano/
    - lib/data/img/animal/
    - lib/data/img/cereales/
    - lib/data/img/fruits/
    - lib/data/img/leguminosas/
    - lib/data/img/vegetables/
```

---

## 13. CONVENCIONES DE CÓDIGO

### Nombrado de archivos
- Screens: `feature.screen.dart` o `feature_screen.dart`
- Controllers: `feature.controller.dart`
- Models: `feature.model.dart`
- Data: `feature.data.dart`
- Providers: `feature_provider.dart`
- Widgets: `feature_widget.dart` o `feature.widget.dart`

### Patrones
- Modelos inmutables → `@immutable` + constructores `copyWith`
- Enums con `fromString()` factory para deserialización segura
- Provider consumes: `context.watch<X>()` o `Consumer<X>` en widgets
- GetX reactivo: `.obs` + `Obx(() => ...)` en widgets
- No usar `BuildContext` fuera de widgets (pasar como parámetro)
- `const` constructores donde sea posible

### Imports
```dart
// Orden: dart:, package:flutter, package:get, package:nutriplato, relativos
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/...';
```

---

## 14. FLUJOS PRINCIPALES

### Onboarding → Home
```
main() → SharedPrefs.getBool('presentation')
  → true  → EnhancedOnboardingScreen → guarda 'presentation'=false → HomeScreen
  → false → HomeScreen (5 tabs)
```

### Registro de alimento
```
SearchScreen → selecciona Food → AddFoodEntryScreen 
→ FoodLogProvider.addFoodEntry(entry) 
→ SharedPrefs actualiza → notifyListeners()
→ DashboardScreen refleja calorías del día
```

### Cambio de tema
```
ThemeChangerScreen → ThemeChangerProvider.selectedColor 
→ Consumer<ThemeChangerProvider> en MyApp 
→ AppTheme().getTheme(selectedColor) → rebuild
```

### Perfil nutricional
```
ProfileScreen → UserProfileProvider
→ NutritionCalculatorService.calculateBMR() → TDEE
→ NutritionGoal.calorieAdjustment → meta calórica diaria
→ SharedPrefs guarda 'user_profile'
```

### Fitness
```
FitnessScreen → FitnessController.listedExercises (GetX .obs)
→ selecciona Fitness → FitnessController.selectedExercise
→ ExerciseScreen → ExerciseStart → ExerciseFinish
```

---

## 15. COMANDOS

```bash
# Desarrollo
flutter run                          # Ejecutar en dispositivo/emulador
flutter run -d chrome               # Web

# Build
flutter build apk --release         # APK release
flutter build appbundle             # AAB para Play Store

# Análisis
flutter analyze                     # Lint (flutter_lints ^6.0.0)
flutter test                        # Tests

# Dependencias
flutter pub get                     # Instalar dependencias
flutter pub upgrade                 # Actualizar dependencias

# Código generado (si aplica)
flutter pub run flutter_launcher_icons  # Generar iconos del launcher
```

---

## 16. INSTRUCCIONES PARA COPILOT

### Respuestas eficientes
- Inferir la capa correcta antes de sugerir código: ¿es un modelo, provider, controller, screen o widget?
- Para nuevas pantallas: seguir el patrón `feature.screen.dart` con `StatelessWidget` si no tiene estado local
- Para nuevo estado global: agregar `ChangeNotifierProvider` en `main.dart` `MultiProvider`
- Para nuevo estado de feature: usar `GetxController` + `Get.put()` en binding

### No hacer
- No usar `setState` en screens que ya usan Provider o GetX para ese estado
- No duplicar lógica de cálculo nutricional fuera de `NutritionCalculatorService`
- No hardcodear colores directamente — usar `NutriDesign.*` o `Theme.of(context)`
- No agregar dependencias sin verificar si ya existe funcionalidad similar
- No crear nuevas categorías de alimentos fuera de las 5 existentes: animal, cereal, fruta, leguminosa, verdura

### Patrones de referencia rápida

**Nuevo screen con Provider:**
```dart
class MyScreen extends StatelessWidget {
  const MyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MyProvider>();
    return Scaffold(/* ... */);
  }
}
```

**Nuevo screen con GetX:**
```dart
class MyScreen extends StatelessWidget {
  final controller = Get.find<FitnessController>();
  // ...
  Obx(() => Text(controller.selectedExercise.value?.name ?? ''));
}
```

**Nuevo modelo persistido:**
```dart
@immutable
class MyModel {
  // campos final
  factory MyModel.fromJson(Map<String, dynamic> json) => ...;
  Map<String, dynamic> toJson() => {...};
  MyModel copyWith({...}) => ...;
}
```

---

## 17. MCP TOOLS — USO RECOMENDADO

| Tool | Cuándo usar |
|---|---|
| **Serena MCP** | Exploración simbólica del codebase, find_symbol, find_referencing_symbols, replace_symbol_body — preferir sobre leer archivos completos |
| **Context7 MCP** | Docs actualizadas de Flutter, GetX, Provider, intl — resolve-library-id luego get-library-docs |
| **Memory MCP** | Guardar patrones descubiertos, convenciones confirmadas, errores conocidos del proyecto |
| **Filesystem MCP** | Operaciones de archivo cuando custom tools no son suficientes |
| **Git MCP** | Estado del repo, diffs, historial de cambios |

### Flujo recomendado para tareas complejas
1. `Serena.get_symbols_overview` o `find_symbol` para ubicar código relevante
2. Leer solo los cuerpos necesarios (`include_body=true`)
3. `find_referencing_symbols` para entender impacto de cambios
4. `Context7.get-library-docs` si necesitas API actualizada del paquete
5. Editar con `replace_symbol_body` o `replace_string_in_file`
6. `Memory.add_observations` para guardar lo aprendido

---

## 18. CONTEXTO NUTRICIONAL (Dominio)

- **NOM-043-SSA2-2012**: norma mexicana, agrupa alimentos en 3 grupos: verduras/frutas, cereales/tubérculos, leguminosas/alimentos de origen animal
- **Plato del Bien Comer**: mitad verduras+frutas, 1/4 cereales, 1/4 proteínas
- **TMB/BMR**: Tasa Metabólica Basal — fórmulas: Mifflin-St Jeor (default), Harris-Benedict
- **TDEE**: BMR × factor de actividad
- **Meta calórica**: TDEE + `NutritionGoal.calorieAdjustment`
- **Macronutrimentos en Food**: energía (kcal), proteína (g), lípidos (g), hidratos de carbono (g) — todos como `String` en el modelo
