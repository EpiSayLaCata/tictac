import 'package:flutter_test/flutter_test.dart';
import 'package:tictac/features/game/domain/entities/game_state.dart';
import 'package:tictac/features/game/domain/services/winner_checker.dart';

void main() {
  group('WinnerChecker', () {
    final checker = WinnerChecker();

    test('detects player1 row win', () {
      final board = List<Player?>.filled(9, null);
      board[0] = Player.player1;
      board[1] = Player.player1;
      board[2] = Player.player1;

      final res = checker.evaluate(board);

      expect(res.result, GameResult.player1Won);
      expect(res.line, containsAll(<int>[0, 1, 2]));
    });

    test('detects player2 diagonal win', () {
      final board = List<Player?>.filled(9, null);
      board[2] = Player.player2;
      board[4] = Player.player2;
      board[6] = Player.player2;

      final res = checker.evaluate(board);

      expect(res.result, GameResult.player2Won);
      expect(res.line, containsAll(<int>[2, 4, 6]));
    });

    test('detects draw', () {
      final board = <Player?>[
        Player.player1,
        Player.player1,
        Player.player2,
        Player.player2,
        Player.player2,
        Player.player1,
        Player.player1,
        Player.player2,
        Player.player1,
      ];

      final res = checker.evaluate(board);

      expect(res.result, GameResult.draw);
      expect(res.line, isEmpty);
    });

    test('ongoing when no win or draw', () {
      final board = List<Player?>.filled(9, null);
      board[0] = Player.player1;

      final res = checker.evaluate(board);

      expect(res.result, GameResult.ongoing);
      expect(res.line, isEmpty);
    });
  });
}
