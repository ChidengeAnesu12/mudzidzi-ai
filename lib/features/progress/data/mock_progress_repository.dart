import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/topic_model.dart';
import '../domain/models/progress_models.dart';

class MockProgressRepository {
  Future<ProgressData> getProgressData() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const ProgressData(
      myMastery: [
        TopicMastery(topicId: TopicId.numbers, masteryPercent: 85),
        TopicMastery(topicId: TopicId.algebra, masteryPercent: 80),
        TopicMastery(topicId: TopicId.functions, masteryPercent: 42),
        TopicMastery(topicId: TopicId.geometry, masteryPercent: 60),
        TopicMastery(topicId: TopicId.trigonometry, masteryPercent: 20),
        TopicMastery(topicId: TopicId.statistics, masteryPercent: 90),
      ],
      classAverageMastery: [
        TopicMastery(topicId: TopicId.numbers, masteryPercent: 72),
        TopicMastery(topicId: TopicId.algebra, masteryPercent: 55),
        TopicMastery(topicId: TopicId.functions, masteryPercent: 41),
        TopicMastery(topicId: TopicId.geometry, masteryPercent: 47),
        TopicMastery(topicId: TopicId.trigonometry, masteryPercent: 27),
        TopicMastery(topicId: TopicId.statistics, masteryPercent: 74),
      ],
      weeklyActivity: [
        DailyActivity(dayLabel: 'Mon', hoursStudied: 0.4),
        DailyActivity(dayLabel: 'Tue', hoursStudied: 1.0),
        DailyActivity(dayLabel: 'Wed', hoursStudied: 0.5),
        DailyActivity(dayLabel: 'Thu', hoursStudied: 1.0),
        DailyActivity(dayLabel: 'Fri', hoursStudied: 0.3),
        DailyActivity(dayLabel: 'Sat', hoursStudied: 1.2),
        DailyActivity(dayLabel: 'Sun', hoursStudied: 1.8),
      ],
      predictedScorePercent: 56,
      predictedGrade: 'C',
    );
  }
}

final mockProgressRepositoryProvider = Provider<MockProgressRepository>((ref) {
  return MockProgressRepository();
});

final progressDataProvider = FutureProvider<ProgressData>((ref) {
  return ref.watch(mockProgressRepositoryProvider).getProgressData();
});