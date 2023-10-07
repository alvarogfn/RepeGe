import 'package:get_it/get_it.dart';
import 'package:repege/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:repege/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:repege/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:repege/src/authentication/domain/usecases/auth_state_changes.dart';
import 'package:repege/src/authentication/domain/usecases/send_email_verification.dart';
import 'package:repege/src/authentication/domain/usecases/signin.dart';
import 'package:repege/src/authentication/domain/usecases/signout.dart';
import 'package:repege/src/authentication/domain/usecases/signup.dart';
import 'package:repege/src/authentication/presentation/cubit/authentication_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthenticationCubit(
        authStateChanges: sl(),
        signup: sl(),
        signin: sl(),
        sendEmailVerification: sl(),
        signout: sl(),
      ));

  sl.registerLazySingleton(() => Signup(sl()));
  sl.registerLazySingleton(() => AuthStateChanges(sl()));
  sl.registerLazySingleton(() => Signin(sl()));
  sl.registerLazySingleton(() => SendEmailVerification(sl()));
  sl.registerLazySingleton(() => Signout(sl()));
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(sl()));
  sl.registerLazySingleton(() => AuthenticationRemoteDataSource());
}
