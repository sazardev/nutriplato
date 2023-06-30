import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: Home.appRouterName,
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/presentation',
      name: PresentationScreen.appRouterName,
      builder: (context, state) => const PresentationScreen(),
    ),
    GoRoute(
      path: '/theme-changer-screen',
      name: ThemeChangerScreen.appRouterName,
      builder: (context, state) => const ThemeChangerScreen(),
    ),
    GoRoute(
      path: '/fitness',
      name: FitnessScreen.appRouterName,
      builder: (context, state) => const FitnessScreen(),
      routes: [
        GoRoute(
          path: 'display-exercise-screen',
          name: DisplayExerciseScreen.appRouterName,
          builder: (context, state) => const DisplayExerciseScreen(),
          routes: [
            GoRoute(
              path: 'exercise-screen',
              name: ExerciseScreen.appRouterName,
              builder: (context, state) => const ExerciseScreen(),
              routes: [
                GoRoute(
                  path: 'finished-exercise-screen',
                  name: FinishedExerciseScreen.appRouterName,
                  builder: (context, state) => const FinishedExerciseScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
