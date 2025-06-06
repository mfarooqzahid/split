import 'package:get_it/get_it.dart';
import 'package:split/features/auth/bloc/auth_bloc.dart';
import 'package:split/features/auth/repository/auth_repo.dart';
import 'package:split/features/profile/data/data_sources/profile_local_datasource.dart';
import 'package:split/features/profile/data/data_sources/profile_remote_datasource.dart';
import 'package:split/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:split/features/profile/data/repository/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> registerDependencies({required SupabaseClient supabaseClient}) async {
  getIt

    // Register supabase client
    ..registerLazySingleton(() => supabaseClient)

    // Auth Dependenciees
    ..registerLazySingleton(() => AuthRepo(supabase: GetIt.I<SupabaseClient>()))
    ..registerFactory(() => AuthBloc(authRepo: GetIt.I<AuthRepo>()))

    // Profile's dependencies
    ..registerLazySingleton(
        () => ProfileRemoteDataSourceImpl(client: GetIt.I<SupabaseClient>()))
    ..registerSingletonAsync<ProfileLocalDataSourceImpl>(
      () async {
        final localDataSource = ProfileLocalDataSourceImpl();
        await localDataSource.init(); // Await the initialization
        return localDataSource;
      },
    );
  await GetIt.I.allReady();
  getIt
    ..registerLazySingleton(() => ProfileRepositoryImpl(
          localDataSource: GetIt.I<ProfileLocalDataSourceImpl>(),
          remoteDataSource: GetIt.I<ProfileRemoteDataSourceImpl>(),
        ))
    ..registerFactory(
        () => ProfileBloc(profileRepository: GetIt.I<ProfileRepositoryImpl>()));
}
