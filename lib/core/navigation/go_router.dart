import 'package:go_router/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/features/auth/presentation/pages/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
