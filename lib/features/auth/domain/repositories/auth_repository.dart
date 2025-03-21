import 'package:fpdart/fpdart.dart';
import 'package:hms_app/core/error/failure.dart';
import 'package:hms_app/features/auth/domain/usecases/user_sign_up.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, void>> signUp({required UserSignUpParams params});
}
