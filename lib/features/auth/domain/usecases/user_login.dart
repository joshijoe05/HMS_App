import 'package:fpdart/fpdart.dart';
import 'package:hms_app/core/error/failure.dart';
import 'package:hms_app/core/usecases/usecase.dart';
import 'package:hms_app/features/auth/domain/repositories/auth_repository.dart';

class UserLogin implements UseCase<void, UserLoginParams> {
  AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(UserLoginParams params) async {
    return await authRepository.login(params: params);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }
}
