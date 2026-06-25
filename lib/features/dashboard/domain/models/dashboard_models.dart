import '../../../../shared/models/topic_model.dart';

class ContinueLearningInfo {
  final String lessonTitle;
  final double progressPercent;

  const ContinueLearningInfo({required this.lessonTitle, required this.progressPercent});
}

class NextUpItem {
  final String title;
  final String subtitle;

  const NextUpItem({required this.title, required this.subtitle});
}

class DashboardSummary {
  final String studentFirstName;
  final double overallMasteryPercent;
  final int lessonsCompleted;
  final int questionsSolved;
  final int studyStreakDays;
  final List<TopicMastery> topicMasteries;
  final ContinueLearningInfo continueLearning;
  final List<NextUpItem> nextUp;

  const DashboardSummary({
    required this.studentFirstName,
    required this.overallMasteryPercent,
    required this.lessonsCompleted,
    required this.questionsSolved,
    required this.studyStreakDays,
    required this.topicMasteries,
    required this.continueLearning,
    required this.nextUp,
  });
}