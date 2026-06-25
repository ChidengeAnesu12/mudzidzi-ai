import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/topic_model.dart';
import '../domain/models/dashboard_models.dart';

class MockDashboardRepository {
  Future<DashboardSummary> getDashboardSummary() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const DashboardSummary(
      studentFirstName: 'Anesu',
      overallMasteryPercent: 63,
      lessonsCompleted: 24,
      questionsSolved: 342,
      studyStreakDays: 7,
      topicMasteries: [
        TopicMastery(topicId: TopicId.numbers, masteryPercent: 85),
        TopicMastery(topicId: TopicId.algebra, masteryPercent: 80),
        TopicMastery(topicId: TopicId.functions, masteryPercent: 42),
        TopicMastery(topicId: TopicId.geometry, masteryPercent: 60),
        TopicMastery(topicId: TopicId.trigonometry, masteryPercent: 20),
        TopicMastery(topicId: TopicId.statistics, masteryPercent: 90),
      ],
      continueLearning: ContinueLearningInfo(
        lessonTitle: 'Linear Equations',
        progressPercent: 40,
      ),
      nextUp: [
        NextUpItem(title: 'Revise: Indices & Surds', subtitle: 'Recommended before Quadratics'),
        NextUpItem(title: 'Practice: Linear Equations', subtitle: '10 questions'),
        NextUpItem(title: 'Challenge: Word Problems', subtitle: 'Test your skills'),
      ],
    );
  }
}

final mockDashboardRepositoryProvider = Provider<MockDashboardRepository>((ref) {
  return MockDashboardRepository();
});

final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) {
  return ref.watch(mockDashboardRepositoryProvider).getDashboardSummary();
});