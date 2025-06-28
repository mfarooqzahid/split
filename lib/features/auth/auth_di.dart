import 'package:split/injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth.dart';

void authDI() {
  getIt
    ..registerLazySingleton(
      () => AuthRepo(supabase: getIt<SupabaseClient>()),
    )
    ..registerFactory(
      () => AuthBloc(authRepo: getIt<AuthRepo>()),
    );
}
