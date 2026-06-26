import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/responsive_center.dart';
import '../../data/mock_teacher_dashboard_repository.dart';
import '../../domain/models/teacher_dashboard_models.dart';
import '../widgets/recommendations_card.dart';
import '../widgets/students_at_risk_card.dart';
import '../widgets/teacher_sidebar.dart';
import '../widgets/teacher_stat_grid.dart';
import '../widgets/topic_performance_card.dart';

class TeacherDashboardScreen extends ConsumerWidget {
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(teacherDashboardProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Teacher Dashboard')),
      body: SafeArea(
        child: AsyncValueWidget<TeacherDashboardSummary>(
          value: summaryAsync,
          onRetry: () => ref.invalidate(teacherDashboardProvider),
          data: (summary) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= Breakpoints.desktop;
                final content = _TeacherDashboardContent(summary: summary);

                if (!isWide) return content;

                return Row(
                  children: [
                    TeacherSidebar(schoolName: summary.className),
                    Expanded(child: content),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _TeacherDashboardContent extends StatelessWidget {
  const _TeacherDashboardContent({required this.summary});

  final TeacherDashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ResponsiveCenter(
      maxWidth: 900,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              summary.className,
              style: AppTextStyles.bodyMedium(color: textTheme.bodyMedium?.color),
            ),
            const SizedBox(height: 18),
            TeacherStatGrid(summary: summary),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= Breakpoints.tablet;

                final sections = [
                  TopicPerformanceCard(topicPerformance: summary.topicPerformance),
                  StudentsAtRiskCard(students: summary.studentsAtRisk),
                  RecommendationsCard(recommendations: summary.recommendations),
                ];

                if (!isWide) {
                  return Column(
                    children: [
                      for (final section in sections)
                        Padding(padding: const EdgeInsets.only(bottom: 16), child: section),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final section in sections) ...[
                      Expanded(child: section),
                      if (section != sections.last) const SizedBox(width: 16),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}