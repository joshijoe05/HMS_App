import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/helper/jwt_helper.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;
  SharedPreferences prefs;
  String? userName;

  UserProvider(this.prefs) {
    loadTokens();
  }

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  void loadTokens() {
    _accessToken = prefs.getString("accessToken");
    _refreshToken = prefs.getString("refreshToken");
    notifyListeners();
  }

  Future<void> logout() async {
    EasyLoading.show();
    await Future.delayed(Duration(seconds: 1));
    await prefs.remove("accessToken");
    await prefs.remove("refreshToken");
    EasyLoading.dismiss();
    router.go(Routes.login);
  }

  Future<bool> refreshAccessToken() async {
    if (_refreshToken != null) {
      try {
        final response = await http.post(Uri.parse(ApiEndpoints.refreshAccesstoken),
            body: jsonEncode({"refreshToken": _refreshToken}), headers: {"Content-Type": "application/json"});
        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);
          prefs.setString("accessToken", body["data"]["accessToken"]);
          prefs.setString("refreshToken", body["data"]["refreshToken"]);
          loadTokens();
          return true;
        }
        return false;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> goToHome() async {
    try {
      if (_accessToken != null && !JwtHelper.isTokenExpired(_accessToken!)) {
        return true;
      } else if (_accessToken != null && JwtHelper.isTokenExpired(_accessToken!)) {
        bool isTokenRefreshed = await refreshAccessToken();
        if (isTokenRefreshed) return true;
        return false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
