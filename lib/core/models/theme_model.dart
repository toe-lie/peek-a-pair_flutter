import 'package:peek_a_pair/core/models/level_model.dart';

class ThemeModel {
  final String id;
  final String name;
  final String emoji;
  final List<LevelModel> levels;

  final String worldMapBackgroundAsset;
  final String gameScreenBackgroundAsset;
  final String headerBannerAsset;
  final String enabledNodeAsset;
  final String disabledNodeAsset;
  final String cardBackAsset;
  final String mascotAssetPath;

  ThemeModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.levels,
    required this.worldMapBackgroundAsset,
    required this.gameScreenBackgroundAsset,
    required this.headerBannerAsset,
    required this.enabledNodeAsset,
    required this.disabledNodeAsset,
    required this.cardBackAsset,
    required this.mascotAssetPath,
  });
}
