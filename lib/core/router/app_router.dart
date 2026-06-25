import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/learning_session/presentation/screens/learning_session_screen.dart';
import '../../shared/models/topic_model.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../widgets/placeholder_screen.dart';
import '../widgets/main_shell.dart';
import 'route_names.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.splashPath,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RouteNames.splashPath,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.loginPath,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.registerPath,
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteNames.forgotPasswordPath,
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Bottom-nav shell: Dashboard / Learn / Progress / Profile
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
         StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.dashboardPath,
                name: RouteNames.dashboard,
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.learnPath,
                name: RouteNames.learn,
                builder: (context, state) => const PlaceholderScreen(label: 'Learn'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.progressPath,
                name: RouteNames.progress,
                builder: (context, state) => const PlaceholderScreen(label: 'Progress'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.profilePath,
                name: RouteNames.profile,
                builder: (context, state) => const PlaceholderScreen(label: 'Profile'),
              ),
            ],
          ),
        ],
      ),

      // Full-screen pushed routes (outside bottom nav)
      GoRoute(
        path: RouteNames.learningSessionPath,
        name: RouteNames.learningSession,
        builder: (context, state) {
          final topicId = state.extra is TopicId ? state.extra as TopicId : TopicId.algebra;
          return LearningSessionScreen(topicId: topicId);
        },
      ),
      GoRoute(
        path: RouteNames.aiTutorPath,
        name: RouteNames.aiTutor,
        builder: (context, state) => const PlaceholderScreen(label: 'AI Tutor'),
      ),
      GoRoute(
        path: RouteNames.knowledgeMapPath,
        name: RouteNames.knowledgeMap,
        builder: (context, state) => const PlaceholderScreen(label: 'Knowledge Map'),
      ),
      GoRoute(
        path: RouteNames.achievementsPath,
        name: RouteNames.achievements,
        builder: (context, state) => const PlaceholderScreen(label: 'Achievements'),
      ),
      GoRoute(
        path: RouteNames.teacherDashboardPath,
        name: RouteNames.teacherDashboard,
        builder: (context, state) => const PlaceholderScreen(label: 'Teacher Dashboard'),
      ),
    ],
  );
});