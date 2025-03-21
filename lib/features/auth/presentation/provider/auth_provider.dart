import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/common/provider/user_provider.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/features/auth/domain/usecases/user_login.dart';
import 'package:hms_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  UserSignUp userSignUp;
  UserProvider userProvider;
  SharedPreferences prefs;
  UserLogin userLogin;
  AuthProvider(
    this.userSignUp,
    this.prefs,
    this.userProvider,
    this.userLogin,
  );

  bool showPassword = false;
  bool showCreatePass = false;
  bool showConfirmPass = false;

  bool showChangePwd1 = false;
  bool showChangePwd2 = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final String hostelId = "";

  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();

  void togglePassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void toggleCreatePass() {
    showCreatePass = !showCreatePass;
    notifyListeners();
  }

  void toggleConfirmPass() {
    showConfirmPass = !showConfirmPass;
    notifyListeners();
  }

  void toggleChangePwd1() {
    showChangePwd1 = !showChangePwd1;
    notifyListeners();
  }

  void toggleChangePwd2() {
    showChangePwd2 = !showChangePwd2;
    notifyListeners();
  }

  Future<void> signUp(bool isSocialLogin) async {
    EasyLoading.show();
    final response = await userSignUp(UserSignUpParams(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      fullName: nameController.text.trim(),
      contactNumber: phoneController.text.trim(),
      hostelId: hostelId,
    ));
    EasyLoading.dismiss();
    response.fold(
      (l) async {
        SnackbarService.showSnackbar(l.message);
      },
      (r) async {
        router.push(Routes.mailSent, extra: emailController.text.trim());
        SnackbarService.showSnackbar("Verification mail sent, please check your mail");
      },
    );
  }

  void clearLoginData() {
    emailLoginController.clear();
    passwordLoginController.clear();
  }

  Future<bool> login() async {
    EasyLoading.show();
    final response = await userLogin(
        UserLoginParams(email: emailLoginController.text.trim(), password: passwordLoginController.text.trim()));
    EasyLoading.dismiss();
    response.fold(
      (l) async {
        SnackbarService.showSnackbar(l.message);
      },
      (r) {
        SnackbarService.showSnackbar("Login Successful");
        prefs.setString("accessToken", r['data']['accessToken']);
        prefs.setString("refreshToken", r['data']['refreshToken']);
        userProvider.loadTokens();
        clearLoginData();
        // router.go(Routes.bottomNav);
        return true;
      },
    );
    return false;
  }
}
