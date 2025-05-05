import 'package:get_it/get_it.dart';
import 'package:split/features/auth/auth_di.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

void registerDependencies({required SupabaseClient supabaseClient}) {
  getIt.registerLazySingleton(() => supabaseClient);
  registerAuthDI();
}
