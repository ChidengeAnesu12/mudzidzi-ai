import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/mastery_tier.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/models/teacher_dashboard_models.dart';

class StudentsAtRiskCard extends StatelessWidget {
  const StudentsAtRiskCard({super.key, required this.students});

  final List<StudentAtRisk> students;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Students At Risk'),
          const SizedBox(height: 14),
          for (var i = 0; i < students.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  SizedBox(
                    width: 22,
                    child: Text(
                      '${i + 1}.',
                      style: AppTextStyles.bodyMedium(color: textTheme.bodySmall?.color),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      students[i].name,
                      style: AppTextStyles.bodyMedium(color: textTheme.bodyMedium?.color),
                    ),
                  ),
                  Text(
                    '${students[i].scorePercent.round()}%',
                    style: AppTextStyles.labelLarge(
                      color: masteryTierColor(students[i].scorePercent),
                    ),
                  ),
                ],
              ),
            ),
          Center(
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Full student roster coming soon.')),
                );
              },
              child: const Text('View All'),
            ),
          ),
        ],
      ),
    );
  }
}