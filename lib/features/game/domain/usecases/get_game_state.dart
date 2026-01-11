import 'package:tictac/features/game/domain/entities/game_state.dart';
import 'package:tictac/features/game/domain/repositories/game_repository.dart';

class GetGameState {
  GetGameState(this._repo);
  final GameRepository _repo;

  GameState call() => _repo.load();
}
