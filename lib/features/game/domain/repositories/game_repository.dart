import 'package:tictac/features/game/domain/entities/game_state.dart';

abstract class GameRepository {
  GameState load();
  void save(GameState state);
}
