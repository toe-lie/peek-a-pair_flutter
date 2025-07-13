import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peek_a_pair/utils/color_extensions.dart';

import '../../../core/services/storage_service.dart';

class LevelNode extends StatelessWidget {
  final int levelNumber;
  final bool isUnlocked;
  final VoidCallback onTap;
  final int starCount;

  const LevelNode({
    super.key,
    required this.levelNumber,
    required this.isUnlocked,
    required this.onTap,
    this.starCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUnlocked ? onTap : null, // Only tappable if unlocked
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: isUnlocked
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade700,
            child: Text(
              levelNumber.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (true) // Only show stars if the level is unlocked
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return Icon(
                  index < starCount
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  color: Colors.amber,
                  size: 20,
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class ThemedLevelNode extends ConsumerWidget {
  final String levelId;
  final int levelNumber;
  final bool isUnlocked;
  final VoidCallback onTap;
  final String unlockedAssetPath;
  final String lockedAssetPath;

  const ThemedLevelNode({
    super.key,
    required this.levelId,
    required this.levelNumber,
    required this.isUnlocked,
    required this.onTap,
    required this.unlockedAssetPath,
    required this.lockedAssetPath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storageService = ref.watch(localStorageServiceProvider);

    final imageToShow = isUnlocked ? unlockedAssetPath : lockedAssetPath;
    final textColor = isUnlocked ? Colors.white : Colors.grey.shade400;

    return storageService.when(
      data: (service) {
        return StreamBuilder(
          stream: service.watchLevelStars(levelId),
          builder: (context, snapshot) {
            final starCount = snapshot.data ?? 0;
            return GestureDetector(
              onTap: isUnlocked ? onTap : null,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape
                      .circle, // Assuming your node is mostly circular for the glow
                  boxShadow: [
                    // This is the "Outer Glow" to separate the node from the background
                    BoxShadow(
                      color: Colors.white.applyOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                    // This is the "Drop Shadow" to give the node a sense of depth
                    BoxShadow(
                      color: Colors.black.applyOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // The custom image for the node
                    Image.asset(imageToShow, width: 80, height: 80),
                    // The level number
                    Text(
                      levelNumber.toString(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(blurRadius: 2.0, color: Colors.black54),
                        ],
                      ),
                    ),
                    // The stars, positioned below the node
                    Positioned(
                      bottom: 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(3, (index) {
                          return Icon(
                            index < starCount
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            color: Colors.amber,
                            size: 18,
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => const Icon(Icons.error),
    );
  }
}
