import 'package:hms_app/core/constants/api_endpoints.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/features/auth/domain/usecases/user_sign_up.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> signUp({required UserSignUpParams params});
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
}
