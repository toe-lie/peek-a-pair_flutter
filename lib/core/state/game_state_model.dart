import 'package:peek_a_pair/core/models/card_model.dart';

class GameState {
  final List<CardModel> cards;
  final int moveCount;
  final bool isGameWon;

  GameState({
    this.cards = const [],
    this.moveCount = 0,
    this.isGameWon = false,
  });

  GameState copyWith({
    List<CardModel>? cards,
    int? moveCount,
    bool? isGameWon,
  }) {
    return GameState(
      cards: cards ?? this.cards,
      moveCount: moveCount ?? this.moveCount,
      isGameWon: isGameWon ?? this.isGameWon,
    );
  }
}
