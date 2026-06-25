import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_card.dart';

/// Compact stat display — value + label, with an optional delta
/// ("+6% from last week") and optional leading icon. Used for Dashboard
/// quick-stats and Teacher Dashboard analytics cards.
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
    this.deltaText,
    this.deltaIsPositive = true,
  });

  final String value;
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final String? deltaText;
  final bool deltaIsPositive;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Icon(icon, size: 18, color: iconColor ?? AppColors.primary),
            ),
          Text(value, style: AppTextStyles.headlineLarge(color: textTheme.headlineLarge?.color)),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.bodySmall(color: textTheme.bodySmall?.color)),
          if (deltaText != null) ...[
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  deltaIsPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 12,
                  color: deltaIsPositive ? AppColors.success : AppColors.error,
                ),
                const SizedBox(width: 2),
                Text(
                  deltaText!,
                  style: AppTextStyles.labelMedium(
                    color: deltaIsPositive ? AppColors.success : AppColors.error,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}