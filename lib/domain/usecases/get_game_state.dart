import 'package:tictac/domain/entities/game_state.dart';
import 'package:tictac/domain/repositories/game_repository.dart';

class GetGameState {
  GetGameState(this._repo);
  final GameRepository _repo;

  GameState call() => _repo.load();
}
