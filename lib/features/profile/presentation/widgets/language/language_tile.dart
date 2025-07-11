import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:split/features/profile/presentation/widgets/language/language_cubit.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, state) {
        return ListTile(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              showDragHandle: false,
              enableDrag: false,
              builder: (context) {
                return Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(12),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              localization.changeLanguage,
                              style: theme.textTheme.bodyLarge!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton.filledTonal(
                            padding: EdgeInsets.zero,
                            splashRadius: 12,
                            constraints: const BoxConstraints(
                              minWidth: 24,
                              minHeight: 24,
                            ),
                            onPressed: context.pop,
                            icon: const Icon(CupertinoIcons.multiply, size: 16),
                          ),
                        ],
                      ),
                      ..._languages.entries.map(
                        (entry) {
                          final languageCode = entry.key;
                          final languageName = entry.value;
                          final isSelected = state.languageCode == languageCode;

                          return ListTile(
                            splashColor: Colors.transparent,
                            title: Text(languageName),
                            trailing: isSelected
                                ? Icon(
                                    CupertinoIcons.check_mark_circled_solid,
                                    color: theme.primaryColor,
                                  )
                                : null,
                            onTap: () {
                              context
                                  .read<LanguageCubit>()
                                  .changeLanguage(languageCode);
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          title: Text(localization.language),
          trailing: Text(
            _languages[state.languageCode] ?? "English",
            style: theme.textTheme.bodyLarge,
          ),
        );
      },
    );
  }
}

Map<String, String> _languages = {
  'en': 'English',
  'es': 'Spanish',
};