import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/mastery_circle.dart';
import '../../../../core/widgets/responsive_center.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/topic_progress_bar.dart';
import '../../../../shared/models/topic_model.dart';
import '../../data/mock_dashboard_repository.dart';
import '../../domain/models/dashboard_models.dart';
import '../widgets/continue_learning_card.dart';
import '../widgets/recent_activity_tile.dart';
import '../widgets/weekly_goal_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.smart_toy_outlined),
            tooltip: 'AI Tutor',
            onPressed: () => context.pushNamed(RouteNames.aiTutor),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ResponsiveCenter(
          child: AsyncValueWidget<DashboardSummary>(
            value: summaryAsync,
            onRetry: () => ref.invalidate(dashboardSummaryProvider),
            data: (summary) => RefreshIndicator(
              onRefresh: () async => ref.invalidate(dashboardSummaryProvider),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  Text(
                    '${_greeting()}, ${summary.studentFirstName} 👋',
                    style: AppTextStyles.headlineLarge(color: textTheme.headlineLarge?.color),
                  ),
                  const SizedBox(height: 20),
                  _MasteryOverview(summary: summary),
                  const SizedBox(height: 16),
                  ContinueLearningCard(
                    info: summary.continueLearning,
                    onContinue: () => context.pushNamed(
                      RouteNames.learningSession,
                      extra: TopicId.algebra,
                    ),
                  ),
                  const SizedBox(height: 16),
                  WeeklyGoalCard(
                    completed: summary.weeklyGoalCompleted,
                    target: summary.weeklyGoalTarget,
                  ),
                  const SizedBox(height: 28),
                  SectionHeader(
                    title: 'Topic Mastery',
                    actionLabel: 'View All',
                    onActionTap: () => context.goNamed(RouteNames.progress),
                  ),
                  const SizedBox(height: 14),
                  ...summary.topicMasteries.map(
                    (t) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TopicProgressBar(
                        label: t.topicId.displayName,
                        percent: t.masteryPercent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const SectionHeader(title: 'Recent Activity'),
                  const SizedBox(height: 10),
                  ...summary.recentActivity.map(
                    (a) => RecentActivityTile(item: a),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MasteryOverview extends StatelessWidget {
  const _MasteryOverview({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MasteryCircle(
          percent: summary.overallMasteryPercent,
          label: 'Overall\nMastery',
          size: 130,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _QuickStatRow(
                icon: Icons.menu_book_outlined,
                label: 'Lessons Completed',
                value: '${summary.lessonsCompleted}',
              ),
              const SizedBox(height: 14),
              _QuickStatRow(
                icon: Icons.check_circle_outline,
                label: 'Questions Solved',
                value: '${summary.questionsSolved}',
              ),
              const SizedBox(height: 14),
              _QuickStatRow(
                icon: Icons.local_fire_department_outlined,
                iconColor: AppColors.accent,
                label: 'Study Streak',
                value: '${summary.studyStreakDays} days',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickStatRow extends StatelessWidget {
  const _QuickStatRow({
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor ?? AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: AppTextStyles.titleLarge(color: textTheme.titleLarge?.color)),
              Text(label, style: AppTextStyles.bodySmall(color: textTheme.bodySmall?.color)),
            ],
          ),
        ),
      ],
    );
  }
}