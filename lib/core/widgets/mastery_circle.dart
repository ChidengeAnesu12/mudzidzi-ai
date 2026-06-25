import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Circular percentage indicator — "Overall Mastery" on the Dashboard,
/// "Predicted Score" on the Progress screen.
class MasteryCircle extends StatelessWidget {
  const MasteryCircle({
    super.key,
    required this.percent,
    this.label,
    this.size = 140,
    this.progressColor,
    this.centerText,
  });

  final double percent; // 0-100
  final String? label;
  final double size;
  final Color? progressColor;

  /// Overrides the default "NN%" center text — e.g. to show a letter
  /// grade alongside the percentage in Predicted Performance.
  final String? centerText;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return CircularPercentIndicator(
      radius: size / 2,
      lineWidth: size * 0.1,
      percent: percent.clamp(0, 100) / 100,
      animation: true,
      animationDuration: 900,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
      progressColor: progressColor ?? AppColors.primary,
      center: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            centerText ?? '${percent.round()}%',
            style: AppTextStyles.displayMedium(color: textTheme.displayMedium?.color),
          ),
          if (label != null)
            Text(
              label!,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall(color: textTheme.bodySmall?.color),
            ),
        ],
      ),
    );
  }
}