import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Maps a mastery percentage to a tier color, matching the thresholds
/// shown in the Mudzidzi AI mockups (Topic Mastery list, Predicted
/// Performance, Teacher Dashboard topic bars):
/// - 70%+      -> green  (strong)
/// - 40–69%    -> orange (developing)
/// - below 40% -> red    (needs focus)
Color masteryTierColor(double percent) {
  if (percent >= 70) return AppColors.success;
  if (percent >= 40) return AppColors.warning;
  return AppColors.error;
}