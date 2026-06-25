import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';

/// Weekly question-solving goal — light gamification nudge shown under
/// the Continue Learning card.
class WeeklyGoalCard extends StatelessWidget {
  const WeeklyGoalCard({super.key, required this.completed, required this.target});

  final int completed;
  final int target;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final double ratio =
        target == 0 ? 0.0 : (completed / target).clamp(0.0, 1.0).toDouble();

    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weekly Goal', style: AppTextStyles.titleLarge(color: textTheme.titleLarge?.color)),
                const SizedBox(height: 4),
                Text(
                  '$completed / $target questions this week',
                  style: AppTextStyles.bodySmall(color: textTheme.bodySmall?.color),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearPercentIndicator(
                    lineHeight: 8,
                    percent: ratio,
                    animation: true,
                    animationDuration: 700,
                    padding: EdgeInsets.zero,
                    backgroundColor: AppColors.accent.withValues(alpha: 0.15),
                    progressColor: AppColors.accent,
                    barRadius: const Radius.circular(8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.flag_outlined, color: AppColors.accent, size: 28),
        ],
      ),
    );
  }
}