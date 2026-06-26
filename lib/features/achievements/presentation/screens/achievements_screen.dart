import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/responsive_center.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/stat_tile.dart';
import '../../data/mock_achievements_repository.dart';
import '../../domain/models/badge_model.dart';
import '../widgets/badge_list_tile.dart';
import '../widgets/featured_badge_display.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementsAsync = ref.watch(achievementsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Achievements')),
      body: SafeArea(
        child: ResponsiveCenter(
          child: AsyncValueWidget<AchievementsSummary>(
            value: achievementsAsync,
            onRetry: () => ref.invalidate(achievementsProvider),
            data: (summary) {
              // Featured badge already gets the hero treatment above —
              // exclude it from the list below to avoid showing it twice.
              final otherBadges =
                  summary.allBadges.where((b) => b.id != summary.featuredBadge.id).toList();

              return ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  FeaturedBadgeDisplay(badge: summary.featuredBadge),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: StatTile(
                          value: '${summary.xpTotal}',
                          label: 'Total XP',
                          icon: Icons.bolt_rounded,
                          iconColor: AppColors.accent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatTile(
                          value: '${summary.currentStreakDays} days',
                          label: 'Current Streak',
                          icon: Icons.local_fire_department_rounded,
                          iconColor: AppColors.accentDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const SectionHeader(title: 'All Badges'),
                  const SizedBox(height: 14),
                  ...otherBadges.map((badge) => BadgeListTile(badge: badge)),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Full badge catalog coming soon.')),
                        );
                      },
                      child: const Text('View All Badges'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}