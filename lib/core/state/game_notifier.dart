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
  Timer? _levelTimer;
  Timer? _shuffleTimer;

  @override
  GameState build() {
    ref.onDispose(() {
      _shuffleTimer?.cancel();
      _levelTimer?.cancel();
    });
    return GameState();
  }

  void setupGame(LevelModel level, ThemeModel theme) {
    _levelTimer?.cancel();
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
      _levelTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        // Use a local variable for the current state to be safe inside the timer.
        final currentState = state;
        final currentTime = currentState.secondsRemaining;

        // Guard against null or game-ending states
        if (currentTime == null ||
            currentState.isGameOver ||
            currentState.isGameWon) {
          _levelTimer?.cancel();
          return;
        }

        if (currentTime > 0) {
          // Log the tick so we can see it in the console
          print('Timer Tick: ${currentTime - 1}');
          state = currentState.copyWith(secondsRemaining: currentTime - 1);
        } else {
          state = currentState.copyWith(isGameOver: true);
          _levelTimer?.cancel();
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

          state = state.copyWith(
            shuffleState: ShuffleAnimationState(cardIds: {card1.id, card2.id}),
          );
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

    final maxFlipped = state.isTriplet ? 3 : 2;
    if (tappedCard.isMatched ||
        flippedCards.length >= maxFlipped ||
        flippedCards.contains(tappedCard)) {
      return;
    }

    // Play flip sound
    final soundService = ref.read(soundServiceProvider.notifier);
    soundService.playSfx(SoundEffect.flip);

    // Flip the tapped card
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

    if (currentlyFlipped.length == maxFlipped) {
      // Increment move count when two cards are flipped
      final newMoveCount = state.moveCount + 1;
      state = state.copyWith(moveCount: newMoveCount);

      final card1 = currentlyFlipped[0];
      final card2 = currentlyFlipped[1];

      bool isMatch = false;
      if (state.isTriplet) {
        // --- Triplet Matching Logic ---
        final card1 = currentlyFlipped[0];
        final card2 = currentlyFlipped[1];
        final card3 = currentlyFlipped[2];
        isMatch = (card1.value == card2.value) && (card2.value == card3.value);
      } else {
        // --- Pair Matching Logic
        final card1 = currentlyFlipped[0];
        final card2 = currentlyFlipped[1];
        isMatch = card1.value == card2.value;
      }

      if (isMatch) {
        soundService.playSfx(SoundEffect.match);
        final matchedIds = currentlyFlipped.map((c) => c.id).toSet();
        newCards = state.cards.map((card) {
          if (matchedIds.contains(card.id)) {
            return card.copyWith(isMatched: true);
          }
          return card;
        }).toList();

        final isGameWon = newCards.every((card) => card.isMatched);
        if (isGameWon) {
          _levelTimer?.cancel();
          _shuffleTimer?.cancel();
        }
        state = state.copyWith(cards: newCards, isGameWon: isGameWon);
      } else {
        soundService.playSfx(SoundEffect.mismatch);
        final flippedIds = currentlyFlipped.map((c) => c.id).toSet();
        Future.delayed(const Duration(milliseconds: 1000), () {
          final currentCards = state.cards;
          final flippedBackCards = currentCards.map((card) {
            if (flippedIds.contains(card.id)) {
              return card.copyWith(isFlipped: false);
            }
            return card;
          }).toList();
          state = state.copyWith(cards: flippedBackCards);
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

  void finalizeShuffle(String id1, String id2) {
    final originalIndex1 = state.cards.indexWhere((c) => c.id == id1);
    final originalIndex2 = state.cards.indexWhere((c) => c.id == id2);

    if (originalIndex1 == -1 || originalIndex2 == -1) return; // Safety check

    final shuffledCards = List<CardModel>.from(state.cards);
    final card1 = state.cards[originalIndex1];
    final card2 = state.cards[originalIndex2];
    shuffledCards[originalIndex1] = card2;
    shuffledCards[originalIndex2] = card1;

    // Update state with shuffled cards and clear the animation state
    state = state.copyWith(
      cards: shuffledCards,
      shuffleState: const ShuffleAnimationState(cardIds: {}),
    );
  }
}
