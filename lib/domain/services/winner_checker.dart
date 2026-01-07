import 'package:tictac/domain/entities/game_state.dart';

class WinnerCheck {
  const WinnerCheck({required this.result, required this.line});
  final GameResult result;
  final List<int> line;
}

class WinnerChecker {
  static const _lines = <List<int>>[
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  WinnerCheck evaluate(List<Player?> board) {
    for (final line in _lines) {
      final a = board[line[0]];
      final b = board[line[1]];
      final c = board[line[2]];
      if (a != null && a == b && b == c) {
        return WinnerCheck(
          result: a == Player.player1 ? GameResult.player1Won : GameResult.player2Won,
          line: line,
        );
      }
    }

    final isDraw = board.every((cell) => cell != null);
    return WinnerCheck(
      result: isDraw ? GameResult.draw : GameResult.ongoing,
      line: const <int>[],
    );
  }
}
