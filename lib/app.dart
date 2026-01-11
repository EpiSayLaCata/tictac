import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictac/core/router/app_router.dart';
import 'package:tictac/core/theme/app_theme.dart';
import 'package:tictac/core/providers/theme_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      title: 'Tic Tac Toe',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: mode,
    );
  }
}
