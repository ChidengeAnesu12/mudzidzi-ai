import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/models/badge_model.dart';
import 'badge_icon_mapper.dart';

/// Row item for a single badge. Supports a locked/unearned visual
/// state (greyed icon + lock overlay) for forward-compatibility, even
/// though all current mock badges are unlocked.
class BadgeListTile extends StatelessWidget {
  const BadgeListTile({super.key, required this.badge});

  final BadgeModel badge;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final isLocked = !badge.isUnlocked;

    final lockedColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final iconColor = isLocked ? lockedColor : AppColors.accent;
    final circleColor = isLocked ? lockedColor.withValues(alpha: 0.15) : AppColors.primaryDark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
              child: Icon(
                isLocked ? Icons.lock_outline : badgeIconFor(badge.iconKey),
                size: 22,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    badge.title,
                    style: AppTextStyles.titleLarge(
                      color: isLocked ? textTheme.bodySmall?.color : textTheme.titleLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    badge.description,
                    style: AppTextStyles.bodySmall(color: textTheme.bodySmall?.color),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}