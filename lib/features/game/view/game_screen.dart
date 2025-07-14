import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peek_a_pair/features/game/widgets/game_board.dart';
import 'package:peek_a_pair/utils/color_extensions.dart';

import '../../../core/models/level_model.dart';
import '../../../core/models/theme_model.dart';
import '../../../core/services/sound_service.dart';
import '../../../core/state/game_notifier.dart';
import '../../../core/state/game_state_model.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key, required this.theme, required this.level});

  final ThemeModel theme;
  final LevelModel level;

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  SoundService? _soundService;

  @override
  void initState() {
    super.initState();
    _soundService = ref.read(soundServiceProvider.notifier);
    _soundService?.setMusicVolume(0.3);
  }

  @override
  void dispose() {
    _soundService?.setMusicVolume(1.0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameNotifierProvider);
    final soundServiceAsync = ref.watch(soundServiceProvider);

    return soundServiceAsync.when(
      data: (_) {
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                widget.theme.gameScreenBackgroundAsset,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              SafeArea(
                child: Column(
                  children: [
                    _buildGameHud(context, gameState),
                    Expanded(
                      child: GameBoard(
                        level: widget.level,
                        theme: widget.theme,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      // The loading callback provides a UI to show while the Future is running.
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      // The error callback provides a UI to show if the Future fails.
      error: (err, stack) =>
          Scaffold(body: Center(child: Text("Error loading sounds: $err"))),
    );
  }

  // A new widget for your HUD
  Widget _buildGameHud(BuildContext context, GameState gameState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          CircleAvatar(
            backgroundColor: Colors.black.applyOpacity(0.3),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // Move Counter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.applyOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.swap_horiz_rounded, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  // Display the limit if it exists
                  gameState.moveLimit != null
                      ? '${gameState.moveCount} / ${gameState.moveLimit} Moves'
                      : '${gameState.moveCount} Moves',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Conditionally display the timer if the level has one
          if (gameState.timerInSeconds != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.applyOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer_rounded, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    '${gameState.secondsRemaining ?? '--'}s',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
