import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tictac/domain/entities/game_state.dart';
import 'package:tictac/presentation/controllers/game_controller.dart';
import 'package:tictac/presentation/widgets/board_cell.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  String _title(GameState state) {
    return switch (state.result) {
      GameResult.ongoing =>
        'Tour de ${state.currentPlayer == Player.player1 ? 'X' : 'O'}',
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
        ],
      ),
    );
  }
}
