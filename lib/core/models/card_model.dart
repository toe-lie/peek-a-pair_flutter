// lib/core/models/card_model.dart

class CardModel {
  // A unique identifier for this specific card instance
  final int id;
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
}
