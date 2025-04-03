import 'package:get_it/get_it.dart';
import 'package:hms_app/core/common/provider/user_provider.dart';
import 'package:hms_app/core/network/api_repository.dart';
import 'package:hms_app/core/network/api_repository_impl.dart';
import 'package:hms_app/core/services/notification_service.dart';
import 'package:hms_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hms_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hms_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:hms_app/features/auth/domain/usecases/user_login.dart';
import 'package:hms_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:hms_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:hms_app/features/auth/presentation/provider/hostel_provider.dart';
import 'package:hms_app/features/bus/provider/booking_provider.dart';
import 'package:hms_app/features/bus/provider/bus_form_provider.dart';
import 'package:hms_app/features/bus/provider/bus_provider.dart';
import 'package:hms_app/features/complaints/provider/complaint_provider.dart';
import 'package:hms_app/features/complaints/provider/raise_complaint_provider.dart';
import 'package:hms_app/features/home/provider/home_provider.dart';
import 'package:hms_app/features/notifications/provider/notification_provider.dart';
import 'package:hms_app/features/profile/provider/profile_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferences>(
    () => prefs,
  );
  serviceLocator.registerLazySingleton<NotificationServices>(
    () => NotificationServices(),
  );
  serviceLocator.registerLazySingleton<UserProvider>(
    () => UserProvider(prefs, serviceLocator()),
  );
  serviceLocator.registerFactory<ApiRepository>(
    () => ApiRepositoryImpl(serviceLocator()),
  );
  _initAuth();
  serviceLocator.registerLazySingleton<HomeProvider>(
    () => HomeProvider(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<ComplaintProvider>(
    () => ComplaintProvider(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<RaiseComplaintProvider>(
    () => RaiseComplaintProvider(serviceLocator(), serviceLocator()),
  );
  serviceLocator.registerLazySingleton<ProfileProvider>(
    () => ProfileProvider(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<BusProvider>(
    () => BusProvider(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<BookingProvider>(
    () => BookingProvider(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<NotificationProvider>(
    () => NotificationProvider(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<BusFormProvider>(
    () => BusFormProvider(serviceLocator()),
  );
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
    ..registerFactory<UserLogin>(
      () => UserLogin(serviceLocator()),
    )
    ..registerLazySingleton<HostelProvider>(
      () => HostelProvider(serviceLocator()),
    )
    ..registerLazySingleton<AuthProvider>(
      () => AuthProvider(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
}
