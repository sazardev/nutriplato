# Changelog

Todos los cambios notables de NutriPlato se documentan en este archivo.

El formato sigue [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/)
y el proyecto se adhiere a [Versionado Semántico](https://semver.org/lang/es/).

## [No publicado]

### Añadido

- Blog ampliado: 62 artículos nuevos en `lib/data/articles/` (fundamentos de
  nutrición, recetas y menús, salud y condiciones, estilo de vida, tradición
  gastronómica mexicana y bienestar), conectados al `ArticleProvider` para
  alimentar las secciones "Artículos destacados" y el listado completo con sus
  filtros por etiqueta.
- Política de versionado: script `tool/bump_version.dart`, `CHANGELOG.md`,
  hook de `pre-commit` y documentación en `VERSIONING.md`.
- Página "Tu plan personalizado" al final del onboarding: propuesta calculada
  con el algoritmo real (BMR, TDEE, calorías objetivo, macronutrientes,
  distribución de comidas, plan de comidas diario con alimentos reales, peso
  ideal por fórmula, proyección de peso, hidratación, ajustes y límites por
  condición de salud, y alimentos recomendados/a evitar).
- Botón "Aplicar plan a mi registro de hoy" en el plan del onboarding: agrega
  las comidas generadas (desayuno, almuerzo, cena y snacks con sus porciones)
  directamente al registro diario de alimentos.
- Motor de predicción diaria (`DailyPredictionService`): algoritmo determinista
  (misma semilla por usuario y fecha) que predice qué comer, qué ejercicio
  hacer y qué leer hoy, personalizando con el perfil (meta, actividad,
  condiciones, alergias) y el historial reciente (comidas y ejercicios) para
  evitar repeticiones. Widget "Tu predicción de hoy" en el dashboard con
  botones para aplicar las comidas al registro y empezar la rutina.
- Banco de ejercicios ampliado: se añadieron 53 ejercicios nuevos
  (`smart_exercise_extra.data.dart`) cubriendo cardio, fuerza, core,
  flexibilidad, movilidad e HIIT con distintos equipamientos, intensidades,
  límites por IMC, pasos, tips y contraindicaciones. La biblioteca pasa de 55
  a 108 ejercicios.
- Accesibilidad (WCAG 2.2): nombre accesible (`tooltip`) en todos los
  `IconButton`, semántica de botón/estado en todos los `GestureDetector`
  interactivos, encabezados navegables en el onboarding, contraste AA en chips,
  banners y textos secundarios, acceso por teclado/switch al plato interactivo
  (`CustomSemanticsAction`) y soporte para "reducir movimiento".

## [3.0.0] - 2026-08-07

### Añadido

- Onboarding mejorado con animaciones fluidas, perfil de usuario y selección de
  condiciones de salud y alergias.
- Sistema de temas con 8 gradientes de color y modo oscuro.
- Perfil de usuario con condiciones de salud, métricas y respaldo/restauración.
- Registro diario de alimentos con cálculo de calorías y macronutrientes.
- Buscador de alimentos con búsqueda en línea (OpenFoodFacts) y filtros.
- Rutinas de ejercicio y Smart Fitness con recomendaciones personalizadas.
- Artículos educativos y sección "Aprende cada día".
- Sidebar moderno con acceso a perfil, temas y políticas de privacidad.

### Cambiado

- Refactorización de la arquitectura hacia `infrastructure/`, `presentation/`
  y `fitness/`, con sistema de diseño centralizado (`NutriDesign`).

### Corregido

- Detección de la sección tocada en el plato interactivo: ahora usa
  coordenadas locales del plato (`localPosition`) en vez de `globalToLocal`
  del Scaffold, lo que eliminaba un desfase vertical; geometría polar pura,
  probada con tests unitarios (`test/plate_section_detection_test.dart`).
- Protección del lanzamiento de intents de Android en plataformas web.

<!-- __VERSION_LINKS__ -->
[No publicado]: https://github.com/sazardev/nutriplato/compare/v3.0.0...HEAD
[3.0.0]: https://github.com/sazardev/nutriplato/releases/tag/v3.0.0
