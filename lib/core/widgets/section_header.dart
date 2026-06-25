import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Section title row with an optional trailing text action
/// (e.g. "View All Badges", "View Full Learning Path").
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.titleLarge?.color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.titleLarge(color: textColor)),
        if (actionLabel != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(actionLabel!, style: AppTextStyles.labelMedium(color: AppColors.primary)),
          ),
      ],
    );
  }
}