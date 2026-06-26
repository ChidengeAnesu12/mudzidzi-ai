import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/providers/auth_controller.dart';

/// Desktop-only sidebar navigation, matching the Teacher Dashboard
/// mockup. Only "Overview" (this screen) is wired up — the other
/// items are placeholders for future teacher-facing screens, and
/// "Logout" performs a real sign-out via AuthController.
class TeacherSidebar extends ConsumerWidget {
  const TeacherSidebar({super.key, required this.schoolName});

  final String schoolName;

  static const List<({IconData icon, String label})> _navItems = [
    (icon: Icons.dashboard_outlined, label: 'Overview'),
    (icon: Icons.people_outline, label: 'Students'),
    (icon: Icons.bar_chart_outlined, label: 'Performance'),
    (icon: Icons.menu_book_outlined, label: 'Lessons'),
    (icon: Icons.description_outlined, label: 'Reports'),
    (icon: Icons.settings_outlined, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 220,
      color: AppColors.primaryDark,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.school_rounded, color: Colors.white, size: 26),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  schoolName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleLarge(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          for (final item in _navItems)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _SidebarTile(
                icon: item.icon,
                label: item.label,
                isSelected: item.label == 'Overview',
                onTap: item.label == 'Overview'
                    ? null
                    : () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${item.label} coming soon.')),
                        ),
              ),
            ),
          const Spacer(),
          _SidebarTile(
            icon: Icons.logout_rounded,
            label: 'Logout',
            isSelected: false,
            onTap: () {
              ref.read(authControllerProvider.notifier).logout();
              context.goNamed(RouteNames.login);
            },
          ),
        ],
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  const _SidebarTile({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.white.withValues(alpha: 0.12) : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
          child: Row(
            children: [
              Icon(icon, size: 19, color: Colors.white.withValues(alpha: isSelected ? 1 : 0.75)),
              const SizedBox(width: 12),
              Text(
                label,
                style: AppTextStyles.bodyMedium(
                  color: Colors.white.withValues(alpha: isSelected ? 1 : 0.75),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}