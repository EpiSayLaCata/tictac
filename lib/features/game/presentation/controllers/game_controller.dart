import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictac/core/providers/providers.dart';
import 'package:tictac/features/game/domain/entities/game_state.dart';

class GameController extends Notifier<GameState> {
  @override
  GameState build() => ref.watch(getGameStateProvider)();

  void playAt(int index) => state = ref.read(playMoveProvider)(index);
  void reset() => state = ref.read(resetGameProvider)();
}
