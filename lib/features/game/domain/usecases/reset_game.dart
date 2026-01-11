import 'package:tictac/features/game/domain/entities/game_state.dart';
import 'package:tictac/features/game/domain/repositories/game_repository.dart';

class ResetGame {
  ResetGame(this._repo);
  final GameRepository _repo;

  GameState call() {
    final s = GameState.initial();
    _repo.save(s);
    return s;
  }
}
