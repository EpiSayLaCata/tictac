import 'package:flutter/material.dart';
import 'package:tictac/features/game/domain/entities/game_state.dart';

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
    final scheme = Theme.of(context).colorScheme;

    final label = switch (value) {
      Player.player1 => 'X',
      Player.player2 => 'O',
      _ => '',
    };

    final isEmpty = value == null;

    final bgColor = isHighlighted
        ? scheme.primaryContainer
        : scheme.surfaceContainerHighest;

    final fgColor = isHighlighted
        ? scheme.onPrimaryContainer
        : scheme.onSurface;

    final markColor = switch (value) {
      Player.player1 => scheme.primary,
      Player.player2 => scheme.tertiary,
      _ => fgColor,
    };

    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: isHighlighted ? 1.03 : 1.0,
      child: Material(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: isHighlighted ? scheme.primary : scheme.outlineVariant,
            width: isHighlighted ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isEmpty ? onTap : null,
          splashColor: scheme.primary.withValues(alpha: 0.12),
          highlightColor: scheme.primary.withValues(alpha: 0.08),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (child, anim) => ScaleTransition(
                scale: anim,
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: Text(
                label,
                key: ValueKey(label),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 56,
                  height: 1,
                  color: markColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
