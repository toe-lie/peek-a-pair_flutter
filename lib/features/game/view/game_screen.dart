import 'package:flutter/material.dart';
import 'package:peek_a_pair/features/game/widgets/game_board.dart';

import '../../../core/models/theme_model.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.theme});
  final ThemeModel theme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title for the game screen
        title: const Text('Forest Friends - Level 1'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // The body of our screen is the GameBoard widget we built earlier
      body: GameBoard(theme: theme),
    );
  }
}
