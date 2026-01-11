import 'package:go_router/go_router.dart';
import 'package:tictac/features/game/presentation/pages/game_page.dart';

class AppRouter {
  static const game = '/';

  static final GoRouter router = GoRouter(
    initialLocation: game,
    routes: [
      GoRoute(path: game, builder: (context, state) => const GamePage()),
    ],
  );
}
