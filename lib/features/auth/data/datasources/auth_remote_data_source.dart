import 'dart:convert';

import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/features/auth/domain/usecases/user_login.dart';
import 'package:hms_app/features/auth/domain/usecases/user_sign_up.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> signUp({required UserSignUpParams params});
  Future<Map<String, dynamic>> login({required UserLoginParams params});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiRepository apiRepository;

  AuthRemoteDataSourceImpl(this.apiRepository);
  @override
  Future<void> signUp({required UserSignUpParams params}) async {
    try {
      await apiRepository.post(url: ApiEndpoints.signUpEndpoint, body: params.toMap(), isProtected: false);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> login({required UserLoginParams params}) async {
    try {
      final response =
          await apiRepository.post(url: ApiEndpoints.loginEndpoint, body: params.toMap(), isProtected: false);
      if (jsonDecode(response.body)["data"]["user"]["role"] != "student") {
        throw ServerException("Invalid credentials");
      }
      return jsonDecode(response.body);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
