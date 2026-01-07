import 'package:tictac/domain/entities/game_state.dart';
import 'package:tictac/domain/repositories/game_repository.dart';

class ResetGame {
  ResetGame(this._repo);
  final GameRepository _repo;

  GameState call() {
    final s = GameState.initial();
    _repo.save(s);
    return s;
  }
}
