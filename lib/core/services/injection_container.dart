import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:repege/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:repege/src/sheets/data/datasources/sheet_remote_data_source.dart';
import 'package:repege/src/sheets/data/repositories/sheet_repository_impl.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';
import 'package:repege/src/sheets/domain/usecase/create_sheet.dart';
import 'package:repege/src/sheets/domain/usecase/delete_sheet.dart';
import 'package:repege/src/sheets/domain/usecase/edit_sheet.dart';
import 'package:repege/src/sheets/domain/usecase/stream_all_sheets.dart';
import 'package:repege/src/sheets/domain/usecase/stream_sheet.dart';
import 'package:repege/src/sheets/presentation/cubit/sheet_cubit.dart';
import 'package:repege/src/sheets/presentation/cubit/sheet_list_cubit.dart';
import 'package:repege/src/sheets/presentation/cubit/sheets_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthenticationCubit(sl()));

  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance,
    ),
  );

  sl.registerFactory(
    () => SheetsCubit(
      editSheet: sl(),
      createSheet: sl(),
    ),
  );

  sl.registerFactory(
    () => SheetCubit(
      deleteSheet: sl(),
      editSheet: sl(),
      streamSheet: sl(),
    ),
  );

  sl.registerFactory(() => SheetListCubit(streamAllSheets: sl()));

  sl.registerLazySingleton(() => DeleteSheet(sl()));
  sl.registerLazySingleton(() => EditSheet(sl()));
  sl.registerLazySingleton(() => StreamSheet(sl()));
  sl.registerLazySingleton(() => StreamAllSheets(sl()));
  sl.registerLazySingleton(() => CreateSheet(sl()));

  sl.registerLazySingleton<SheetRepository>(() => SheetRepositoryImpl(sl()));
  sl.registerLazySingleton(() => SheetRemoteDataSource());
}
