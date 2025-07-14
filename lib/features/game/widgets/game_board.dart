import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:peek_a_pair/core/models/theme_model.dart';
import 'package:peek_a_pair/core/state/game_notifier.dart'; // Import our notifier
import 'package:peek_a_pair/features/game/widgets/game_card.dart';
import 'package:peek_a_pair/features/game/widgets/win_dialog_widget.dart';
import 'package:peek_a_pair/utils/color_extensions.dart';

import '../../../core/models/card_model.dart';
import '../../../core/models/level_model.dart';
import '../../../core/services/sound_service.dart';
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
  // A map to hold a GlobalKey for each card to find its position
  final Map<String, GlobalKey> _cardKeys = {};
  final GlobalKey _stackKey = GlobalKey();

  // A list to hold our "ghost" animating cards
  List<Widget> _overlayCards = [];

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
    final gameState = ref.watch(gameNotifierProvider);
    for (var card in gameState.cards) {
      _cardKeys.putIfAbsent(card.id, () => GlobalKey());
    }

    // Use ref.listen to react to state changes, like showing a dialog
    ref.listen<GameState>(gameNotifierProvider, (previous, next) {
      if (next.shuffleState.cardIds.isNotEmpty &&
          (previous?.shuffleState.cardIds.isEmpty ?? true)) {
        _startShuffleAnimation(next.shuffleState.cardIds);
      }

      if (next.isGameWon && !(previous?.isGameWon ?? false)) {
        _confettiController.play(); // Play the confetti!

        ref.read(soundServiceProvider.notifier).playSfx(SoundEffect.win);

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
        String title = "Game Over! 😟";
        String content = "Better luck next time!";

        if (next.timerInSeconds != null && (next.secondsRemaining ?? 0) <= 0) {
          title = "Time's Up!";
          content = "Be a little quicker next time!";
        } else if (next.moveLimit != null &&
            next.moveCount >= next.moveLimit!) {
          title = "Out of Moves!";
          content = "Be more strategic next time to beat the level!";
        }

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
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

    final gameCards = gameState.cards;
    final isShuffling = gameState.shuffleState.cardIds.isNotEmpty;

    if (gameCards.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      key: _stackKey,
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
                final isVisible =
                    !isShuffling ||
                    !gameState.shuffleState.cardIds.contains(card.id);

                // Wrap each card in animation configuration and widgets
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: 4, // Must match crossAxisCount
                  child: Opacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: GameCard(
                          key: _cardKeys[card.id],
                          card: card,
                          theme: widget.theme,
                          onTap: () {
                            if (isShuffling) return;
                            ref
                                .read(gameNotifierProvider.notifier)
                                .onCardTapped(card.id);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        ..._overlayCards,
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

  void _startShuffleAnimation(Set<String> cardIds) {
    if (cardIds.length != 2) return;

    final id1 = cardIds.first;
    final id2 = cardIds.last;

    final key1 = _cardKeys[id1]!;
    final key2 = _cardKeys[id2]!;

    // Find the RenderBox of our main Stack
    final stackBox = _stackKey.currentContext!.findRenderObject() as RenderBox;

    // Find the positions of the two cards relative to the screen
    final box1 = key1.currentContext!.findRenderObject() as RenderBox;
    final box2 = key2.currentContext!.findRenderObject() as RenderBox;
    final globalPos1 = box1.localToGlobal(Offset.zero);
    final globalPos2 = box2.localToGlobal(Offset.zero);

    final size1 = box1.size;
    final size2 = box2.size;

    // Convert the global positions into local positions relative to our Stack
    final localPos1 = stackBox.globalToLocal(globalPos1);
    final localPos2 = stackBox.globalToLocal(globalPos2);

    final cardModel1 = ref
        .read(gameNotifierProvider)
        .cards
        .firstWhere((c) => c.id == id1);
    final cardModel2 = ref
        .read(gameNotifierProvider)
        .cards
        .firstWhere((c) => c.id == id2);

    setState(() {
      _overlayCards = [
        _buildGhostCard(cardModel1, localPos1, size1),
        _buildGhostCard(cardModel2, localPos2, size2),
      ];
    });

    // After a tiny delay, update the state again to trigger the animation
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _overlayCards = [
          _buildGhostCard(cardModel1, localPos2, size1),
          _buildGhostCard(cardModel2, localPos1, size2),
        ];
      });
    });

    // After the animation, finalize the swap
    Future.delayed(const Duration(milliseconds: 700), () {
      ref.read(gameNotifierProvider.notifier).finalizeShuffle(id1, id2);
      setState(() {
        _overlayCards = [];
      });
    });
  }

  Widget _buildGhostCard(CardModel card, Offset position, Size size) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      top: position.dy,
      left: position.dx,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: GameCard(card: card, theme: widget.theme, onTap: () {}),
      ),
    );
  }
}
