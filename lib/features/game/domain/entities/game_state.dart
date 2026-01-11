enum Player { player1, player2 }

enum GameResult { ongoing, draw, player1Won, player2Won }

class GameState {
  const GameState({
    required this.board,
    required this.currentPlayer,
    required this.result,
    required this.winningLine,
  });

  final List<Player?> board;
  final Player currentPlayer;
  final GameResult result;
  final List<int> winningLine;

  factory GameState.initial() => const GameState(
    board: [null, null, null, null, null, null, null, null, null],
    currentPlayer: Player.player1,
    result: GameResult.ongoing,
    winningLine: <int>[],
  );

  GameState copyWith({
    List<Player?>? board,
    Player? currentPlayer,
    GameResult? result,
    List<int>? winningLine,
  }) {
    return GameState(
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      result: result ?? this.result,
      winningLine: winningLine ?? this.winningLine,
    );
  }
}
