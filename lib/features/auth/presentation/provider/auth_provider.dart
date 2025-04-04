import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/common/provider/user_provider.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/core/services/notification_service.dart';
import 'package:hms_app/features/auth/domain/entities/hostel_entity.dart';
import 'package:hms_app/features/auth/domain/usecases/user_login.dart';
import 'package:hms_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:hms_app/features/auth/presentation/provider/hostel_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  UserSignUp userSignUp;
  UserProvider userProvider;
  SharedPreferences prefs;
  UserLogin userLogin;
  HostelProvider hostelProvider;
  NotificationServices notificationServices;
  AuthProvider(
    this.userSignUp,
    this.prefs,
    this.userProvider,
    this.userLogin,
    this.hostelProvider,
    this.notificationServices,
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
  HostelEntity? selectedHostel;

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

  void onHostelChanged(String? hostel) {
    selectedHostel = hostelProvider.hostels.firstWhere((element) => element.name == hostel);
    notifyListeners();
  }

  Future<void> initialize() async {
    await hostelProvider.getAllHostels();
    notifyListeners();
  }

  Future<void> signUp() async {
    EasyLoading.show();
    final response = await userSignUp(UserSignUpParams(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      fullName: nameController.text.trim(),
      contactNumber: phoneController.text.trim(),
      hostelId: selectedHostel!.id,
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
        prefs.setString("name", r['data']['user']['fullName']);
        prefs.setString("email", r['data']['user']['email']);
        prefs.setString("hostelId", r['data']['user']['hostelId']);
        userProvider.loadTokens();
        clearLoginData();
        notificationServices.subscribeToHostelNoti();
        router.go(Routes.navScreen);
        return true;
      },
    );
    return false;
  }
}
