import 'package:flutter_test/flutter_test.dart';
import 'package:tictac/features/game/domain/entities/game_state.dart';

void main() {
  group('GameState entity', () {
    test('initial returns empty board and player1 turn', () {
      final s = GameState.initial();

      expect(s.board.length, 9);
      expect(s.board.every((c) => c == null), isTrue);
      expect(s.currentPlayer, Player.player1);
      expect(s.result, GameResult.ongoing);
      expect(s.winningLine, isEmpty);
    });

    test('copyWith replaces provided fields', () {
      final s = GameState.initial();

      final newBoard = List<Player?>.filled(9, Player.player1);
      final s2 = s.copyWith(
        board: newBoard,
        currentPlayer: Player.player2,
        result: GameResult.draw,
        winningLine: [0, 1, 2],
      );

      expect(s2.board, newBoard);
      expect(s2.currentPlayer, Player.player2);
      expect(s2.result, GameResult.draw);
      expect(s2.winningLine, [0, 1, 2]);
    });
  });
}
