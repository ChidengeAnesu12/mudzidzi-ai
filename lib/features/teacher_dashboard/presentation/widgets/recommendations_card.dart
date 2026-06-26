import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/section_header.dart';

class RecommendationsCard extends StatelessWidget {
  const RecommendationsCard({super.key, required this.recommendations});

  final List<String> recommendations;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Recommendations'),
          const SizedBox(height: 14),
          for (final tip in recommendations)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_outline, size: 18, color: AppColors.accent),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      tip,
                      style: AppTextStyles.bodyMedium(color: textTheme.bodyMedium?.color),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}