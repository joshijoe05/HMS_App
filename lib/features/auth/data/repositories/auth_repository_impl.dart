import 'package:fpdart/fpdart.dart';
import 'package:hms_app/core/error/exceptions.dart';
import 'package:hms_app/core/error/failure.dart';
import 'package:hms_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hms_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:hms_app/features/auth/domain/usecases/user_login.dart';
import 'package:hms_app/features/auth/domain/usecases/user_sign_up.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> signUp({required UserSignUpParams params}) async {
    try {
      await remoteDataSource.signUp(params: params);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> login({required UserLoginParams params}) async {
    try {
      final res = await remoteDataSource.login(params: params);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
