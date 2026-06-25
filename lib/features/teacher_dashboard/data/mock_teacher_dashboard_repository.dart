import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/topic_model.dart';
import '../domain/models/teacher_dashboard_models.dart';

class MockTeacherDashboardRepository {
  Future<TeacherDashboardSummary> getSummary() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const TeacherDashboardSummary(
      className: 'Chisipite High School',
      classAveragePercent: 48,
      classAverageDeltaPercent: 6,
      studentsAtRiskCount: 12,
      mostImprovedStudentName: 'Rutendo M.',
      mostImprovedDeltaPercent: 15,
      lessonsCompletedThisWeek: 18,
      topicPerformance: [
        TopicMastery(topicId: TopicId.numbers, masteryPercent: 72),
        TopicMastery(topicId: TopicId.algebra, masteryPercent: 55),
        TopicMastery(topicId: TopicId.functions, masteryPercent: 41),
        TopicMastery(topicId: TopicId.geometry, masteryPercent: 47),
        TopicMastery(topicId: TopicId.trigonometry, masteryPercent: 27),
        TopicMastery(topicId: TopicId.statistics, masteryPercent: 74),
      ],
      studentsAtRisk: [
        StudentAtRisk(name: 'Tawanda K.', scorePercent: 23),
        StudentAtRisk(name: 'Precious N.', scorePercent: 28),
        StudentAtRisk(name: 'Brian M.', scorePercent: 31),
        StudentAtRisk(name: 'Courage D.', scorePercent: 33),
        StudentAtRisk(name: 'Moreblessing S.', scorePercent: 35),
      ],
      recommendations: [
        'Focus more on Trigonometry — most students are struggling.',
        'Schedule a revision lesson for Functions.',
        'Encourage more practice on word problems.',
      ],
    );
  }
}

final mockTeacherDashboardRepositoryProvider = Provider<MockTeacherDashboardRepository>((ref) {
  return MockTeacherDashboardRepository();
});

final teacherDashboardProvider = FutureProvider<TeacherDashboardSummary>((ref) {
  return ref.watch(mockTeacherDashboardRepositoryProvider).getSummary();
});