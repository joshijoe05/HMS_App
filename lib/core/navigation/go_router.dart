import 'package:go_router/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/features/auth/presentation/pages/home_screen.dart';
import 'package:hms_app/features/auth/presentation/pages/login_screen.dart';
import 'package:hms_app/features/auth/presentation/pages/mail_sent_screen.dart';
import 'package:hms_app/features/auth/presentation/pages/profile_screen.dart';
import 'package:hms_app/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:hms_app/features/auth/presentation/pages/splash_screen.dart';
import 'package:hms_app/features/bus/models/bus_route_model.dart';
import 'package:hms_app/features/bus/pages/bus_routes_page.dart';
import 'package:hms_app/features/bus/pages/passenger_information_page.dart';
import 'package:hms_app/features/bus/pages/payment_validation_page.dart';
import 'package:hms_app/features/complaints/models/complaint_model.dart';
import 'package:hms_app/features/complaints/pages/complaint_detail_page.dart';
import 'package:hms_app/features/complaints/pages/raise_complaint_page.dart';
import 'package:hms_app/features/home/pages/navbar_screen.dart';
import 'package:hms_app/features/profile/pages/profile_page.dart';

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
    GoRoute(
      path: Routes.navScreen,
      builder: (context, state) => const TabScreen(),
    ),
    GoRoute(
        path: Routes.complaintDetail,
        builder: (context, state) {
          final ComplaintModel complaintModel = state.extra as ComplaintModel;
          return ComplaintDetailPage(complaintModel: complaintModel);
        }),
    GoRoute(
      path: Routes.raiseComplaint,
      builder: (context, state) => const RaiseComplaintPage(),
    ),
    GoRoute(
      path: Routes.profile,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: Routes.busRoutes,
      builder: (context, state) => const BusRoutesPage(),
    ),
    GoRoute(
      path: Routes.passengerInfo,
      builder: (context, state) {
        final BusRouteModel bus = state.extra as BusRouteModel;
        return PassengerInformationPage(bus: bus);
      },
    ),
    GoRoute(
      path: "${Routes.paymentValidation}/:id/:lock",
      name: Routes.paymentValidation,
      builder: (context, state) {
        String id = state.pathParameters["id"] as String;
        String lock = state.pathParameters["lock"] as String;
        return PaymentValidationPage(
          transactionId: id,
          lock: lock,
        );
      },
    ),
  ],
  redirect: (context, state) {
    final uri = state.uri;
    if (uri.scheme == "hmsapp") {
      if (uri.path.startsWith('/payment-success')) {
        return "${Routes.paymentValidation}/${uri.pathSegments[1]}/${uri.pathSegments[2]}";
      }
    }
    return null;
  },
);
