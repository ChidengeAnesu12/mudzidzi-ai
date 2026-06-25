import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Shown immediately after submitting an answer — green for correct,
/// red for incorrect (with the correct answer revealed).
class AnswerFeedbackBanner extends StatelessWidget {
  const AnswerFeedbackBanner({
    super.key,
    required this.isCorrect,
    required this.correctAnswer,
  });

  final bool isCorrect;
  final String correctAnswer;

  @override
  Widget build(BuildContext context) {
    final color = isCorrect ? AppColors.success : AppColors.error;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(isCorrect ? Icons.check_circle : Icons.cancel, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isCorrect ? 'Correct! Well done.' : 'Not quite. The correct answer is $correctAnswer.',
              style: AppTextStyles.bodyMedium(color: color),
            ),
          ),
        ],
      ),
    );
  }
}