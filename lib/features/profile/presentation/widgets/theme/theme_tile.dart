import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/l10n/app_localizations.dart';
import 'package:split/features/profile/presentation/widgets/theme/theme_cubit.dart';

class ThemeTile extends StatefulWidget {
  const ThemeTile({super.key});

  @override
  State<ThemeTile> createState() => _ThemeTileState();
}

class _ThemeTileState extends State<ThemeTile> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return ListTile(
          title: Text(localization.theme),
          trailing: CupertinoSwitch(
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              context.read<ThemeCubit>().toggleTheme(value);
            },
          ),
          minVerticalPadding: 0,
        );
      },
    );
  }
}
