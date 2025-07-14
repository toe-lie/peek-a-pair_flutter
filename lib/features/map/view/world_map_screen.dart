import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peek_a_pair/features/map/widgets/level_node_widget.dart';

import '../../../core/models/level_model.dart';
import '../../../core/models/theme_model.dart';
import '../../../core/services/sound_service.dart';
import '../../../core/services/storage_service.dart';
import '../../game/view/game_screen.dart';
import '../widgets/path_painter.dart';

class WorldMapScreen extends ConsumerStatefulWidget {
  const WorldMapScreen({super.key, required this.theme});

  final ThemeModel theme;

  @override
  ConsumerState<WorldMapScreen> createState() => _WorldMapScreenState();
}

class _WorldMapScreenState extends ConsumerState<WorldMapScreen> {
  LevelModel? _selectedLevelForCallout;

  @override
  Widget build(BuildContext context) {
    ref.watch(progressUpdatesProvider);
    final storageServiceFuture = ref.watch(localStorageServiceProvider.future);

    return Scaffold(
      body: FutureBuilder(
        future: storageServiceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final storageService = snapshot.data!;

          final List<Offset> unlockedPathPoints = [];
          LevelModel highestUnlockedLevel = widget.theme.levels.first;

          for (final level in widget.theme.levels) {
            final isUnlocked =
                level.levelNumber == 1 ||
                storageService.getLevelStars(
                      widget.theme.levels[level.levelNumber - 2].id,
                    ) >
                    0;

            if (isUnlocked) {
              // Add the center point of the node to our path list
              // We add 40 to account for the node's radius (80 width / 2)
              unlockedPathPoints.add(
                Offset(
                  level.position['left']! + 40,
                  level.position['top']! + 40,
                ),
              );
              highestUnlockedLevel = level;
            }
          }

          return SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Image.asset(
                  widget.theme.worldMapBackgroundAsset,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),

                CustomPaint(
                  painter: PathPainter(points: unlockedPathPoints),
                  size: Size.infinite,
                ),

                ...widget.theme.levels.map((level) {
                  bool isUnlocked = false;
                  if (level.levelNumber == 1) {
                    isUnlocked = true;
                  } else {
                    final previousLevel =
                        widget.theme.levels[level.levelNumber - 2];
                    if (storageService.getLevelStars(previousLevel.id) > 0) {
                      isUnlocked = true;
                    }
                  }

                  return Positioned(
                    top: level.position['top'],
                    left: level.position['left'],
                    child: ThemedLevelNode(
                      levelId: level.id,
                      levelNumber: level.levelNumber,
                      isUnlocked: isUnlocked,
                      unlockedAssetPath: widget.theme.enabledNodeAsset,
                      lockedAssetPath: widget.theme.disabledNodeAsset,
                      onTap: () {
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => GameScreen(
                                  theme: widget.theme,
                                  level: level,
                                ),
                              ),
                            )
                            .then((_) {});
                      },
                    ),
                  );
                }),

                AnimatedPositioned(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOut,
                  top: (highestUnlockedLevel.position['top']! + 40) - 60 - 10,
                  left: (highestUnlockedLevel.position['left']! + 40) - 30,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLevelForCallout = highestUnlockedLevel;
                      });
                    },
                    child: Image.asset(
                      widget.theme.mascotAssetPath,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                  ), // Your Ollie asset
                ),

                if (_selectedLevelForCallout != null)
                  Positioned(
                    // Position the callout above the selected level node
                    top: _selectedLevelForCallout!.position['top']! - 80,
                    left: _selectedLevelForCallout!.position['left']! - 25,
                    child: _buildLevelCallout(
                      context: context,
                      level: _selectedLevelForCallout!,
                    ),
                  ),

                Positioned(
                  left: 0,
                  right: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // The banner image itself
                      Image.asset(widget.theme.headerBannerAsset, height: 80),
                      // The text displayed on top of the banner
                      Text(
                        widget.theme.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5D4037), // A dark brown color
                          // TODO: Add your bubbly font here
                          shadows: [
                            Shadow(
                              blurRadius: 1.0,
                              color: Colors.white70,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: 16,
                  right: 16,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final soundSettings = ref.watch(soundServiceProvider);

                      return soundSettings.when(
                        data: (settings) => IconButton.filledTonal(
                          icon: Icon(
                            settings.isMuted
                                ? Icons.volume_off_rounded
                                : Icons.volume_up_rounded,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const SettingsDialog(),
                            );
                          },
                        ),
                        loading: () => const CircleAvatar(
                          backgroundColor: Colors.transparent,
                        ),
                        error: (_, __) => const CircleAvatar(
                          backgroundColor: Colors.transparent,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLevelCallout({
    required BuildContext context,
    required LevelModel level,
  }) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              level.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                setState(() => _selectedLevelForCallout = null);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        GameScreen(level: level, theme: widget.theme),
                  ),
                );
              },
              child: const Text("Play"),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soundSettings = ref.watch(soundServiceProvider);

    return AlertDialog(
      title: const Text("Settings"),
      content: soundSettings.when(
        data: (settings) => ListTile(
          leading: const Icon(Icons.volume_up_rounded),
          title: const Text("Sound"),
          // The Switch reflects the current state and can toggle it
          trailing: Switch(
            value: !settings.isMuted,
            onChanged: (value) {
              // Call the toggle method in our service
              ref.read(soundServiceProvider.notifier).toggleMute();
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const Text("Error loading settings"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Done"),
        ),
      ],
    );
  }
}
