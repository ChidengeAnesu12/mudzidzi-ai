import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/pill_tab_switcher.dart';
import '../../../../core/widgets/responsive_center.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/topic_progress_bar.dart';
import '../../data/mock_progress_repository.dart';
import '../../domain/models/progress_models.dart';
import '../widgets/predicted_performance_card.dart';
import '../widgets/topic_mastery_radar.dart';
import '../widgets/weekly_activity_chart.dart';

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final progressAsync = ref.watch(progressDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: SafeArea(
        child: ResponsiveCenter(
          child: AsyncValueWidget<ProgressData>(
            value: progressAsync,
            onRetry: () => ref.invalidate(progressDataProvider),
            data: (data) => Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                children: [
                  PillTabSwitcher(
                    labels: const ['Overview', 'Detailed'],
                    selectedIndex: _selectedTab,
                    onChanged: (index) => setState(() => _selectedTab = index),
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: _selectedTab == 0
                        ? _OverviewTab(data: data)
                        : _DetailedTab(data: data),
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

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.data});

  final ProgressData data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const SectionHeader(title: 'Topic Mastery'),
        const SizedBox(height: 14),
        AppCard(
          child: TopicMasteryRadar(
            myMastery: data.myMastery,
            classAverageMastery: data.classAverageMastery,
          ),
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: 'Weekly Activity'),
        const SizedBox(height: 14),
        AppCard(child: WeeklyActivityChart(activity: data.weeklyActivity)),
      ],
    );
  }
}

class _DetailedTab extends StatelessWidget {
  const _DetailedTab({required this.data});

  final ProgressData data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        PredictedPerformanceCard(
          predictedScorePercent: data.predictedScorePercent,
          predictedGrade: data.predictedGrade,
          focusAreas: data.focusAreas,
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: 'All Topics'),
        const SizedBox(height: 14),
        AppCard(
          child: Column(
            children: [
              for (final topic in data.myMastery)
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: TopicProgressBar(
                    label: topic.topicId.name,
                    percent: topic.masteryPercent,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}