import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/models/badge_model.dart';
import 'badge_icon_mapper.dart';

/// Large hero display for the most recently earned badge — the
/// "Algebra Master" trophy shown at the top of the Achievements screen.
class FeaturedBadgeDisplay extends StatelessWidget {
  const FeaturedBadgeDisplay({super.key, required this.badge});

  final BadgeModel badge;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFFFD66E), AppColors.accentDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.35),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(badgeIconFor(badge.iconKey), size: 52, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          badge.title,
          style: AppTextStyles.headlineLarge(color: textTheme.headlineLarge?.color),
        ),
        const SizedBox(height: 4),
        Text(
          badge.description,
          style: AppTextStyles.bodyMedium(color: textTheme.bodyMedium?.color),
        ),
      ],
    );
  }
}