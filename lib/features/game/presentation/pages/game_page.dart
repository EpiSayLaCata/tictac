import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictac/core/providers/providers.dart';
import 'package:tictac/core/providers/theme_provider.dart';

import 'package:tictac/features/game/domain/entities/game_state.dart';
import 'package:tictac/features/game/presentation/widgets/board_cell.dart';
import 'package:tictac/features/game/presentation/widgets/game_rive_overlay.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  String _title(GameState state) {
    return switch (state.result) {
      GameResult.ongoing =>
        'Tour de ${state.currentPlayer == Player.player1 ? 'Player 1' : 'Player 2'}',
      GameResult.draw => 'Match nul',
      GameResult.player1Won => 'Player 1 a gagné !',
      GameResult.player2Won => 'Player 2 a gagné !',
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameControllerProvider);
    final controller = ref.read(gameControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(_title(state)),
        actions: [
          IconButton(
            onPressed: controller.reset,
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggle();
            },
            icon: Icon(
              ref.watch(themeModeProvider) == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: 9,
                  itemBuilder: (_, i) {
                    return BoardCell(
                      value: state.board[i],
                      isHighlighted: state.winningLine.contains(i),
                      onTap: () => controller.playAt(i),
                    );
                  },
                ),
              ),
            ),
          ),
          const GameRiveOverlay(),
        ],
      ),
    );
  }
}
