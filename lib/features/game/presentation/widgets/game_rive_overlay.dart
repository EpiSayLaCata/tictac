import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

import 'package:tictac/core/providers/providers.dart';
import 'package:tictac/features/game/domain/entities/game_state.dart';
import 'package:tictac/core/assets/app_assets.dart';

class GameRiveOverlay extends ConsumerStatefulWidget {
  const GameRiveOverlay({super.key});

  @override
  ConsumerState<GameRiveOverlay> createState() => _GameRiveOverlayState();
}

class _GameRiveOverlayState extends ConsumerState<GameRiveOverlay> {
  File? _file;
  RiveWidgetController? _controller;

  bool get _isInitialized => _controller != null;

  @override
  void initState() {
    super.initState();
    _initRive();
  }

  Future<void> _initRive() async {
    final file = await File.asset(
      AppAssets.winAnimation,
      riveFactory: Factory.rive,
    );

    if (file == null) return;

    final controller = RiveWidgetController(file);

    if (!mounted) return;
    setState(() {
      _file = file;
      _controller = controller;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _file?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(gameControllerProvider.select((s) => s.result));

    final isWin =
        result == GameResult.player1Won || result == GameResult.player2Won;

    if (!isWin) {
      return const SizedBox.shrink();
    }

    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return IgnorePointer(
      ignoring: true,
      child: Center(
        child: SizedBox(
          height: 240,
          width: 240,
          child: RiveWidget(
            controller: _controller!,
            fit: Fit.contain,
            key: ValueKey(result),
          ),
        ),
      ),
    );
  }
}
