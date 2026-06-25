import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/models/dashboard_models.dart';

/// "Continue Learning" card — the most prominent dashboard action,
/// resuming the student's last in-progress lesson.
class ContinueLearningCard extends StatelessWidget {
  const ContinueLearningCard({
    super.key,
    required this.info,
    required this.onContinue,
  });

  final ContinueLearningInfo info;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Continue Learning',
                  style: AppTextStyles.labelMedium(color: Colors.white.withValues(alpha: 0.85)),
                ),
                const SizedBox(height: 6),
                Text(
                  info.lessonTitle,
                  style: AppTextStyles.headlineMedium(color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  'You were here · ${info.progressPercent.round()}% complete',
                  style: AppTextStyles.bodySmall(color: Colors.white.withValues(alpha: 0.85)),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    onPressed: onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      minimumSize: const Size.fromHeight(42),
                    ),
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.show_chart_rounded, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}