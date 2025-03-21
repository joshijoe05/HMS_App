import 'package:go_router/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/features/auth/presentation/pages/home_screen.dart';
import 'package:hms_app/features/auth/presentation/pages/login_screen.dart';
import 'package:hms_app/features/auth/presentation/pages/mail_sent_screen.dart';
import 'package:hms_app/features/auth/presentation/pages/profile_screen.dart';
import 'package:hms_app/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:hms_app/features/auth/presentation/pages/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: Routes.profileSetup,
      builder: (context, state) => const ProfileSetupScreen(),
    ),
    GoRoute(
      path: Routes.mailSent,
      builder: (context, state) {
        final String email = state.extra as String;
        return MailSentScreen(email: email);
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
