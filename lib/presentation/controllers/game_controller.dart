import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tictac/data/datasources/game_local_datasource.dart';
import 'package:tictac/data/repositories/game_repository_impl.dart';
import 'package:tictac/domain/entities/game_state.dart';
import 'package:tictac/domain/repositories/game_repository.dart';
import 'package:tictac/domain/services/winner_checker.dart';
import 'package:tictac/domain/usecases/get_game_state.dart';
import 'package:tictac/domain/usecases/play_move.dart';
import 'package:tictac/domain/usecases/reset_game.dart';

final localDataSourceProvider = Provider((ref) => GameLocalDataSource());

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  return GameRepositoryImpl(ref.watch(localDataSourceProvider));
});

final winnerCheckerProvider = Provider((ref) => WinnerChecker());

final getGameStateProvider = Provider((ref) => GetGameState(ref.watch(gameRepositoryProvider)));
final playMoveProvider = Provider((ref) => PlayMove(ref.watch(gameRepositoryProvider), ref.watch(winnerCheckerProvider)));
final resetGameProvider = Provider((ref) => ResetGame(ref.watch(gameRepositoryProvider)));

final gameControllerProvider =
    NotifierProvider<GameController, GameState>(GameController.new);

class GameController extends Notifier<GameState> {
  @override
  GameState build() => ref.watch(getGameStateProvider)();

  void playAt(int index) => state = ref.read(playMoveProvider)(index);
  void reset() => state = ref.read(resetGameProvider)();
}
