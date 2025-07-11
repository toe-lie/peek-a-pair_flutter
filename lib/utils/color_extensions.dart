import 'package:flutter/material.dart';

extension ColorOpacityExtension on Color {
  /// Returns a new color with the given opacity.
  /// The opacity is a double from 0.0 (transparent) to 1.0 (opaque).
  Color applyOpacity(double opacity) {
    // We use clamp to ensure the opacity value is safely between 0.0 and 1.0
    final clampedOpacity = opacity.clamp(0.0, 1.0);

    return withAlpha((clampedOpacity * 255).round());
  }
}
