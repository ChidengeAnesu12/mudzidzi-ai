import '../../../../shared/models/topic_model.dart';

class DailyActivity {
  final String dayLabel;
  final double hoursStudied;

  const DailyActivity({required this.dayLabel, required this.hoursStudied});
}

class ProgressData {
  final List<TopicMastery> myMastery;
  final List<TopicMastery> classAverageMastery;
  final List<DailyActivity> weeklyActivity;
  final double predictedScorePercent;
  final String predictedGrade;

  const ProgressData({
    required this.myMastery,
    required this.classAverageMastery,
    required this.weeklyActivity,
    required this.predictedScorePercent,
    required this.predictedGrade,
  });

  /// The 3 weakest topics, ascending — used by the Predicted Performance
  /// "Focus More On" panel.
  List<TopicMastery> get focusAreas {
    final sorted = [...myMastery]..sort((a, b) => a.masteryPercent.compareTo(b.masteryPercent));
    return sorted.take(3).toList();
  }
}