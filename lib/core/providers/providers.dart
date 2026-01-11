import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tictac/features/game/data/datasources/game_local_datasource.dart';
import 'package:tictac/features/game/data/repositories/game_repository_impl.dart';

import 'package:tictac/features/game/domain/entities/game_state.dart';
import 'package:tictac/features/game/domain/repositories/game_repository.dart';
import 'package:tictac/features/game/domain/services/winner_checker.dart';
import 'package:tictac/features/game/domain/usecases/get_game_state.dart';
import 'package:tictac/features/game/domain/usecases/play_move.dart';
import 'package:tictac/features/game/domain/usecases/reset_game.dart';

import 'package:tictac/features/game/presentation/controllers/game_controller.dart';

final gameLocalDataSourceProvider = Provider<GameLocalDataSource>(
  (ref) => GameLocalDataSource(),
);

final gameRepositoryProvider = Provider<GameRepository>(
  (ref) => GameRepositoryImpl(ref.watch(gameLocalDataSourceProvider)),
);

final winnerCheckerProvider = Provider<WinnerChecker>((ref) => WinnerChecker());

final getGameStateProvider = Provider<GetGameState>(
  (ref) => GetGameState(ref.watch(gameRepositoryProvider)),
);

final playMoveProvider = Provider<PlayMove>(
  (ref) => PlayMove(
    ref.watch(gameRepositoryProvider),
    ref.watch(winnerCheckerProvider),
  ),
);

final resetGameProvider = Provider<ResetGame>(
  (ref) => ResetGame(ref.watch(gameRepositoryProvider)),
);

final gameControllerProvider = NotifierProvider<GameController, GameState>(
  GameController.new,
);
