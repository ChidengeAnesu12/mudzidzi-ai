import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/badge_model.dart';

class MockAchievementsRepository {
  Future<AchievementsSummary> getAchievements() async {
    await Future.delayed(const Duration(milliseconds: 500));

    const featured = BadgeModel(
      id: 'algebra_master',
      title: 'Algebra Master',
      description: 'Score 80% in Algebra',
      iconKey: 'trophy',
      isUnlocked: true,
    );

    return const AchievementsSummary(
      xpTotal: 1240,
      currentStreakDays: 7,
      featuredBadge: featured,
      allBadges: [
        featured,
        BadgeModel(
          id: 'quick_learner',
          title: 'Quick Learner',
          description: 'Answer 20 questions correctly',
          iconKey: 'flash',
          isUnlocked: true,
        ),
        BadgeModel(
          id: 'streak_7',
          title: '7-Day Streak',
          description: 'Study 7 days in a row',
          iconKey: 'flame',
          isUnlocked: true,
        ),
        BadgeModel(
          id: 'dedicated',
          title: 'Dedicated',
          description: 'Study for 5 hours',
          iconKey: 'star',
          isUnlocked: true,
        ),
      ],
    );
  }
}

final mockAchievementsRepositoryProvider = Provider<MockAchievementsRepository>((ref) {
  return MockAchievementsRepository();
});

final achievementsProvider = FutureProvider<AchievementsSummary>((ref) {
  return ref.watch(mockAchievementsRepositoryProvider).getAchievements();
});