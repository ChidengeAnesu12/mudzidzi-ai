import 'package:flutter/material.dart';

import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/topic_progress_bar.dart';
import '../../../../shared/models/topic_model.dart';

class TopicPerformanceCard extends StatelessWidget {
  const TopicPerformanceCard({super.key, required this.topicPerformance});

  final List<TopicMastery> topicPerformance;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Topic Performance (Class Average)'),
          const SizedBox(height: 16),
          for (final topic in topicPerformance)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TopicProgressBar(
                label: topic.topicId.displayName,
                percent: topic.masteryPercent,
              ),
            ),
        ],
      ),
    );
  }
}