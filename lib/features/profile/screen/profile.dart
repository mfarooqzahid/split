import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split/core/widgets/default_styled_container.dart';
import 'package:split/features/profile/widgets/language/language_tile.dart';
import 'package:split/features/profile/widgets/logout/logout_tile.dart';
import 'package:split/features/profile/widgets/theme/theme_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: NotificationListener(
            onNotification: (OverscrollIndicatorNotification notification) {
              notification.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: DefaultStyledContainer(
                child: Column(
                  spacing: 4,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton.filled(
                        onPressed: () {
                          // back to previous screen
                          context.pop();
                        },
                        icon: const Icon(CupertinoIcons.arrow_left),
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.withAlpha(30),
                    ),
                    Column(
                      children: [
                        const Divider(),

                        const ListTile(
                          minVerticalPadding: 0,
                          title: Text("Farooq Zahid"),
                          trailing: Icon(CupertinoIcons.pencil),
                        ),
                        const Divider(),

                        const ListTile(
                          minVerticalPadding: 0,
                          title: Text("farooq@gmail.com"),
                          trailing: Icon(CupertinoIcons.mail),
                        ),
                        const Divider(),
                        const ThemeTile(),
                        const Divider(),
                        const LanguageTile(),
                        const Divider(),
                        // ListTile(
                        //   title: Text(localization.currentRoom),
                        //   trailing: const Icon(CupertinoIcons.forward),
                        // ),
                        // const Divider(),
                        // ListTile(
                        //   minVerticalPadding: 0,
                        //   title: Text(localization.changePassword),
                        //   trailing: const Icon(
                        //     CupertinoIcons.lock,
                        //   ),
                        // ),
                        // const Divider(),
                        const LogoutTile(),
                        const Divider(),
                        ListTile(
                          minVerticalPadding: 0,
                          title: Text(localization.deleteAccount),
                          trailing: Icon(
                            CupertinoIcons.delete,
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
