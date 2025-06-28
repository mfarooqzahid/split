import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:split/features/features.dart';

final getIt = GetIt.instance;

Future<void> registerDependencies(
    {required SupabaseClient supabaseClient}) async {
  // Register supabase client
  getIt.registerLazySingleton(() => supabaseClient);

  // Auth Dependenciees
  authDI();

  // Profile's dependencies
  profileDI();

  // groups dependencies
  groupDI();
}
