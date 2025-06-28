import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:split/injection.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:split/routes/app_router.dart';
import 'package:split/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:split/features/features.dart';
import 'core/core.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(
          (await getApplicationDocumentsDirectory()).path));

  Hive.initFlutter();
  Hive.registerAdapter(UserProfileAdapter());

  await dotenv.load();

  final Supabase supabase = await Supabase.initialize(
    url: dotenv.env['SUPABSE_URL'].toString(),
    anonKey: dotenv.env['ANON_KEY'].toString(),
  );

  await registerDependencies(supabaseClient: supabase.client);
  runApp(const SplitApp());

  FlutterNativeSplash.remove();
}

class SplitApp extends StatelessWidget {
  const SplitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LanguageCubit()),
        BlocProvider(create: (_) => GetIt.I<ProfileBloc>()),
        BlocProvider(create: (_) => GetIt.I<GroupsBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              setStatusBarColor(themeMode);

              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('es', ''),
                ],
                locale: locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                routerConfig: goRouter,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
              );
            },
          );
        },
      ),
    );
  }
}
