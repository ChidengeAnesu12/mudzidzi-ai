import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../theme/app_text_styles.dart';
import '../utils/mastery_tier.dart';

/// A single "Topic — bar — percentage" row. Color follows mastery tier
/// thresholds (green/orange/red), matching the Dashboard and Progress
/// mockups exactly.
class TopicProgressBar extends StatelessWidget {
  const TopicProgressBar({
    super.key,
    required this.label,
    required this.percent,
    this.height = 10,
  });

  final String label;
  final double percent; // 0-100
  final double height;

  @override
  Widget build(BuildContext context) {
    final color = masteryTierColor(percent);
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Row(
      children: [
        SizedBox(
          width: 96,
          child: Text(label, style: AppTextStyles.bodyMedium(color: textColor)),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(height),
            child: LinearPercentIndicator(
              lineHeight: height,
              percent: percent.clamp(0, 100) / 100,
              animation: true,
              animationDuration: 700,
              padding: EdgeInsets.zero,
              backgroundColor: color.withValues(alpha: 0.15),
              progressColor: color,
              barRadius: Radius.circular(height),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 38,
          child: Text(
            '${percent.round()}%',
            textAlign: TextAlign.right,
            style: AppTextStyles.labelMedium(color: color),
          ),
        ),
      ],
    );
  }
}