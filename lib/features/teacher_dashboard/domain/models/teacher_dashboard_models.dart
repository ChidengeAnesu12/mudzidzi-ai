import '../../../../shared/models/topic_model.dart';

class StudentAtRisk {
  final String name;
  final double scorePercent;

  const StudentAtRisk({required this.name, required this.scorePercent});
}

class TeacherDashboardSummary {
  final String className;
  final double classAveragePercent;
  final double classAverageDeltaPercent;
  final int studentsAtRiskCount;
  final String mostImprovedStudentName;
  final double mostImprovedDeltaPercent;
  final int lessonsCompletedThisWeek;
  final List<TopicMastery> topicPerformance;
  final List<StudentAtRisk> studentsAtRisk;
  final List<String> recommendations;

  const TeacherDashboardSummary({
    required this.className,
    required this.classAveragePercent,
    required this.classAverageDeltaPercent,
    required this.studentsAtRiskCount,
    required this.mostImprovedStudentName,
    required this.mostImprovedDeltaPercent,
    required this.lessonsCompletedThisWeek,
    required this.topicPerformance,
    required this.studentsAtRisk,
    required this.recommendations,
  });
}