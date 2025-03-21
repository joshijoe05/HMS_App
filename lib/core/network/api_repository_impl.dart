import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hms_app/core/common/provider/user_provider.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/helper/jwt_helper.dart';
import 'package:hms_app/core/helper/snackbar.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:http/http.dart' as http;

import 'api_repository.dart';

class ApiRepositoryImpl implements ApiRepository {
  UserProvider userProvider;
  ApiRepositoryImpl(this.userProvider);
  @override
  Future<http.Response> get({required String url, Map<String, dynamic>? body, bool isProtected = true}) async {
    try {
      final headers = await _getHeaders(isProtected: isProtected);
      final response = await http.get(Uri.parse(url), headers: headers).timeout(const Duration(seconds: 10));
      return _handleResponse(response);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on http.ClientException {
      throw const ServerException("Internal Server Error, Please try again in sometime");
    } on FormatException {
      throw const ServerException("Bad response Format, Please try again");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<http.Response> post({required String url, Map<String, dynamic>? body, bool isProtected = true}) async {
    try {
      final headers = await _getHeaders(isProtected: isProtected);
      final response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));
      return _handleResponse(response);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on http.ClientException {
      throw const ServerException("Internal Server Error, Please try again in sometime");
    } on FormatException {
      throw const ServerException("Bad response Format, Please try again");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<http.Response> put({required String url, Map<String, dynamic>? body, bool isProtected = true}) async {
    try {
      final headers = await _getHeaders(isProtected: isProtected);
      final response =
          await http.put(Uri.parse(url), headers: headers, body: jsonEncode(body)).timeout(const Duration(seconds: 10));
      return _handleResponse(response);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on http.ClientException {
      throw const ServerException("Internal Server Error, Please try again in sometime");
    } on FormatException {
      throw const ServerException("Bad response Format, Please try again");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  http.Response _handleResponse(http.Response response) {
    if (kDebugMode) {
      print(response.body);
      print(response.statusCode);
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw ServerException(jsonDecode(response.body)["message"] ?? "Something went wrong,Please try again");
    }
  }

  Future<Map<String, String>> _getHeaders({bool isProtected = true}) async {
    Map<String, String> headers = {};
    String? accessToken = userProvider.accessToken;
    if (isProtected) {
      if (accessToken == null) {
        SnackbarService.showSnackbar("Session Expired. Please login again");
        router.push(Routes.login);
      }

      if (accessToken!.isNotEmpty && JwtHelper.isTokenExpired(accessToken)) {
        bool isTokenRefreshed = await userProvider.refreshAccessToken();
        if (isTokenRefreshed) {
          accessToken = userProvider.accessToken!;
          headers["Authorization"] = "Bearer $accessToken";
        } else {
          router.go(Routes.login);
          SnackbarService.showSnackbar("Session Expired ! Please login again");
        }
      } else if (accessToken.isNotEmpty && !JwtHelper.isTokenExpired(accessToken)) {
        headers["Authorization"] = "Bearer $accessToken";
      } else if (accessToken.isEmpty) {
        router.go(Routes.login);
        SnackbarService.showSnackbar("Session Expired ! Please login again");
      }
    }
    return headers;
  }
}
