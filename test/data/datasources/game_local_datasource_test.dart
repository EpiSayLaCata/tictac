import 'package:flutter_test/flutter_test.dart';
import 'package:tictac/features/game/data/datasources/game_local_datasource.dart';
import 'package:tictac/features/game/domain/entities/game_state.dart';

void main() {
  group('GameLocalDataSource', () {
    test('read returns initial state and write updates it', () {
      final ds = GameLocalDataSource();

      final initial = ds.read();
      expect(initial.result, GameResult.ongoing);

      final newState = initial.copyWith(currentPlayer: Player.player2);
      ds.write(newState);

      final after = ds.read();
      expect(after.currentPlayer, Player.player2);
    });
  });
}
