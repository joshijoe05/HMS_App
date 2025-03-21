import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/common/pages/connectivity_wrapper.dart';
import 'package:hms_app/core/common/provider/network_provider.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NetworkProvider()),
      ],
      child: MaterialApp.router(
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
