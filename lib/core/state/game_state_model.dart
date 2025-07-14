import 'package:peek_a_pair/core/models/card_model.dart';

enum ShufflePhase { none, fadingOut, fadingIn }

class ShuffleAnimationState {
  final Set<String> cardIds;
  final ShufflePhase phase;

  const ShuffleAnimationState({required this.cardIds, required this.phase});
}

class GameState {
  final List<CardModel> cards;
  final int moveCount;
  final bool isGameWon;
  final int? moveLimit;
  final int? timerInSeconds;
  final int? secondsRemaining;
  final bool isTriplet;
  final bool isGameOver;
  final ShuffleAnimationState shuffleState;

  GameState({
    this.cards = const [],
    this.moveCount = 0,
    this.isGameWon = false,
    this.moveLimit,
    this.timerInSeconds,
    this.secondsRemaining,
    this.isTriplet = false,
    this.isGameOver = false,
    this.shuffleState = const ShuffleAnimationState(
      cardIds: {},
      phase: ShufflePhase.none,
    ),
  });

  GameState copyWith({
    List<CardModel>? cards,
    int? moveCount,
    bool? isGameWon,
    int? moveLimit,
    int? timerInSeconds,
    int? secondsRemaining,
    bool? isTriplet,
    bool? isGameOver,
    ShuffleAnimationState? shuffleState,
  }) {
    return GameState(
      cards: cards ?? this.cards,
      moveCount: moveCount ?? this.moveCount,
      isGameWon: isGameWon ?? this.isGameWon,
      moveLimit: moveLimit ?? this.moveLimit,
      timerInSeconds: timerInSeconds ?? this.timerInSeconds,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      isTriplet: isTriplet ?? this.isTriplet,
      isGameOver: isGameOver ?? this.isGameOver,
      shuffleState: shuffleState ?? this.shuffleState,
    );
  }
}
