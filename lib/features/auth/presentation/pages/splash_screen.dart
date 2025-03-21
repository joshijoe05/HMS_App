import 'package:flutter/material.dart';
import 'package:hms_app/core/common/provider/user_provider.dart';
import 'package:hms_app/core/constants/assets.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late UserProvider userProvider;

  Future<void> navigate() async {
    bool goHome = await Future.wait([
      Future.delayed(const Duration(milliseconds: 1500)),
      userProvider.goToHome(),
    ]).then(
      (value) => value[1] as bool,
    );
    if (goHome) {
      router.go(Routes.home);
    } else {
      router.go(Routes.login);
    }
  }

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.rguktLogo,
              width: Dimensions.getWidth(context) * 0.45,
              fit: BoxFit.cover,
            ),
            30.height,
            Text(
              "RGUKT HMS",
              style: textTheme.headlineLarge?.copyWith(
                fontSize: 32,
              ),
            ),
          ],
        )
      ],
    );
  }
}
