import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

void registerDependencies() {
  GetIt.instance.registerLazySingleton(
    () => Client()
      ..setEndpoint(dotenv.env['API_ENDPOINT'].toString())
      ..setProject(dotenv.env['APP_ID']),
  );
}
