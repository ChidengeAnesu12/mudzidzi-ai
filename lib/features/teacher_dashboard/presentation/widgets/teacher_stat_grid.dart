import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/stat_tile.dart';
import '../../domain/models/teacher_dashboard_models.dart';

/// Responsive grid of headline stat cards — 2 columns on phone,
/// 4 columns on desktop.
class TeacherStatGrid extends StatelessWidget {
  const TeacherStatGrid({super.key, required this.summary});

  final TeacherDashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final tiles = [
      StatTile(
        value: '${summary.classAveragePercent.round()}%',
        label: 'Class Average',
        icon: Icons.groups_outlined,
        deltaText: '${summary.classAverageDeltaPercent.round()}% from last week',
        deltaIsPositive: summary.classAverageDeltaPercent >= 0,
      ),
      StatTile(
        value: '${summary.studentsAtRiskCount}',
        label: 'Students At Risk',
        icon: Icons.warning_amber_rounded,
        iconColor: AppColors.error,
      ),
      StatTile(
        value: summary.mostImprovedStudentName,
        label: 'Most Improved',
        icon: Icons.trending_up_rounded,
        iconColor: AppColors.success,
        deltaText: '${summary.mostImprovedDeltaPercent.round()}%',
        deltaIsPositive: true,
      ),
      StatTile(
        value: '${summary.lessonsCompletedThisWeek}',
        label: 'Lessons Completed',
        icon: Icons.menu_book_outlined,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= Breakpoints.desktop;
        final crossAxisCount = isWide ? 4 : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tiles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: isWide ? 1.7 : 1.3,
          ),
          itemBuilder: (context, index) => tiles[index],
        );
      },
    );
  }
}