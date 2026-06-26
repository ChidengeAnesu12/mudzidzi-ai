import 'package:flutter/material.dart';

/// Maps a [BadgeModel.iconKey] string to its display icon. Kept
/// separate from the domain model so the domain layer stays
/// Flutter-free (no IconData import there).
IconData badgeIconFor(String iconKey) {
  switch (iconKey) {
    case 'trophy':
      return Icons.emoji_events_rounded;
    case 'flash':
      return Icons.bolt_rounded;
    case 'flame':
      return Icons.local_fire_department_rounded;
    case 'star':
      return Icons.star_rounded;
    default:
      return Icons.military_tech_rounded;
  }
}