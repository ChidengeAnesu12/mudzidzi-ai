/// The 6 O-Level Mathematics topic areas tracked across the app.
enum TopicId { numbers, algebra, functions, geometry, trigonometry, statistics }

extension TopicIdX on TopicId {
  String get displayName {
    switch (this) {
      case TopicId.numbers:
        return 'Numbers';
      case TopicId.algebra:
        return 'Algebra';
      case TopicId.functions:
        return 'Functions';
      case TopicId.geometry:
        return 'Geometry';
      case TopicId.trigonometry:
        return 'Trigonometry';
      case TopicId.statistics:
        return 'Statistics';
    }
  }
}

/// A single topic's mastery score (0–100). Reused across Dashboard,
/// Progress, and Teacher Dashboard — anywhere a "% mastery per topic"
/// needs to be shown, for either a student or a class average.
class TopicMastery {
  final TopicId topicId;
  final double masteryPercent;

  const TopicMastery({required this.topicId, required this.masteryPercent});
}