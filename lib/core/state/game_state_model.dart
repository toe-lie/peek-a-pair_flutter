import 'package:peek_a_pair/core/models/card_model.dart';

class GameState {
  final List<CardModel> cards;
  final int moveCount;
  final bool isGameWon;
  final int? moveLimit;
  final bool isGameOver;

  GameState({
    this.cards = const [],
    this.moveCount = 0,
    this.isGameWon = false,
    this.moveLimit,
    this.isGameOver = false,
  });

  GameState copyWith({
    List<CardModel>? cards,
    int? moveCount,
    bool? isGameWon,
    int? moveLimit,
    bool? isGameOver,
  }) {
    return GameState(
      cards: cards ?? this.cards,
      moveCount: moveCount ?? this.moveCount,
      isGameWon: isGameWon ?? this.isGameWon,
      moveLimit: moveLimit ?? this.moveLimit,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }
}
