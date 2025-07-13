// lib/core/state/game_notifier.dart
import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:peek_a_pair/core/models/card_model.dart';

import '../models/level_model.dart';
import '../models/theme_model.dart';
import 'game_state_model.dart'; // Adjust path

part 'game_notifier.g.dart';

// This creates a provider that we can access from our UI
@riverpod
class GameNotifier extends _$GameNotifier {
  @override
  GameState build() {
    return GameState();
  }

  void setupGame(LevelModel level, ThemeModel theme) {
    final cardValues = level.cardValues;
    List<CardModel> newCards = [];
    int cardId = 0;

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
      isGameWon: false,
    );
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

      if (state.moveLimit != null &&
          newMoveCount >= state.moveLimit! &&
          !state.isGameWon) {
        state = state.copyWith(isGameOver: true);
      }
    }
  }
}
