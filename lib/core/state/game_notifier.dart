// lib/core/state/game_notifier.dart
import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:peek_a_pair/core/models/card_model.dart';

import 'game_state_model.dart'; // Adjust path

part 'game_notifier.g.dart';

// This creates a provider that we can access from our UI
@riverpod
class GameNotifier extends _$GameNotifier {
  @override
  GameState build() {
    return GameState();
  }

  void setupGame(List<String> cardValues) {
    List<CardModel> newCards = [];
    int cardId = 0;

    for (var value in cardValues) {
      newCards.add(
        CardModel(
          id: cardId++,
          value: value,
          imagePath: 'assets/images/forest-friends/$value.png',
        ),
      );
      newCards.add(
        CardModel(
          id: cardId++,
          value: value,
          imagePath: 'assets/images/forest-friends/$value.png',
        ),
      );
    }
    newCards.shuffle(Random());

    // Set the initial game state
    state = GameState(cards: newCards, moveCount: 0, isGameWon: false);
  }

  void onCardTapped(int cardId) {
    // If the game is already won, do nothing
    if (state.isGameWon) return;

    final flippedCards = state.cards
        .where((card) => card.isFlipped && !card.isMatched)
        .toList();
    final tappedCard = state.cards.firstWhere((card) => card.id == cardId);

    if (tappedCard.isMatched ||
        flippedCards.length >= 2 ||
        flippedCards.contains(tappedCard)) {
      return;
    }

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
      state = state.copyWith(moveCount: state.moveCount + 1);

      final card1 = currentlyFlipped[0];
      final card2 = currentlyFlipped[1];

      if (card1.value == card2.value) {
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
        state = state.copyWith(cards: newCards, isGameWon: isGameWon);
      } else {
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
    }
  }
}
