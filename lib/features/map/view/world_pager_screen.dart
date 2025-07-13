import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peek_a_pair/core/data/game_data.dart';
import 'package:peek_a_pair/features/map/view/world_map_screen.dart';

import '../../../core/services/storage_service.dart';
import '../widgets/locked_world_widget.dart';

class WorldPagerScreen extends ConsumerStatefulWidget {
  const WorldPagerScreen({super.key});

  @override
  ConsumerState<WorldPagerScreen> createState() => _WorldPagerScreenState();
}

class _WorldPagerScreenState extends ConsumerState<WorldPagerScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We use PageView.builder to create a scrollable list of pages
      body: FutureBuilder(
        // We need the FutureBuilder to access storage
        future: ref.watch(localStorageServiceProvider.future),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final storageService = snapshot.data!;

          return PageView.builder(
            controller: _pageController,
            itemCount: allWorlds.length,
            itemBuilder: (context, index) {
              final currentWorld = allWorlds[index];
              bool isUnlocked = false;

              // The first world is always unlocked
              if (index == 0) {
                isUnlocked = true;
              } else {
                // A world is unlocked if the boss level (level 5) of the PREVIOUS world is completed
                final previousWorld = allWorlds[index - 1];
                final bossLevelId = previousWorld.levels.last.id;
                if (storageService.getLevelStars(bossLevelId) > 0) {
                  isUnlocked = true;
                }
              }

              if (isUnlocked) {
                return WorldMapScreen(theme: currentWorld);
              } else {
                return LockedWorldWidget(
                  worldName: currentWorld.name,
                  unlockRequirement:
                      'Complete the previous world!', // Or get from GDD
                );
              }
            },
          );
        },
      ),
    );
  }
}
