import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/models/topic_model.dart';

/// Hexagonal radar comparing the student's mastery per topic against
/// the class average. Assumes [myMastery] and [classAverageMastery]
/// are the same length and in the same topic order (true for the mock
/// data — both list Numbers, Algebra, Functions, Geometry,
/// Trigonometry, Statistics in that order).
class TopicMasteryRadar extends StatelessWidget {
  const TopicMasteryRadar({
    super.key,
    required this.myMastery,
    required this.classAverageMastery,
  });

  final List<TopicMastery> myMastery;
  final List<TopicMastery> classAverageMastery;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gridColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final titleColor = Theme.of(context).textTheme.bodySmall?.color;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.05,
          child: RadarChart(
            RadarChartData(
              radarShape: RadarShape.polygon,
              radarBackgroundColor: Colors.transparent,
              radarBorderData: BorderSide(color: gridColor),
              gridBorderData: BorderSide(color: gridColor, width: 1),
              tickBorderData: BorderSide(color: gridColor, width: 1),
              tickCount: 4,
              ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 0),
              titlePositionPercentageOffset: 0.16,
              titleTextStyle: AppTextStyles.bodySmall(color: titleColor),
              getTitle: (index, angle) {
                return RadarChartTitle(text: myMastery[index].topicId.displayName);
              },
              dataSets: [
                RadarDataSet(
                  fillColor: AppColors.secondary.withValues(alpha: 0.12),
                  borderColor: AppColors.secondary,
                  borderWidth: 1.5,
                  entryRadius: 0,
                  dataEntries: classAverageMastery
                      .map((t) => RadarEntry(value: t.masteryPercent))
                      .toList(),
                ),
                RadarDataSet(
                  fillColor: AppColors.primary.withValues(alpha: 0.22),
                  borderColor: AppColors.primary,
                  borderWidth: 2,
                  entryRadius: 3,
                  dataEntries:
                      myMastery.map((t) => RadarEntry(value: t.masteryPercent)).toList(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LegendItem(label: 'You', color: AppColors.primary, filled: true),
            SizedBox(width: 20),
            _LegendItem(label: 'Class Average', color: AppColors.secondary, filled: false),
          ],
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.label, required this.color, required this.filled});

  final String label;
  final Color color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodySmall?.color;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? color : Colors.transparent,
            border: Border.all(color: color, width: 1.5),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.bodySmall(color: textColor)),
      ],
    );
  }
}