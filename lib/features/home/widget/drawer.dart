import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  // TODO: handle create group functionality
                },
                title: Text(localization.createGroup),
                leading: const Icon(CupertinoIcons.plus),
              ),
              ListTile(
                onTap: () {
                  // TODO: handle join group functionality
                },
                title: Text(localization.joinGroup),
              leading: Icon(CupertinoIcons.person_2),
              ),

              // TODO: Display the user's groups
              const Spacer(),
              // GO to [ProfileScreen]
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  context.goNamed('profile');
                },
                leading: const CircleAvatar(),
                title: Text(
                  "Farooq Zahid",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(CupertinoIcons.forward),
              )
            ],
          ),
        ),
      ),
    );
  }
}
