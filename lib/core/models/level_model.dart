class LevelModel {
  final String id;
  final int levelNumber;
  final String name;
  final List<String> cardValues;
  final Map<String, double> position;
  final int? moveLimit;
  final int? timerInSeconds;
  final bool isTriplet;
  final bool hasShuffleTwist;
  final bool hasFlickerTwist;

  LevelModel({
    required this.id,
    required this.levelNumber,
    required this.name,
    required this.cardValues,
    required this.position,
    this.moveLimit,
    this.timerInSeconds,
    this.isTriplet = false,
    this.hasShuffleTwist = false,
    this.hasFlickerTwist = false,
  });
}
