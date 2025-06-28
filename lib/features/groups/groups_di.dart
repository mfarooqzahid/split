import 'package:split/features/groups/data/data_sources/group_remote_datasource.dart';
import 'package:split/features/groups/data/repository/group_repository.dart';
import 'package:split/features/groups/presentation/bloc/groups_bloc.dart';
import 'package:split/injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void groupDI() {
  getIt
    ..registerLazySingleton(
      () => GroupRemoteDatasourceImpl(client: getIt<SupabaseClient>()),
    )
    ..registerLazySingleton(
      () => GroupRepositoryImpl(
          groupRemoteDatasource: getIt<GroupRemoteDatasourceImpl>()),
    )
    ..registerFactory(
      () => GroupsBloc(repository: getIt<GroupRepositoryImpl>()),
    );
}
