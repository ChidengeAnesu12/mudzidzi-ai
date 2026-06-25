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

/// Activity types shown in the Dashboard's "Recent Activity" feed.
enum ActivityType { lessonCompleted, badgeEarned, streak, practice }

class RecentActivityItem {
  final String title;
  final String timeAgo;
  final ActivityType type;

  const RecentActivityItem({
    required this.title,
    required this.timeAgo,
    required this.type,
  });
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
  final int weeklyGoalTarget;
  final int weeklyGoalCompleted;
  final List<RecentActivityItem> recentActivity;

  const DashboardSummary({
    required this.studentFirstName,
    required this.overallMasteryPercent,
    required this.lessonsCompleted,
    required this.questionsSolved,
    required this.studyStreakDays,
    required this.topicMasteries,
    required this.continueLearning,
    required this.nextUp,
    required this.weeklyGoalTarget,
    required this.weeklyGoalCompleted,
    required this.recentActivity,
  });
}