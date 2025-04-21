import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void registerDependencies() {
  // GetIt.instance.registerLazySingleton<Future<Supabase>>(
  //   () async => await Supabase.initialize(
  //     url: dotenv.env['SUPABSE_URL'].toString(),
  //     anonKey: dotenv.env['ANON_KEY'].toString(),
  //   ),
  // );
}
