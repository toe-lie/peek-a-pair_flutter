// lib/core/state/game_notifier.dart
import 'dart:async';
import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:peek_a_pair/core/models/card_model.dart';

import '../models/level_model.dart';
import '../models/theme_model.dart';
import '../services/sound_service.dart';
import 'game_state_model.dart'; // Adjust path

part 'game_notifier.g.dart';

@riverpod
class GameNotifier extends _$GameNotifier {
  Timer? _timer;
  Timer? _shuffleTimer;

  @override
  GameState build() {
    ref.onDispose(() {
      _shuffleTimer?.cancel();
      _timer?.cancel();
    });
    return GameState();
  }

  void setupGame(LevelModel level, ThemeModel theme) {
    _timer?.cancel();
    _shuffleTimer?.cancel();

    final cardValues = level.cardValues;
    List<CardModel> newCards = [];

    for (var value in cardValues) {
      final imagePath = 'assets/images/cards/${theme.id}/$value.png';

      newCards.add(
        CardModel(
          id: '${theme.id}_${level.levelNumber}_${value}_1',
          value: value,
          imagePath: imagePath,
        ),
      );
      newCards.add(
        CardModel(
          id: '${theme.id}_${level.levelNumber}_${value}_2',
          value: value,
          imagePath: imagePath,
        ),
      );
    }
    newCards.shuffle(Random());

    // Set the initial game state
    state = GameState(
      cards: newCards,
      moveCount: 0,
      moveLimit: level.moveLimit,
      timerInSeconds: level.timerInSeconds,
      secondsRemaining: level.timerInSeconds,
      isTriplet: level.isTriplet,
      isGameWon: false,
    );

    // If the level has a timer, start the countdown
    if (level.timerInSeconds != null) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        // Use a local variable for the current state to be safe inside the timer.
        final currentState = state;
        final currentTime = currentState.secondsRemaining;

        // Guard against null or game-ending states
        if (currentTime == null ||
            currentState.isGameOver ||
            currentState.isGameWon) {
          _timer?.cancel();
          return;
        }

        if (currentTime > 0) {
          // Log the tick so we can see it in the console
          print('Timer Tick: ${currentTime - 1}');
          state = currentState.copyWith(secondsRemaining: currentTime - 1);
        } else {
          state = currentState.copyWith(isGameOver: true);
          _timer?.cancel();
        }
      });
    }

    // If the level has a shuffle twist, start the shuffle timer
    if (level.hasShuffleTwist) {
      // Start a new timer that fires every 10 seconds
      _shuffleTimer = Timer.periodic(const Duration(seconds: 10), (_) {
        // Get the current game state
        final currentState = state;
        if (currentState.isGameWon || currentState.isGameOver) {
          _shuffleTimer?.cancel();
          return;
        }

        // Find all cards that are valid candidates for shuffling
        final swappableCards = currentState.cards
            .where((card) => !card.isFlipped && !card.isMatched)
            .toList();

        // Only shuffle if there are at least two cards to swap
        if (swappableCards.length >= 2) {
          // Pick two random cards from the swappable list
          final random = Random();
          final index1 = random.nextInt(swappableCards.length);
          int index2;
          do {
            index2 = random.nextInt(swappableCards.length);
          } while (index1 == index2); // Ensure we pick two different cards

          final card1 = swappableCards[index1];
          final card2 = swappableCards[index2];

          print('Shuffling ${card1.value} and ${card2.value}!');

          // Update the state with the IDs of the cards being shuffled.
          state = state.copyWith(
            shuffleState: ShuffleAnimationState(
              cardIds: {card1.id, card2.id},
              phase: ShufflePhase.fadingOut,
            ),
          );

          // Wait for the fade-out animation to finish
          Future.delayed(const Duration(milliseconds: 400), () {
            // Perform the actual data swap
            final originalIndex1 = state.cards.indexWhere(
              (c) => c.id == card1.id,
            );
            final originalIndex2 = state.cards.indexWhere(
              (c) => c.id == card2.id,
            );

            final shuffledCards = List<CardModel>.from(state.cards);
            shuffledCards[originalIndex1] = card2;
            shuffledCards[originalIndex2] = card1;

            // Update state with swapped cards and start Fading In
            state = state.copyWith(
              cards: shuffledCards,
              shuffleState: ShuffleAnimationState(
                cardIds: {card1.id, card2.id},
                phase: ShufflePhase.fadingIn,
              ),
            );
          });

          // Wait a bit longer, then reset the animation state
          Future.delayed(const Duration(milliseconds: 800), () {
            state = state.copyWith(
              shuffleState: ShuffleAnimationState(
                cardIds: {},
                phase: ShufflePhase.none,
              ),
            );
          });
        }
      });
    }
  }

  void onCardTapped(String cardId) {
    if (state.isGameWon || state.isGameOver) return;

    final flippedCards = state.cards
        .where((card) => card.isFlipped && !card.isMatched)
        .toList();
    final tappedCard = state.cards.firstWhere((card) => card.id == cardId);

    if (tappedCard.isMatched ||
        flippedCards.length >= 2 ||
        flippedCards.contains(tappedCard)) {
      return;
    }

    final soundService = ref.read(soundServiceProvider.notifier);
    soundService.playSfx(SoundEffect.flip);

    var newCards = state.cards.map((card) {
      if (card.id == cardId) {
        return CardModel(
          id: card.id,
          value: card.value,
          imagePath: card.imagePath,
          isFlipped: true,
          isMatched: card.isMatched,
        );
      }
      return card;
    }).toList();
    state = state.copyWith(cards: newCards);

    final currentlyFlipped = state.cards
        .where((card) => card.isFlipped && !card.isMatched)
        .toList();

    if (currentlyFlipped.length == 2) {
      // Increment move count when two cards are flipped
      final newMoveCount = state.moveCount + 1;
      state = state.copyWith(moveCount: newMoveCount);

      final card1 = currentlyFlipped[0];
      final card2 = currentlyFlipped[1];

      if (card1.value == card2.value) {
        soundService.playSfx(SoundEffect.match);

        newCards = state.cards.map((card) {
          if (card.id == card1.id || card.id == card2.id) {
            return CardModel(
              id: card.id,
              value: card.value,
              imagePath: card.imagePath,
              isFlipped: true,
              isMatched: true,
            );
          }
          return card;
        }).toList();

        // Check for a win after a successful match
        final isGameWon = newCards.every((card) => card.isMatched);
        if (isGameWon) {
          _timer?.cancel();
          _shuffleTimer?.cancel();
        }
        state = state.copyWith(cards: newCards, isGameWon: isGameWon);
      } else {
        soundService.playSfx(SoundEffect.mismatch);
        Future.delayed(const Duration(milliseconds: 800), () {
          newCards = state.cards.map((card) {
            if (card.id == card1.id || card.id == card2.id) {
              return CardModel(
                id: card.id,
                value: card.value,
                imagePath: card.imagePath,
                isFlipped: false,
                isMatched: false,
              );
            }
            return card;
          }).toList();
          state = state.copyWith(cards: newCards);
        });
      }

      // Check for game over
      if (state.moveLimit != null &&
          newMoveCount >= state.moveLimit! &&
          !state.isGameWon) {
        state = state.copyWith(isGameOver: true);
      }
    }
  }
}
