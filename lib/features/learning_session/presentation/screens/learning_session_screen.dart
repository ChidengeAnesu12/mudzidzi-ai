import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/mastery_circle.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/responsive_center.dart';
import '../../../../shared/models/topic_model.dart';
import '../../data/mock_learning_session_repository.dart';
import '../../domain/models/question_model.dart';
import '../providers/learning_session_controller.dart';
import '../widgets/answer_feedback_banner.dart';
import '../widgets/hint_card.dart';

AppBadgeTone _difficultyTone(QuestionDifficulty difficulty) {
  switch (difficulty) {
    case QuestionDifficulty.easy:
      return AppBadgeTone.success;
    case QuestionDifficulty.medium:
      return AppBadgeTone.warning;
    case QuestionDifficulty.hard:
      return AppBadgeTone.danger;
  }
}

class LearningSessionScreen extends ConsumerWidget {
  const LearningSessionScreen({super.key, this.topicId = TopicId.algebra});

  final TopicId topicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(learningSessionProvider(topicId));

    return Scaffold(
      body: AsyncValueWidget<LearningSessionModel>(
        value: sessionAsync,
        onRetry: () => ref.invalidate(learningSessionProvider(topicId)),
        data: (session) => _LearningSessionView(session: session),
      ),
    );
  }
}

class _LearningSessionView extends ConsumerStatefulWidget {
  const _LearningSessionView({required this.session});

  final LearningSessionModel session;

  @override
  ConsumerState<_LearningSessionView> createState() => _LearningSessionViewState();
}

class _LearningSessionViewState extends ConsumerState<_LearningSessionView> {
  final _answerController = TextEditingController();

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final provider = learningSessionControllerProvider(widget.session);
    final state = ref.watch(provider);
    final controller = ref.read(provider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (state.isComplete) {
      return _SessionCompleteView(state: state);
    }

    final question = state.currentQuestion;
    final isLastQuestion = state.currentIndex >= state.totalQuestions - 1;

    return SafeArea(
      child: ResponsiveCenter(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      widget.session.sessionTitle,
                      style: AppTextStyles.headlineMedium(color: textTheme.headlineMedium?.color),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 18, color: textTheme.bodySmall?.color),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(state.elapsedSeconds),
                        style: AppTextStyles.labelMedium(color: textTheme.bodySmall?.color),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: state.currentIndex / state.totalQuestions,
                  minHeight: 6,
                  backgroundColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${state.currentIndex + 1} / ${state.totalQuestions}',
                    style: AppTextStyles.bodySmall(color: textTheme.bodySmall?.color),
                  ),
                  Text(
                    'Score: ${state.scorePercent.round()}%',
                    style: AppTextStyles.bodySmall(color: textTheme.bodySmall?.color),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBadgeChip(
                      label: question.difficulty.label,
                      tone: _difficultyTone(question.difficulty),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      question.prompt,
                      style: AppTextStyles.headlineLarge(color: textTheme.headlineLarge?.color),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: _answerController,
                label: 'Enter your answer',
                enabled: !state.submitted,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),
              HintCard(
                hintText: question.hint,
                isExpanded: state.showHint,
                onToggle: controller.toggleHint,
              ),
              const SizedBox(height: 16),
              if (state.submitted && state.isCorrect != null)
                AnswerFeedbackBanner(
                  isCorrect: state.isCorrect!,
                  correctAnswer: question.correctAnswer,
                ),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _answerController,
                builder: (context, value, _) {
                  final hasText = value.text.trim().isNotEmpty;
                  final VoidCallback? onPressed = state.submitted
                      ? () {
                          controller.nextQuestion();
                          _answerController.clear();
                        }
                      : (hasText ? () => controller.submitAnswer(_answerController.text) : null);

                  return Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: state.submitted
                              ? (isLastQuestion ? 'Finish' : 'Next Question')
                              : 'Submit Answer',
                          onPressed: onPressed,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Stubbed for now — no audio engine wired up yet.
                      IconButton.filled(
                        icon: const Icon(Icons.volume_up_outlined),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Audio playback coming soon.')),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionCompleteView extends StatelessWidget {
  const _SessionCompleteView({required this.state});

  final LearningSessionState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scorePercent =
        state.totalQuestions == 0 ? 0.0 : (state.correctCount / state.totalQuestions) * 100;

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MasteryCircle(percent: scorePercent, label: 'Score', size: 140),
                const SizedBox(height: 24),
                Text(
                  'Session Complete! 🎉',
                  style: AppTextStyles.headlineLarge(color: textTheme.headlineLarge?.color),
                ),
                const SizedBox(height: 8),
                Text(
                  '${state.correctCount} of ${state.totalQuestions} correct',
                  style: AppTextStyles.bodyMedium(color: textTheme.bodyMedium?.color),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Back to Dashboard',
                  onPressed: () => context.goNamed(RouteNames.dashboard),
                  fullWidth: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}