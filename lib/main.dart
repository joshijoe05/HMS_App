import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/common/pages/connectivity_wrapper.dart';
import 'package:hms_app/core/common/provider/network_provider.dart';
import 'package:hms_app/core/common/provider/user_provider.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/theme/app_theme.dart';
import 'package:hms_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:hms_app/features/auth/presentation/provider/hostel_provider.dart';
import 'package:hms_app/features/bus/provider/booking_provider.dart';
import 'package:hms_app/features/bus/provider/bus_form_provider.dart';
import 'package:hms_app/features/bus/provider/bus_provider.dart';
import 'package:hms_app/features/complaints/provider/complaint_provider.dart';
import 'package:hms_app/features/complaints/provider/raise_complaint_provider.dart';
import 'package:hms_app/features/home/provider/home_provider.dart';
import 'package:hms_app/features/notifications/provider/notification_provider.dart';
import 'package:hms_app/features/profile/provider/profile_provider.dart';
import 'package:hms_app/init_dependencies.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NetworkProvider()),
        ChangeNotifierProvider(create: (context) => serviceLocator<UserProvider>()),
        ChangeNotifierProvider(create: (context) => serviceLocator<HostelProvider>()),
        ChangeNotifierProvider(create: (context) => serviceLocator<AuthProvider>()),
        ChangeNotifierProvider(create: (context) => serviceLocator<HomeProvider>()),
        ChangeNotifierProvider(create: (context) => serviceLocator<ComplaintProvider>()),
        ChangeNotifierProvider(create: (context) => serviceLocator<RaiseComplaintProvider>()),
        ChangeNotifierProvider(create: (context) => serviceLocator<ProfileProvider>()),
        ChangeNotifierProvider(create: (context) => serviceLocator<BusProvider>()),
        ChangeNotifierProvider(create: (context) => serviceLocator<BookingProvider>()),
        ChangeNotifierProvider(create: (context) => serviceLocator<NotificationProvider>()),
        ChangeNotifierProvider(create: (context) => serviceLocator<BusFormProvider>()),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: SnackbarService.messengerKey,
        title: 'Hostel Monitoring System',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeMode,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        builder: (context, child) {
          return ConnectivityWrapper(
            child: EasyLoading.init()(context, child),
          );
        },
      ),
    );
  }
}
