import 'package:get_it/get_it.dart';
import 'package:hms_app/core/common/provider/user_provider.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/core/network/api_repository_impl.dart';
import 'package:hms_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hms_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hms_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:hms_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:hms_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferences>(
    () => prefs,
  );
  serviceLocator.registerLazySingleton<UserProvider>(
    () => UserProvider(prefs),
  );
  serviceLocator.registerFactory<ApiRepository>(
    () => ApiRepositoryImpl(serviceLocator()),
  );
  _initAuth();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    ..registerFactory<UserSignUp>(
      () => UserSignUp(serviceLocator()),
    )
    ..registerLazySingleton<AuthProvider>(
      () => AuthProvider(
        serviceLocator(),
      ),
    );
}
