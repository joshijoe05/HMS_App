import 'package:flutter/material.dart';
import 'package:hms_app/core/constants/assets.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
