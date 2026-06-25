import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/question_model.dart';

const Object _unset = Object();

class LearningSessionState {
  final LearningSessionModel session;
  final int currentIndex;
  final int correctCount;
  final int elapsedSeconds;
  final bool showHint;
  final bool submitted;
  final bool? isCorrect;
  final bool isComplete;

  const LearningSessionState({
    required this.session,
    this.currentIndex = 0,
    this.correctCount = 0,
    this.elapsedSeconds = 0,
    this.showHint = false,
    this.submitted = false,
    this.isCorrect,
    this.isComplete = false,
  });

  QuestionModel get currentQuestion => session.questions[currentIndex];
  int get totalQuestions => session.questions.length;

  int get _answeredCount => currentIndex + (submitted ? 1 : 0);

  double get scorePercent =>
      _answeredCount == 0 ? 0 : (correctCount / _answeredCount) * 100;

  /// Note on [isCorrect]: it's a tri-state nullable bool (not yet
  /// answered / wrong / right), so copyWith needs to distinguish
  /// "leave unchanged" from "explicitly set to null" — the [_unset]
  /// sentinel default does that; passing `isCorrect: null` here
  /// genuinely resets it, while omitting the parameter leaves it as-is.
  LearningSessionState copyWith({
    int? currentIndex,
    int? correctCount,
    int? elapsedSeconds,
    bool? showHint,
    bool? submitted,
    Object? isCorrect = _unset,
    bool? isComplete,
  }) {
    return LearningSessionState(
      session: session,
      currentIndex: currentIndex ?? this.currentIndex,
      correctCount: correctCount ?? this.correctCount,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      showHint: showHint ?? this.showHint,
      submitted: submitted ?? this.submitted,
      isCorrect: identical(isCorrect, _unset) ? this.isCorrect : isCorrect as bool?,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

/// Drives a single learning session: question navigation, answer
/// checking, score tracking, hint visibility, and an elapsed-time
/// timer. One controller instance per session (keyed by the loaded
/// LearningSessionModel via the .family provider below).
class LearningSessionController extends StateNotifier<LearningSessionState> {
  LearningSessionController(LearningSessionModel session)
      : super(LearningSessionState(session: session)) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);
    });
  }

  Timer? _timer;

  void toggleHint() => state = state.copyWith(showHint: !state.showHint);

  void submitAnswer(String answerText) {
    if (state.submitted) return;
    final isCorrect = answerText.trim().toLowerCase() ==
        state.currentQuestion.correctAnswer.trim().toLowerCase();
    state = state.copyWith(
      submitted: true,
      isCorrect: isCorrect,
      correctCount: isCorrect ? state.correctCount + 1 : state.correctCount,
    );
  }

  void nextQuestion() {
    final isLastQuestion = state.currentIndex >= state.totalQuestions - 1;
    if (isLastQuestion) {
      _timer?.cancel();
      state = state.copyWith(isComplete: true);
      return;
    }
    state = state.copyWith(
      currentIndex: state.currentIndex + 1,
      submitted: false,
      isCorrect: null,
      showHint: false,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// autoDispose: when the Learning Session screen is popped and nothing
/// watches this anymore, Riverpod calls dispose() automatically — which
/// cancels the timer. No manual cleanup needed at the call site.
final learningSessionControllerProvider = StateNotifierProvider.autoDispose
    .family<LearningSessionController, LearningSessionState, LearningSessionModel>(
  (ref, session) => LearningSessionController(session),
);