class ThemeModel {
  final String id;
  final String name;
  final String emoji;
  final List<String> cardValues; // e.g., ['fox', 'bear', 'deer']

  ThemeModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.cardValues,
  });
}
