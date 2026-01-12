import 'package:flutter_test/flutter_test.dart';
import 'package:tictac/features/game/domain/entities/game_state.dart';
import 'package:tictac/features/game/domain/services/winner_checker.dart';
import 'package:tictac/features/game/domain/usecases/play_move.dart';
import 'package:tictac/features/game/domain/repositories/game_repository.dart';

class FakeRepo implements GameRepository {
  FakeRepo(this._state);

  GameState _state;
  final saved = <GameState>[];

  @override
  GameState load() => _state;

  @override
  void save(GameState state) {
    saved.add(state);
    _state = state;
  }
}

void main() {
  group('PlayMove usecase', () {
    test('playing on occupied cell returns same state and does not save', () {
      final initial = GameState.initial();
      final board = List<Player?>.of(initial.board);
      board[0] = Player.player2; // occupied
      final state = initial.copyWith(board: board);

      final repo = FakeRepo(state);
      final usecase = PlayMove(repo, WinnerChecker());

      final res = usecase(0);

      expect(res, state);
      expect(repo.saved, isEmpty);
    });

    test('successful move updates board and toggles player and saves', () {
      final repo = FakeRepo(GameState.initial());
      final usecase = PlayMove(repo, WinnerChecker());

      final res = usecase(0);

      expect(res.board[0], Player.player1);
      expect(res.currentPlayer, Player.player2);
      expect(res.result, GameResult.ongoing);
      expect(repo.saved, isNotEmpty);
      expect(repo.load().board[0], Player.player1);
    });

    test('winning move results in win and sets winningLine', () {
      final board = <Player?>[
        Player.player1,
        Player.player1,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      ];

      final repo = FakeRepo(GameState.initial().copyWith(board: board));
      final usecase = PlayMove(repo, WinnerChecker());

      final res = usecase(2);

      expect(res.result, GameResult.player1Won);
      expect(res.winningLine, containsAll(<int>[0, 1, 2]));
      expect(repo.saved, isNotEmpty);
    });
  });
}
