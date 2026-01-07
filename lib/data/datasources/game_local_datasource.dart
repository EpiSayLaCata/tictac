import 'package:tictac/domain/entities/game_state.dart';

class GameLocalDataSource {
  GameState _state = GameState.initial();

  GameState read() => _state;
  void write(GameState state) => _state = state;
}
