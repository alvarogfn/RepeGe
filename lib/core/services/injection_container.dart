import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:repege/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:repege/src/sheets/data/repositories/sheet_repository_impl.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_bloc.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_list_bloc.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => AuthenticationCubit(sl()));
  sl.registerFactory(() => SheetBloc(sl()));
  sl.registerFactory(() => SheetListBloc(sl()));
  sl.registerFactory(() => SheetUpdateCubit(sl()));

  // Repository
  sl.registerLazySingleton<SheetRepository>(() => SheetRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(firebaseAuth: sl(), firebaseFirestore: sl()),
  );

  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
