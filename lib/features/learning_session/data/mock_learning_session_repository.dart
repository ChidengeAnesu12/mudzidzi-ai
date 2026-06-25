import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/topic_model.dart';
import '../domain/models/question_model.dart';

class MockLearningSessionRepository {
  Future<LearningSessionModel> getSession(TopicId topicId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return LearningSessionModel(
      sessionTitle: 'Linear Equations',
      topicId: topicId,
      questions: const [
        QuestionModel(
          id: 'q1',
          topicId: TopicId.algebra,
          prompt: 'Solve for x:\n2x + 5 = 17',
          difficulty: QuestionDifficulty.easy,
          correctAnswer: '6',
          hint: 'Subtract 5 from both sides first, then divide by 2.',
        ),
        QuestionModel(
          id: 'q2',
          topicId: TopicId.algebra,
          prompt: 'Solve for x:\n3x - 4 = 11',
          difficulty: QuestionDifficulty.easy,
          correctAnswer: '5',
          hint: 'Add 4 to both sides first, then divide by 3.',
        ),
        QuestionModel(
          id: 'q3',
          topicId: TopicId.algebra,
          prompt: 'Solve for x:\n5(x - 2) = 20',
          difficulty: QuestionDifficulty.medium,
          correctAnswer: '6',
          hint: 'Expand the brackets first, then isolate x.',
        ),
      ],
    );
  }
}

final mockLearningSessionRepositoryProvider = Provider<MockLearningSessionRepository>((ref) {
  return MockLearningSessionRepository();
});

final learningSessionProvider =
    FutureProvider.family<LearningSessionModel, TopicId>((ref, topicId) {
  return ref.watch(mockLearningSessionRepositoryProvider).getSession(topicId);
});