import 'package:flutter/material.dart';
import 'package:tictac/domain/entities/game_state.dart';

class BoardCell extends StatelessWidget {
  const BoardCell({
    super.key,
    required this.value,
    required this.onTap,
    required this.isHighlighted,
  });

  final Player? value;
  final VoidCallback onTap;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final label = switch (value) { Player.player1 => 'X', Player.player2 => 'O', _ => '' };

    return Material(
      color: isHighlighted
          ? Colors.black12
          : Colors.amber,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48,),
          ),
        ),
      ),
    );
  }
}
