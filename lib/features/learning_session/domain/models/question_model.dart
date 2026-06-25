import '../../../../shared/models/topic_model.dart';

enum QuestionDifficulty { easy, medium, hard }

extension QuestionDifficultyX on QuestionDifficulty {
  String get label {
    switch (this) {
      case QuestionDifficulty.easy:
        return 'Easy';
      case QuestionDifficulty.medium:
        return 'Medium';
      case QuestionDifficulty.hard:
        return 'Hard';
    }
  }
}

class QuestionModel {
  final String id;
  final TopicId topicId;
  final String prompt;
  final QuestionDifficulty difficulty;
  final String correctAnswer;
  final String hint;

  const QuestionModel({
    required this.id,
    required this.topicId,
    required this.prompt,
    required this.difficulty,
    required this.correctAnswer,
    required this.hint,
  });
}

class LearningSessionModel {
  final String sessionTitle;
  final TopicId topicId;
  final List<QuestionModel> questions;

  const LearningSessionModel({
    required this.sessionTitle,
    required this.topicId,
    required this.questions,
  });
}