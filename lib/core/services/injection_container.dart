import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:repege/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:repege/src/authentication/domain/cubit/authentication_cubit.dart';
import 'package:repege/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:repege/src/campaigns/data/repositories/campaign_repository_impl.dart';
import 'package:repege/src/campaigns/data/repositories/invitation_repository_impl.dart';
import 'package:repege/src/campaigns/domain/bloc/act_bloc.dart';
import 'package:repege/src/campaigns/domain/bloc/campaign_bloc.dart';
import 'package:repege/src/campaigns/domain/bloc/campaigns_bloc.dart';
import 'package:repege/src/campaigns/domain/bloc/invitation_bloc.dart';
import 'package:repege/src/campaigns/domain/repositories/campaign_repository.dart';
import 'package:repege/src/campaigns/domain/repositories/invitation_repository.dart';
import 'package:repege/src/equipments/data/repositories/equipment_repository_impl.dart';
import 'package:repege/src/equipments/domain/bloc/equipment_bloc.dart';
import 'package:repege/src/equipments/domain/repositories/equipment_repository.dart';
import 'package:repege/src/sheets/data/repositories/sheet_repository_impl.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_bloc.dart';
import 'package:repege/src/sheets/domain/bloc/sheet_list_bloc.dart';
import 'package:repege/src/sheets/domain/cubit/sheet_update_cubit.dart';
import 'package:repege/src/sheets/domain/repositories/sheet_repository.dart';
import 'package:repege/src/spells/data/repositories/spell_repository_impl.dart';
import 'package:repege/src/spells/domain/bloc/spell_bloc.dart';
import 'package:repege/src/spells/domain/repositories/spell_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => AuthenticationCubit(sl()));
  sl.registerFactory(() => SheetBloc(sl()));
  sl.registerFactory(() => SheetListBloc(sl()));
  sl.registerFactory(() => SheetUpdateCubit(sl()));
  sl.registerFactory(() => EquipmentBloc(sl()));
  sl.registerFactory(() => SpellBloc(sl()));
  sl.registerFactory(() => CampaignsBloc(sl()));
  sl.registerFactory(() => CampaignBloc(sl()));
  sl.registerFactory(() => ActBloc(sl()));
  sl.registerFactory(() => InvitationBloc(sl()));

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<SheetRepository>(() => SheetRepositoryImpl(sl()));
  sl.registerLazySingleton<EquipmentRepository>(() => EquipmentRepositoryImpl(sl()));
  sl.registerLazySingleton<SpellRepository>(() => SpellRepositoryImpl(sl()));
  sl.registerLazySingleton<CampaignRepository>(() => CampaignRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<InvitationRepository>(() => InvitationRepositoryImpl(sl(), sl()));

  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
