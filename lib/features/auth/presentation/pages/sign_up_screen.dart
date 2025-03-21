import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hms_app/core/common/widgets/button.dart';
import 'package:hms_app/core/common/widgets/text_field.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/helper/valid_email.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late AuthProvider authProvider;
  final _signUpKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        authProvider.emailController.addListener(_updateState);
        authProvider.passwordController.addListener(_updateState);
        authProvider.confirmPassController.addListener(_updateState);
      },
    );
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    authProvider.emailController.removeListener(_updateState);
    authProvider.passwordController.removeListener(_updateState);
    authProvider.confirmPassController.removeListener(_updateState);
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
                  "Signup",
                  style: textTheme.headlineMedium,
                ),
                10.height,
                Text(
                  "Please fill the below details to enter into the platform.",
                  style: textTheme.bodySmall?.copyWith(fontSize: 15, color: AppColors.grey600),
                ),
                50.height,
                Form(
                  key: _signUpKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        heading: "Email",
                        textEditingController: authProvider.emailController,
                        hintText: "Enter email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      20.height,
                      Consumer<AuthProvider>(builder: (context, data, _) {
                        return Column(
                          children: [
                            CustomTextField(
                              heading: "Create Password",
                              textEditingController: authProvider.passwordController,
                              hintText: "Enter Password",
                              isObscure: !data.showCreatePass,
                              keyboardType: TextInputType.visiblePassword,
                              suffix: IconButton(
                                onPressed: () {
                                  data.toggleCreatePass();
                                },
                                icon: Icon(
                                  data.showCreatePass ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  size: 24,
                                  color: AppColors.grey600,
                                ),
                              ),
                            ),
                            20.height,
                            CustomTextField(
                              heading: "Confirm Password",
                              textEditingController: authProvider.confirmPassController,
                              hintText: "Enter Password",
                              isObscure: !data.showConfirmPass,
                              keyboardType: TextInputType.visiblePassword,
                              suffix: IconButton(
                                onPressed: () {
                                  data.toggleConfirmPass();
                                },
                                icon: Icon(
                                  data.showConfirmPass ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  size: 24,
                                  color: AppColors.grey600,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                (Dimensions.getHeight(context) * 0.28).round().height,
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: textTheme.bodyMedium?.copyWith(color: AppColors.grey500),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor500),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              router.replace(Routes.login);
                            },
                        )
                      ],
                    ),
                  ),
                ),
                25.height,
                CustomButton(
                  isEnabled: authProvider.emailController.text.trim().isNotEmpty &&
                      authProvider.passwordController.text.trim().isNotEmpty &&
                      authProvider.confirmPassController.text.trim().isNotEmpty,
                  onTap: () {
                    if (authProvider.emailController.text.trim().isValidEmail() == false) {
                      SnackbarService.showSnackbar("The email you entered is invalid !");
                    } else {
                      if (authProvider.passwordController.text.trim() !=
                          authProvider.confirmPassController.text.trim()) {
                        SnackbarService.showSnackbar("Passwords does not match !");
                      } else if (authProvider.passwordController.text.trim().length < 6) {
                        SnackbarService.showSnackbar("Password should be atleast 6 characters");
                      } else {
                        // router.push(Routes.profile);
                      }
                    }
                  },
                  title: "Continue",
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
