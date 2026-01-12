import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictac/features/game/domain/entities/game_state.dart';
import 'package:tictac/features/game/presentation/widgets/board_cell.dart';

void main() {
  testWidgets(
    'BoardCell shows X for Player.player1 and blocks tap when filled',
    (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BoardCell(
              value: Player.player1,
              isHighlighted: false,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('X'), findsOneWidget);

      await tester.pump();
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();
      expect(tapped, isFalse);
    },
  );

  testWidgets('BoardCell empty calls onTap', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BoardCell(
            value: null,
            isHighlighted: false,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.text(''), findsOneWidget);

    await tester.pump();
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();
    expect(tapped, isTrue);
  });
}
