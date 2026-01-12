import 'package:flutter_test/flutter_test.dart';
import 'package:tictac/features/game/data/datasources/game_local_datasource.dart';
import 'package:tictac/features/game/data/repositories/game_repository_impl.dart';
import 'package:tictac/features/game/domain/entities/game_state.dart';

void main() {
  group('GameRepositoryImpl', () {
    test('load delegates to datasource.read and save delegates to write', () {
      final ds = GameLocalDataSource();
      final repo = GameRepositoryImpl(ds);

      final initial = repo.load();
      expect(initial, isA<GameState>());

      final newState = initial.copyWith(currentPlayer: Player.player2);
      repo.save(newState);

      final after = ds.read();
      expect(after.currentPlayer, Player.player2);
    });
  });
}
