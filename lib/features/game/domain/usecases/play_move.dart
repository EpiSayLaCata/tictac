import 'package:tictac/features/game/domain/entities/game_state.dart';
import 'package:tictac/features/game/domain/repositories/game_repository.dart';
import 'package:tictac/features/game/domain/services/winner_checker.dart';

class PlayMove {
  PlayMove(this._repo, this._winnerChecker);

  final GameRepository _repo;
  final WinnerChecker _winnerChecker;

  GameState call(int index) {
    final state = _repo.load();
    if (state.result != GameResult.ongoing) return state;
    if (state.board[index] != null) return state;

    final newBoard = List<Player?>.of(state.board);
    newBoard[index] = state.currentPlayer;

    final check = _winnerChecker.evaluate(newBoard);

    final nextState = (check.result != GameResult.ongoing)
        ? state.copyWith(
            board: newBoard,
            result: check.result,
            winningLine: check.line,
          )
        : state.copyWith(
            board: newBoard,
            currentPlayer: state.currentPlayer == Player.player1
                ? Player.player2
                : Player.player1,
            result: GameResult.ongoing,
            winningLine: const [],
          );

    _repo.save(nextState);
    return nextState;
  }
}
