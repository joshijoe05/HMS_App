import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hms_app/core/common/widgets/button.dart';
import 'package:hms_app/core/common/widgets/text_button.dart';
import 'package:hms_app/core/common/widgets/text_field.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    authProvider.emailLoginController.addListener(_updateState);
    authProvider.passwordLoginController.addListener(_updateState);
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    authProvider.emailLoginController.removeListener(_updateState);
    authProvider.passwordLoginController.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: textTheme.headlineMedium,
                ),
                10.height,
                Text(
                  "Please fill the below details to enter into the platform.",
                  style: textTheme.bodySmall?.copyWith(fontSize: 15, color: AppColors.grey600),
                ),
                50.height,
                Form(
                  key: _loginKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        heading: "Email",
                        textEditingController: authProvider.emailLoginController,
                        hintText: "Enter email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      20.height,
                      Consumer<AuthProvider>(builder: (context, data, _) {
                        return CustomTextField(
                          heading: "Password",
                          textEditingController: authProvider.passwordLoginController,
                          hintText: "Enter Password",
                          isObscure: !data.showPassword,
                          keyboardType: TextInputType.visiblePassword,
                          suffix: IconButton(
                            onPressed: () {
                              data.togglePassword();
                            },
                            icon: Icon(
                              data.showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              size: 24,
                              color: AppColors.grey600,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    text: "Forgot passworrd ?",
                    onTap: () {
                      // router.push(Routes.forgotPass);
                    },
                  ),
                ),
                (Dimensions.getHeight(context) * 0.3).round().height,
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Don’t have an account? ",
                      style: textTheme.bodyMedium?.copyWith(color: AppColors.grey500),
                      children: [
                        TextSpan(
                          text: "Signup",
                          style: textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor500),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              router.replace(Routes.signUp);
                            },
                        )
                      ],
                    ),
                  ),
                ),
                25.height,
                CustomButton(
                  isEnabled: authProvider.emailLoginController.text.trim().isNotEmpty &&
                      authProvider.passwordLoginController.text.trim().isNotEmpty,
                  onTap: () async {
                    await authProvider.login();
                  },
                  title: "Login",
                ),
                15.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
