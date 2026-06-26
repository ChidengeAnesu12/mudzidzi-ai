import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/topic_ui_mapper.dart';
import '../../../../core/utils/mastery_tier.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/mastery_circle.dart';
import '../../../../shared/models/topic_model.dart';

/// "Predicted Performance" panel — predicted O-Level score + grade,
/// plus the 3 weakest topics ("Focus More On"), matching the
/// Predicted Performance mockup.
class PredictedPerformanceCard extends StatelessWidget {
  const PredictedPerformanceCard({
    super.key,
    required this.predictedScorePercent,
    required this.predictedGrade,
    required this.focusAreas,
  });

  final double predictedScorePercent;
  final String predictedGrade;
  final List<TopicMastery> focusAreas;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final tierColor = masteryTierColor(predictedScorePercent);

    return AppCard(
      child: Column(
        children: [
          MasteryCircle(percent: predictedScorePercent, size: 130, progressColor: tierColor),
          const SizedBox(height: 12),
          Text(
            'Predicted O-Level Score',
            style: AppTextStyles.bodyMedium(color: textTheme.bodyMedium?.color),
          ),
          const SizedBox(height: 4),
          Text(
            'Grade: $predictedGrade',
            style: AppTextStyles.headlineMedium(color: textTheme.headlineMedium?.color),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Focus More On',
              style: AppTextStyles.titleLarge(color: textTheme.titleLarge?.color),
            ),
          ),
          const SizedBox(height: 14),
          ...focusAreas.map(
            (topic) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _FocusAreaTile(topic: topic),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              "Keep practicing! You're improving 🚀",
              textAlign: TextAlign.center,
              style: AppTextStyles.labelMedium(color: AppColors.accentDark),
            ),
          ),
        ],
      ),
    );
  }
}

class _FocusAreaTile extends StatelessWidget {
  const _FocusAreaTile({required this.topic});

  final TopicMastery topic;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = masteryTierColor(topic.masteryPercent);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(topic.topicId.icon, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topic.topicId.displayName,
                style: AppTextStyles.bodyMedium(color: textTheme.bodyMedium?.color),
              ),
              const SizedBox(height: 2),
              Text(
                'Mastery: ${topic.masteryPercent.round()}%',
                style: AppTextStyles.bodySmall(color: color),
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: (topic.masteryPercent / 100).clamp(0, 1),
                  minHeight: 6,
                  backgroundColor: color.withValues(alpha: 0.15),
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}