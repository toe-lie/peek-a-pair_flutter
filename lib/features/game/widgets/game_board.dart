import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:peek_a_pair/core/state/game_notifier.dart'; // Import our notifier
import 'package:peek_a_pair/features/game/widgets/game_card.dart';

import '../../../core/models/theme_model.dart';
import '../../../core/state/game_state_model.dart';

// Change from StatelessWidget to ConsumerWidget
class GameBoard extends ConsumerStatefulWidget {
  const GameBoard({super.key, required this.theme});
  final ThemeModel theme;

  @override
  ConsumerState<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends ConsumerState<GameBoard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(gameNotifierProvider.notifier)
          .setupGame(widget.theme.cardValues);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use ref.listen to react to state changes, like showing a dialog
    ref.listen<GameState>(gameNotifierProvider, (previous, next) {
      // If the game wasn't won before, but IS won now...
      if (next.isGameWon && !(previous?.isGameWon ?? false)) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("You Win! 🎉"),
            content: Text(
              "You completed the level in ${next.moveCount} moves!",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  ref
                      .read(gameNotifierProvider.notifier)
                      .setupGame(widget.theme.cardValues);
                },
                child: const Text("Play Again"),
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

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: gameCards.length,
      itemBuilder: (BuildContext context, int index) {
        final card = gameCards[index];
        return GameCard(
          key: ValueKey(card.id),
          card: card,
          onTap: () {
            ref.read(gameNotifierProvider.notifier).onCardTapped(card.id);
          },
        );
      },
    );
  }
}
