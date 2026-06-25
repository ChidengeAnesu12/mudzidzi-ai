import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum AppBadgeTone { neutral, success, warning, danger, info }

extension _ToneColor on AppBadgeTone {
  Color get color {
    switch (this) {
      case AppBadgeTone.success:
        return AppColors.success;
      case AppBadgeTone.warning:
        return AppColors.warning;
      case AppBadgeTone.danger:
        return AppColors.error;
      case AppBadgeTone.info:
        return AppColors.info;
      case AppBadgeTone.neutral:
        return AppColors.primary;
    }
  }
}

/// Small pill-shaped label — used for difficulty tags ("Easy/Medium/Hard"),
/// node status ("Completed/In Progress/Locked"), and similar short tags.
class AppBadgeChip extends StatelessWidget {
  const AppBadgeChip({
    super.key,
    required this.label,
    this.tone = AppBadgeTone.neutral,
    this.icon,
  });

  final String label;
  final AppBadgeTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final color = tone.color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
          ],
          Text(label, style: AppTextStyles.labelMedium(color: color)),
        ],
      ),
    );
  }
}