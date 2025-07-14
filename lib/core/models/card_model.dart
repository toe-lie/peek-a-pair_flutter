// lib/core/models/card_model.dart

class CardModel {
  // A unique identifier for this specific card instance
  final String id;
  // The value to match with another card (e.g., 'fox', 'owl')
  final String value;
  // The path to the card's face image
  final String imagePath;

  // State properties
  bool isFlipped;
  bool isMatched;

  CardModel({
    required this.id,
    required this.value,
    required this.imagePath,
    this.isFlipped = false,
    this.isMatched = false,
  });

  CardModel copyWith({
    String? id,
    String? value,
    String? imagePath,
    bool? isFlipped,
    bool? isMatched,
  }) {
    return CardModel(
      id: id ?? this.id,
      value: value ?? this.value,
      imagePath: imagePath ?? this.imagePath,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
    );
  }
}
