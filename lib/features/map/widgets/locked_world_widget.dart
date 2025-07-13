import 'package:flutter/material.dart';

class LockedWorldWidget extends StatelessWidget {
  final String worldName;
  final String unlockRequirement;

  const LockedWorldWidget({
    super.key,
    required this.worldName,
    required this.unlockRequirement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade800, // A dark, "locked" color
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_rounded, size: 80, color: Colors.white38),
            const SizedBox(height: 16),
            Text(
              worldName,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              unlockRequirement,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
