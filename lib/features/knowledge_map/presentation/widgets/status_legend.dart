import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Legend explaining the 3 node states shown on the Knowledge Map.
class KnowledgeMapLegend extends StatelessWidget {
  const KnowledgeMapLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lockedColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const _LegendDot(color: AppColors.success, icon: Icons.check, label: 'Completed'),
        const _LegendDot(color: AppColors.primary, icon: Icons.play_arrow_rounded, label: 'In Progress'),
        _LegendDot(color: lockedColor, icon: Icons.lock_outline, label: 'Locked'),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.icon, required this.label});

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodySmall?.color;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1.4),
          ),
          child: Icon(icon, size: 10, color: color),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.bodySmall(color: textColor)),
      ],
    );
  }
}