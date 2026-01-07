import 'package:tictac/domain/entities/game_state.dart';

abstract class GameRepository {
  GameState load();
  void save(GameState state);
}
