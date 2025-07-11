import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peek_a_pair/core/models/theme_model.dart';
import 'package:peek_a_pair/features/game/view/game_screen.dart';

import '../../../core/services/storage_service.dart';

class ThemeSelectionScreen extends StatelessWidget {
  ThemeSelectionScreen({super.key});

  // A list of all available themes, based on your GDD
  final List<ThemeModel> themes = [
    ThemeModel(
      id: 'forest-friends',
      name: 'Forest Friends',
      emoji: '🌲',
      cardValues: ['fox', 'bear', 'deer', 'owl', 'rabbit', 'squirrel'],
    ),
    ThemeModel(
      id: 'sweet-street',
      name: 'Sweet Street',
      emoji: '🍰',
      cardValues: ['cake', 'cupcake', 'donut', 'ice-cream', 'pie', 'cookie'],
    ),
    ThemeModel(
      id: 'night-sky',
      name: 'Night Sky',
      emoji: '🚀',
      cardValues: ['rocket', 'alien', 'star', 'moon', 'planet', 'comet'],
    ),
    // TODO: Add the rest of the themes from your GDD
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a World')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: themes.length,
        itemBuilder: (context, index) {
          final theme = themes[index];
          return _ThemeCard(theme: theme);
        },
      ),
    );
  }
}

// A private helper widget to display each theme card
class _ThemeCard extends ConsumerWidget {
  const _ThemeCard({required this.theme});
  final ThemeModel theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: Text(theme.emoji, style: const TextStyle(fontSize: 32)),
        title: Text(
          theme.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${theme.cardValues.length} pairs to match'),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () async {
          // Save the chosen theme ID to local storage
          final storageService = await ref.read(
            localStorageServiceProvider.future,
          );
          await storageService.saveLastTheme(theme.id);

          if (!context.mounted) return;
          // Navigate to the GameScreen, passing the selected theme
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => GameScreen(theme: theme)),
          );
        },
      ),
    );
  }
}
