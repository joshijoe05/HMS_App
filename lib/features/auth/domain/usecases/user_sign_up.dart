import 'package:fpdart/fpdart.dart';
import 'package:hms_app/core/error/failure.dart';
import 'package:hms_app/core/usecases/usecase.dart';
import 'package:hms_app/features/auth/domain/repositories/auth_repository.dart';

class UserSignUp implements UseCase<void, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, void>> call(UserSignUpParams params) async {
    return await authRepository.signUp(params: params);
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String fullName;
  final String hostelId;
  final String contactNumber;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.contactNumber,
    required this.fullName,
    required this.hostelId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'fullName': fullName,
      'hostelId': hostelId,
      'contactNumber': contactNumber,
    };
  }

  factory UserSignUpParams.fromMap(Map<String, dynamic> map) {
    return UserSignUpParams(
      email: map['email'] as String,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
      hostelId: map['hostelId'] as String,
      contactNumber: map['contactNumber'] as String,
    );
  }
}
