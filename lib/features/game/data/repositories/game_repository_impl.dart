import 'package:tictac/features/game/domain/entities/game_state.dart';
import 'package:tictac/features/game/domain/repositories/game_repository.dart';
import 'package:tictac/features/game/data/datasources/game_local_datasource.dart';

class GameRepositoryImpl implements GameRepository {
  GameRepositoryImpl(this._ds);
  final GameLocalDataSource _ds;

  @override
  GameState load() => _ds.read();

  @override
  void save(GameState state) => _ds.write(state);
}
