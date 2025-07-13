import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peek_a_pair/core/data/game_data.dart';
import 'package:peek_a_pair/core/models/level_model.dart';
import 'package:peek_a_pair/core/state/game_notifier.dart';
import 'package:peek_a_pair/features/game/view/game_screen.dart';

import '../../../core/models/theme_model.dart';

class WinDialogWidget extends ConsumerStatefulWidget {
  final ThemeModel theme;
  final LevelModel level;
  final int moveCount;
  final int starCount;

  const WinDialogWidget({
    super.key,
    required this.theme,
    required this.level,
    required this.moveCount,
    required this.starCount,
  });

  @override
  ConsumerState<WinDialogWidget> createState() => _WinDialogWidgetState();
}

class _WinDialogWidgetState extends ConsumerState<WinDialogWidget> {
  Timer? _timer;
  int _secondsRemaining = 5;

  @override
  void initState() {
    super.initState();
    // Start a periodic timer when the dialog is created
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 1) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        // When the timer hits 0, cancel it and navigate to the next level
        timer.cancel();
        _navigateToNextLevel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // ALWAYS cancel timers to prevent memory leaks
    super.dispose();
  }

  void _navigateToNextLevel() {
    final currentWorld = allWorlds.firstWhere(
      (world) => world.levels.contains(widget.level),
    );
    final currentLevelIndex = currentWorld.levels.indexOf(widget.level);

    if (currentLevelIndex < currentWorld.levels.length - 1) {
      final nextLevel = currentWorld.levels[currentLevelIndex + 1];

      // Pop the dialog and navigate to the next level
      Navigator.of(context).pop();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              GameScreen(level: nextLevel, theme: widget.theme),
        ),
      );
    } else {
      Navigator.of(context).pop(); // Close dialog
      Navigator.of(context).pop(); // Go back to map
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          "Level Complete!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Icon(
                index < widget.starCount
                    ? Icons.star_rounded
                    : Icons.star_border_rounded,
                color: Colors.amber,
                size: 40,
              );
            }),
          ),
          const SizedBox(height: 16),
          Text("You did it in ${widget.moveCount} moves!"),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton.filledTonal(
              icon: const Icon(Icons.replay),
              onPressed: () {
                _timer?.cancel(); // Stop the timer
                Navigator.of(context).pop();
                ref
                    .read(gameNotifierProvider.notifier)
                    .setupGame(widget.level, widget.theme);
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow_rounded),
              // Show the countdown in the button label
              label: Text("Next ($_secondsRemaining)"),
              onPressed: () {
                _timer?.cancel(); // Stop the timer
                _navigateToNextLevel();
              },
            ),
            IconButton.filledTonal(
              icon: const Icon(Icons.map_rounded),
              onPressed: () {
                _timer?.cancel(); // Stop the timer
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
