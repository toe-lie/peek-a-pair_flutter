import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peek_a_pair/core/data/game_data.dart';
import 'package:peek_a_pair/features/map/view/world_map_screen.dart';

import '../../../core/services/sound_service.dart';
import '../../../core/services/storage_service.dart';
import '../widgets/locked_world_widget.dart';

class WorldPagerScreen extends ConsumerStatefulWidget {
  const WorldPagerScreen({super.key});

  @override
  ConsumerState<WorldPagerScreen> createState() => _WorldPagerScreenState();
}

class _WorldPagerScreenState extends ConsumerState<WorldPagerScreen>
    with WidgetsBindingObserver {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _playInitialMusic();
  }

  void _playInitialMusic() async {
    await ref.read(soundServiceProvider.future);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ref.read(soundServiceProvider.notifier).playMusic(GameMusic.mainTheme);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final soundNotifier = ref.read(soundServiceProvider.notifier);

    switch (state) {
      case AppLifecycleState.resumed:
        soundNotifier.resumeMusicAfterBackground();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        soundNotifier.stopMusic();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
