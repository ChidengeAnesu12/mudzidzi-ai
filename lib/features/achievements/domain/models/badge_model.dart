class BadgeModel {
  final String id;
  final String title;
  final String description;
  final String iconKey; // mapped to an IconData in the presentation layer
  final bool isUnlocked;

  const BadgeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconKey,
    required this.isUnlocked,
  });
}

class AchievementsSummary {
  final int xpTotal;
  final int currentStreakDays;
  final BadgeModel featuredBadge;
  final List<BadgeModel> allBadges;

  const AchievementsSummary({
    required this.xpTotal,
    required this.currentStreakDays,
    required this.featuredBadge,
    required this.allBadges,
  });
}