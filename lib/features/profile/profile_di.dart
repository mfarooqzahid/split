import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:split/injection.dart';

import 'profile.dart';

void profileDI(){
  getIt..registerLazySingleton(
        () => ProfileRemoteDataSourceImpl(client: getIt<SupabaseClient>()))
    ..registerLazySingleton<ProfileLocalDataSourceImpl>(
        () => ProfileLocalDataSourceImpl())
    ..registerLazySingleton(() => ProfileRepositoryImpl(
          localDataSource: getIt<ProfileLocalDataSourceImpl>(),
          remoteDataSource: getIt<ProfileRemoteDataSourceImpl>(),
        ))
    ..registerFactory(
        () => ProfileBloc(profileRepository: getIt<ProfileRepositoryImpl>()));
}