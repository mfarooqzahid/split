import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:split/core/constants/app_theme.dart';
import 'package:split/core/utils/set_statusbar_color.dart';
import 'package:split/features/profile/widgets/language/language_cubit.dart';
import 'package:split/features/profile/widgets/theme/theme_cubit.dart';
import 'package:split/injection.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:split/routes/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await dotenv.load();

  final Supabase supabase =  await Supabase.initialize(
    url: dotenv.env['SUPABSE_URL'].toString(),
    anonKey: dotenv.env['ANON_KEY'].toString(),
  );

  registerDependencies(supabaseClient: supabase.client);

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
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              setStatusBarColor(context, themeMode);

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
