import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/models/dashboard_models.dart';

class RecentActivityTile extends StatelessWidget {
  const RecentActivityTile({super.key, required this.item});

  final RecentActivityItem item;

  IconData get _icon {
    switch (item.type) {
      case ActivityType.lessonCompleted:
        return Icons.check_circle_outline;
      case ActivityType.badgeEarned:
        return Icons.emoji_events_outlined;
      case ActivityType.streak:
        return Icons.local_fire_department_outlined;
      case ActivityType.practice:
        return Icons.edit_outlined;
    }
  }

  Color get _color {
    switch (item.type) {
      case ActivityType.lessonCompleted:
        return AppColors.success;
      case ActivityType.badgeEarned:
        return AppColors.accent;
      case ActivityType.streak:
        return AppColors.accentDark;
      case ActivityType.practice:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(_icon, size: 18, color: _color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(item.title, style: AppTextStyles.bodyMedium(color: textTheme.bodyMedium?.color)),
          ),
          Text(item.timeAgo, style: AppTextStyles.bodySmall(color: textTheme.bodySmall?.color)),
        ],
      ),
    );
  }
}