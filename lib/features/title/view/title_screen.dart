import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data/game_data.dart';
import '../../map/view/world_map_screen.dart';

class TitleScreen extends ConsumerWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Using a Scaffold for basic app screen structure
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Spacer to push content to the center
                const Spacer(),

                // 1. Logo and Mascot
                // TODO: Replace with your Ollie the Owl mascot image
                const Icon(
                  Icons.visibility, // Placeholder Owl Icon 🦉
                  size: 100,
                  color: Color(0xFFA8E6CF), // Mint Green from your GDD
                ),
                const SizedBox(height: 16),
                const Text(
                  'Peek-a-Pair',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    // TODO: Add your bubbly font
                  ),
                ),
                const SizedBox(height: 8),

                // 2. Tagline
                const Text(
                  '"Peek fast. Pair smart!"',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 60),

                // 3. Buttons
                _buildMenuButton(
                  context: context,
                  icon: Icons.play_arrow_rounded,
                  label: 'Play Game',
                  onPressed: () async {
                    final firstWorld = allWorlds[0];

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WorldMapScreen(theme: firstWorld),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuButton(
                  context: context,
                  icon: Icons.palette_rounded,
                  label: 'Themes',
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => ThemeSelectionScreen(),
                    //   ),
                    // );
                  },
                ),

                // Spacer to push the bottom buttons down
                const Spacer(),

                // Bottom row for How to Play and Settings
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMenuButton(
                      context: context,
                      icon: Icons.question_mark_rounded,
                      label: 'How to Play',
                      onPressed: () {},
                      isSmall: true,
                    ),
                    _buildMenuButton(
                      context: context,
                      icon: Icons.settings_rounded,
                      label: 'Settings',
                      onPressed: () {},
                      isSmall: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build consistent menu buttons
  Widget _buildMenuButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isSmall = false,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: isSmall ? 20 : 24),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: isSmall ? const Size(120, 40) : const Size(220, 50),
        textStyle: TextStyle(fontSize: isSmall ? 14 : 18),
      ),
    );
  }
}
