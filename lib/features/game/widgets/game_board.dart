import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:peek_a_pair/core/models/theme_model.dart';
import 'package:peek_a_pair/core/state/game_notifier.dart'; // Import our notifier
import 'package:peek_a_pair/features/game/widgets/game_card.dart';
import 'package:peek_a_pair/features/game/widgets/win_dialog_widget.dart';
import 'package:peek_a_pair/utils/color_extensions.dart';

import '../../../core/models/level_model.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/state/game_state_model.dart';
import '../../../core/data/game_data.dart';
import '../view/game_screen.dart';

// Change from StatelessWidget to ConsumerWidget
class GameBoard extends ConsumerStatefulWidget {
  const GameBoard({super.key, required this.level, required this.theme});

  final ThemeModel theme;
  final LevelModel level;

  @override
  ConsumerState<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends ConsumerState<GameBoard> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(gameNotifierProvider.notifier)
          .setupGame(widget.level, widget.theme);
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  int _calculateStars(int moves, int? moveLimit) {
    if (moveLimit == null) return 3; // No limit, 3 stars
    final efficiency = moves / moveLimit;
    if (efficiency <= 1.0) return 3; // Perfect or better
    if (efficiency <= 1.2) return 2; // Close
    return 1; // Completed, but inefficient
  }

  @override
  Widget build(BuildContext context) {
    // Use ref.listen to react to state changes, like showing a dialog
    ref.listen<GameState>(gameNotifierProvider, (previous, next) {
      if (next.isGameWon && !(previous?.isGameWon ?? false)) {
        _confettiController.play(); // Play the confetti!

        final starsEarned = _calculateStars(next.moveCount, next.moveLimit);
        ref.read(localStorageServiceProvider.future).then((service) {
          service.saveLevelProgress(widget.level.id, starsEarned);
        });

        // We add a delay to allow animations to complete before showing the dialog.
        // 800 milliseconds is a good starting point.
        Future.delayed(const Duration(milliseconds: 1200), () {
          // This is a best-practice check. It ensures the widget is still on screen
          // before we try to show a dialog, preventing errors if the user navigates away quickly.
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => WinDialogWidget(
                theme: widget.theme,
                level: widget.level,
                moveCount: next.moveCount,
                starCount: starsEarned,
              ),
            );
          }
        });
      }

      if (next.isGameOver && !(previous?.isGameOver ?? false)) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("Game Over! 😟"),
            content: const Text(
              "You've run out of moves. Better luck next time!",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref
                      .read(gameNotifierProvider.notifier)
                      .setupGame(widget.level, widget.theme);
                },
                child: const Text("Try Again"),
              ),
            ],
          ),
        );
      }
    });

    final gameState = ref.watch(gameNotifierProvider);
    final gameCards = gameState.cards;

    if (gameCards.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AnimationLimiter(
          child: Container(
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white.applyOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 896 / 1344,
              ),
              itemCount: gameCards.length,
              itemBuilder: (BuildContext context, int index) {
                final card = gameCards[index];

                // Wrap each card in animation configuration and widgets
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: 4, // Must match crossAxisCount
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: GameCard(
                        key: ValueKey(card.id),
                        card: card,
                        theme: widget.theme,
                        onTap: () {
                          ref
                              .read(gameNotifierProvider.notifier)
                              .onCardTapped(card.id);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          numberOfParticles: 100,
          emissionFrequency: 0.03,
          maxBlastForce: 25,
          gravity: 0.2,
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple,
          ],
        ),
      ],
    );
  }
}
