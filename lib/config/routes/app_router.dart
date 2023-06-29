import 'package:go_router/go_router.dart';
import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: '',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/fitness',
      name: 'fitness',
      builder: (context, state) => const FitnessScreen(),
      routes: [
        GoRoute(
          path: 'display-exercise-screen',
          name: 'DisplayExerciseScreen',
          builder: (context, state) => const DisplayExerciseScreen(),
          routes: [
            GoRoute(
              path: 'exercise-screen',
              name: 'ExerciseScreen',
              builder: (context, state) => const ExerciseScreen(),
              routes: [
                GoRoute(
                  path: 'finished-exercise-screen',
                  name: 'FinishedExerciseScreen',
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
