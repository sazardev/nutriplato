# AGENTS.md

NutriPlato is a Flutter mobile app (v3.0.0+4, Dart SDK `>=3.3.0 <4.0.0`) for Mexican nutrition education (Plato del Bien Comer, NOM-043-SSA2-2012). UI text is Spanish; code is English with Spanish comments.

## Commands

```bash
flutter pub get        # install deps
flutter run            # device/emulator
flutter run -d chrome  # web
flutter build apk --release
flutter analyze        # lint. Baseline: 44 issues (3 warnings, 41 infos), ZERO errors
flutter test           # NO tests exist — no test/ dir, only dev dep flutter_test
```

No CI workflows, no pre-commit hooks. `flutter analyze` already ships with pre-existing warnings/infos (mostly `withOpacity` deprecations); don't treat those as newly introduced failures.

## State management (critical rule)

Hybrid, do NOT mix for the same state:
- **Provider** (`provider ^6.0.5`) — global business data via `ChangeNotifier` + `MultiProvider`, all `lazy: false` in `lib/main.dart:36-77` (`ArticleProvider`, `FoodLogProvider`, `UserProvider`, `ThemeChangerProvider`, `UserProfileProvider`).
- **GetX** (`get ^4.6.6`) — feature controllers: `FitnessController` and `SmartFitnessController`, both registered via `initialBinding` in `main.dart:87-90`. Use `.obs` + `Obx(() => ...)` or `Get.find<T>()`.
- Never `setState` state that a Provider/GetX controller already owns.

## Architecture

- `lib/main.dart` — entry. Reads `presentation` from SharedPreferences to pick `EnhancedOnboardingScreen` vs `HomeScreen`.
- `lib/config/theme/` — `app_theme.dart` (8 color themes), `design_system.dart` (`NutriDesign` constants). **Never hardcode colors/spacing/radii** — use `NutriDesign.*` or `Theme.of(context)`. Font is always Poppins (google_fonts).
- `lib/data/` — static food data, one file per category in `lib/data/food/`: `animals`, `cereales`, `frutas`, `leguminosas`, `verduras` (only these 5 categories exist). Images in `lib/data/img/{categoria}/`. Exports via `lib/data/data.dart`.
- `lib/infrastructure/` — models, services, **and some screens**. Quirk: `calories_tracker_screen.dart` and `add_food_entry_screen.dart` live under `lib/infrastructure/entities/food/`, NOT `presentation/screens/`. `nutrition_calculator_service.dart` owns ALL nutrition math (BMR/TDEE/macros) — do not duplicate it.
- `lib/presentation/` — `home.screen.dart` (5 tabs via `PageController` + salomon_bottom_bar: Dashboard, Calories, Search, Plate, Fitness), `provider/`, `screens/`.
- `lib/fitness/` — GetX feature module, includes `smart/` (SmartFitness) submodule.
- `lib/search/search.screen.dart` — food search.

Navigation: `Get.to(...)`, `Get.arguments`, `_pageController.animateToPage(...)`. Passing an int to `Get.arguments` sets the starting tab (`home.screen.dart:36-37`).

## Persistence (SharedPreferences, JSON via toJson/fromJson)

- `presentation` (bool) — show onboarding. `isDarkMode` (bool), `username` (User JSON), `user_profile` + `user_health_conditions` + `user_health_metrics` (UserProfile), `food_log_days` / `food_log_YYYY-MM-DD` (food log), `recentFoods` (search history), `last_use_date`.
- Models: `@immutable`, `copyWith`, `factory fromJson`, enums with `fromString()`.

## Platform notes

Targets: android, web, windows, linux. **No ios/macos folders.** Android intents (`android_intent_plus`) must be guarded — see `modern_sidebar.dart:162` for the `!kIsWeb && Platform.isAndroid` pattern.

## Conventions

- File naming: `feature.screen.dart` / `feature_screen.dart`, `feature.controller.dart`, `feature.model.dart`, `feature.data.dart`, `feature_provider.dart`, `feature.widget.dart`.
- Import order: `dart:`, `package:flutter`, `package:get`, `package:nutriplato/...`, relative.
- Use `const` constructors where possible; `context.watch<X>()` / `Consumer<X>` in widgets.
- Don't add new dependencies without checking for an existing equivalent.

## Reference

Deep reference: `.github/copilot-instructions.md` (architecture tree, models, flows, nutrition domain). Skills for Dart/Flutter live in `.agents/skills/` and `.claude/skills/`.
