import 'package:get_it/get_it.dart';
import 'package:split/features/auth/bloc/auth_bloc.dart';
import 'package:split/features/auth/repository/auth_repo.dart';
import 'package:split/injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void registerAuthDI() {
  getIt
    ..registerLazySingleton(
      () => AuthRepo(supabase: GetIt.I<SupabaseClient>()),
    )
    ..registerFactory(
      () => AuthBloc(authRepo: GetIt.I<AuthRepo>()),
    );
}
