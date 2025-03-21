import 'dart:async';
import 'dart:io';
import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';
import 'package:hms_app/core/common/widgets/back_button.dart';
import 'package:hms_app/core/common/widgets/button.dart';
import 'package:hms_app/core/constants/assets.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MailSentScreen extends StatefulWidget {
  final String email;
  const MailSentScreen({super.key, required this.email});

  @override
  State<MailSentScreen> createState() => _MailSentScreenState();
}

class _MailSentScreenState extends State<MailSentScreen> {
  final appCheck = AppCheck();
  Future<void> _launchGmail() async {
    try {
      if (Platform.isAndroid) {
        await appCheck.checkAvailability("com.google.android.gm").then(
              (app) => appCheck.launchApp(app!.packageName),
            );
      } else if (Platform.isIOS) {
        bool launched = false;
        if (await canLaunchUrl(Uri.parse("googlegmail://"))) {
          await launchUrl(Uri.parse("googlegmail://"));
          launched = true;
        } else if (await canLaunchUrl(Uri.parse("mailto://"))) {
          await launchUrl(Uri.parse("mailto://"));
          launched = true;
        }
        if (!launched) {
          SnackbarService.showSnackbar("Unable to open an email app. Please open manually.");
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // late Timer _timer;

  @override
  void initState() {
    super.initState();
    // _timer = Timer.periodic(
    //   const Duration(seconds: 3),
    //   (timer) {
    //     if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
    //       _timer.cancel();
    //       router.go(Routes.bottomNav);
    //     }
    //   },
    // );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        SnackbarService.showSnackbar("Redirecting to login screen in 15 seconds");
      },
    );
    Future.delayed(Duration(seconds: 5)).then(
      (value) {
        router.go(Routes.login);
      },
    );
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(alignment: Alignment.centerLeft, child: CustomBackButton()),
                (Dimensions.getHeight(context) * 0.1).round().height,
                Image.asset(
                  Assets.mailSent,
                  width: Dimensions.getWidth(context) * 0.7,
                ),
                50.height,
                Text(
                  "Check your email, including your spam folder.We sent a magic link to...",
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.grey500),
                ),
                30.height,
                Text(
                  widget.email,
                  style: textTheme.bodyLarge,
                ),
                50.height,
                CustomButton(
                  onTap: _launchGmail,
                  title: "Open Email App",
                ),
                20.height,
                CustomButton(
                  onTap: () {},
                  color: AppColors.primaryColor50,
                  textColor: AppColors.primaryColor900,
                  title: "Back to Login",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
